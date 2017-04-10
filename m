Return-Path: <ksiva@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1w2m1jgWzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:03:28 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3AFwdCm112536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 12:03:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rbfp62tj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 12:03:25 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ksiva@linux.vnet.ibm.com>;
 Mon, 10 Apr 2017 10:03:24 -0600
Subject: Re: [PATCH] ibmveth: Support to enable LSO/CSO for Trunk VEA.
To: David Miller <davem@davemloft.net>
References: <1491559079-10855-1-git-send-email-ksiva@linux.vnet.ibm.com>
 <20170408.114515.1339820744697810446.davem@davemloft.net>
Cc: netdev@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 brking@linux.vnet.ibm.com, seroyer@linux.vnet.ibm.com
From: Sivakumar Krishnasamy <ksiva@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 21:33:13 +0530
MIME-Version: 1.0
In-Reply-To: <20170408.114515.1339820744697810446.davem@davemloft.net>
Content-Type: multipart/alternative;
 boundary="------------95733C3FB7B4AE36718F6D9D"
Message-Id: <ffdcd6e6-9eab-99e3-543e-9f808c50e268@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------95733C3FB7B4AE36718F6D9D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Let me give some background before I answer your queries.

In IBM PowerVM environment, ibmveth driver supports largesend and 
checksum offload today, but only for virtual ethernet adapters (VEA) 
which are *not *configured in "Trunk mode".  In trunk mode, one cannot 
enable checksum and largesend offload capabilities. Without these 
offloads enabled, the performance numbers are not good. This patch is to 
enable these offloads for "Trunk" VEAs.

The following shows a typical configuration for network packet flow, 
when VMs in the PowerVM server have their network virtualized and 
communicate to external world.

         VM (ibmveth) <-> PowerVM Hypervisor <-> PowerVM I/O Server VM ( 
ibmveth in "Trunk mode" <-> OVS <-> Physical NIC ) <->  External Network

As you can see the packets originating in VM will travel through local 
ibmveth driver and then to PowerVM Hypervisor, then it gets delivered to 
ibmveth driver configured in "Trunk" mode in I/O Server, which is then 
bridged by OVS to external network via Physical NIC.  To have largesend 
and checksum offload enabled end to end, from VM up to Physical NIC, 
ibmveth needs to support these offload capabilities when configured in 
"Trunk" mode too.

Before this patch, when a VM communicates with external network (in a 
configuration similar to above), throughput numbers were not so good 
(~1.5 Gbps) and with the patch, I see ~9.4 Gbps throughput for a 10G NIC 
(iperf used for measurements).

On 4/9/2017 12:15 AM, David Miller wrote:
> From: Sivakumar Krishnasamy <ksiva@linux.vnet.ibm.com>
> Date: Fri,  7 Apr 2017 05:57:59 -0400
>
>> Enable largesend and checksum offload for ibmveth configured in trunk mode.
>> Added support to SKB frag_list in TX path by skb_linearize'ing such SKBs.
>>
>> Signed-off-by: Sivakumar Krishnasamy <ksiva@linux.vnet.ibm.com>
> Why is linearization necessary?
>
> It would seem that the gains you get from GRO are nullified by
> linearizing the SKB and thus copying all the data around and
> allocating buffers.
When Physical NIC has GRO enabled and when OVS bridges these packets, 
OVS vport send code will end up calling /dev_queue_xmit/, which in turn 
calls /validate_xmit_skb/.

/validate_xmit_skb/ has the below code snippet,

    /if (netif_needs_gso(skb, features)) {//
    //    struct sk_buff *segs;//
    //
    //    segs = skb_gso_segment(skb, features); /<=== Segments the GSO
    packet into MTU sized segments.

When the OVS outbound vport is ibmveth, /netif_needs_gso/ returns 
positively if the SKB has a /frag_list/ and if the driver doesn't 
support the same (NETIF_F_FRAGLIST feature).  So all the packets 
received by ibmveth are of MSS size (or lesser) due to the above code.

On a 10G physical NIC, the maximum throughput achieved was 2.2 Gbps due 
to the above segmentation in /validate_xmit_skb/. With the patch to 
linearize the SKB, the throughput increased to 9 Gbps (and ibmveth 
received packets without being segmented). This is ~4X improvement even 
though we end up allocating buffers and copying data.
>
> Finally, all of that new checksumming stuff looks extremely
> suspicious.  You have to explain why that is happening and why it
> isn't because this driver is doing something incorrectly.
>
> Thanks.
>
We are now enabling support for OVS and improving bridging performance 
in IBM's PowerVM environment, which brings in these new offload 
requirements for ibmveth driver configured in Trunk mode.

Please let me know if you need more details.

--------------95733C3FB7B4AE36718F6D9D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Let me give some background before I answer your queries. <br>
      <br>
      In IBM PowerVM environment, ibmveth driver supports largesend and
      checksum offload today, but only for virtual ethernet adapters
      (VEA) which are <b>not </b>configured in "Trunk mode".  In trunk
      mode, one cannot enable checksum and largesend offload
      capabilities. Without these offloads enabled, the performance
      numbers are not good. This patch is to enable these offloads for
      "Trunk" VEAs. <br>
      <br>
      The following shows a typical configuration for network packet
      flow, when VMs in the PowerVM server have their network
      virtualized and communicate to external world. <br>
    </p>
    <p>        VM (ibmveth) &lt;-&gt; PowerVM Hypervisor &lt;-&gt; 
      PowerVM I/O Server VM ( ibmveth in "Trunk mode" &lt;-&gt; OVS
      &lt;-&gt; Physical NIC ) &lt;-&gt;  External Network <br>
      <br>
      As you can see the packets originating in VM will travel through
      local ibmveth driver and then to PowerVM Hypervisor, then it gets
      delivered to ibmveth driver configured in "Trunk" mode in I/O
      Server, which is then bridged by OVS to external network via
      Physical NIC.  To have largesend and checksum offload enabled end
      to end, from VM up to Physical NIC, ibmveth needs to support these
      offload capabilities when configured in "Trunk" mode too. <br>
      <br>
      Before this patch, when a VM communicates with external network
      (in a configuration similar to above), throughput numbers were not
      so good (~1.5 Gbps) and with the patch, I see ~9.4 Gbps throughput
      for a 10G NIC (iperf used for measurements).<br>
    </p>
    On 4/9/2017 12:15 AM, David Miller wrote:<br>
    <blockquote
      cite="mid:20170408.114515.1339820744697810446.davem@davemloft.net"
      type="cite">
      <pre wrap="">From: Sivakumar Krishnasamy <a class="moz-txt-link-rfc2396E" href="mailto:ksiva@linux.vnet.ibm.com">&lt;ksiva@linux.vnet.ibm.com&gt;</a>
Date: Fri,  7 Apr 2017 05:57:59 -0400

</pre>
      <blockquote type="cite">
        <pre wrap="">Enable largesend and checksum offload for ibmveth configured in trunk mode.
Added support to SKB frag_list in TX path by skb_linearize'ing such SKBs.

Signed-off-by: Sivakumar Krishnasamy <a class="moz-txt-link-rfc2396E" href="mailto:ksiva@linux.vnet.ibm.com">&lt;ksiva@linux.vnet.ibm.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="">
Why is linearization necessary?

It would seem that the gains you get from GRO are nullified by
linearizing the SKB and thus copying all the data around and
allocating buffers.</pre>
    </blockquote>
    When Physical NIC has GRO enabled and when OVS bridges these
    packets, OVS vport send code will end up calling <i>dev_queue_xmit</i>,
    which in turn calls <i>validate_xmit_skb</i>.<br>
    <br>
    <i>validate_xmit_skb</i> has the below code snippet,<br>
    <blockquote><i>if (netif_needs_gso(skb, features)) {</i><i><br>
      </i><i>    struct sk_buff *segs;</i><i><br>
      </i><i><br>
      </i><i>    segs = skb_gso_segment(skb, features);     </i>&lt;===
      Segments the GSO packet into MTU sized segments.<br>
    </blockquote>
    When the OVS outbound vport is ibmveth, <i>netif_needs_gso</i>
    returns positively if the SKB has a <i>frag_list</i> and if the
    driver doesn't support the same (NETIF_F_FRAGLIST feature).  So all
    the packets received by ibmveth are of MSS size (or lesser) due to
    the above code. <br>
    <br>
    On a 10G physical NIC, the maximum throughput achieved was 2.2 Gbps
    due to the above segmentation in <i>validate_xmit_skb</i>. With the
    patch to linearize the SKB, the throughput increased to 9 Gbps (and
    ibmveth received packets without being segmented). This is ~4X
    improvement even though we end up allocating buffers and copying
    data. <br>
    <blockquote
      cite="mid:20170408.114515.1339820744697810446.davem@davemloft.net"
      type="cite">
      <pre wrap="">

Finally, all of that new checksumming stuff looks extremely
suspicious.  You have to explain why that is happening and why it
isn't because this driver is doing something incorrectly.

Thanks.

</pre>
    </blockquote>
    We are now enabling support for OVS and improving bridging
    performance in IBM's PowerVM environment, which brings in these new
    offload requirements for ibmveth driver configured in Trunk mode. <br>
    <br>
    Please let me know if you need more details.
  </body>
</html>

--------------95733C3FB7B4AE36718F6D9D--
