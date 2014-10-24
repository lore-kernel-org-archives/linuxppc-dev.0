Return-Path: <Jianhua.Xie@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF3941A032C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 23:46:29 +1100 (AEDT)
Message-ID: <544A420E.4000103@freescale.com>
Date: Fri, 24 Oct 2014 20:11:58 +0800
From: Jianhua Xie <jianhua.xie@freescale.com>
MIME-Version: 1.0
To: "Kokoris, Ioannis" <ioannis.kokoris@unify.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] ucc_geth: invalid rx checksum error values
References: <FDB831DFAAC88B42A50BA37D1BC5E13A29C63D1F@MCHP03MSX.global-ad.net>
In-Reply-To: <FDB831DFAAC88B42A50BA37D1BC5E13A29C63D1F@MCHP03MSX.global-ad.net>
Content-Type: multipart/alternative;
 boundary="------------000209050909000306030905"
Cc: Zhao Qiang <B45475@freescale.com>, netdev@vger.kernel.org,
 Timur Tabi <timur@tabi.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------000209050909000306030905
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ioannis ,

Thank you very much for finding and reporting the issue.
I help to broadcast to netdev mailing-list.

Thanks & Best Regards,
Jianhua

在 2014年10月22日 21:07, Kokoris, Ioannis 写道:
> Hi,
>
> The value in QE UCC ethernet interfaces shows random values:
>
> # ethtool -S eth0
> NIC statistics:
>       ...
>       rx-ip-checksum-errors: 3933892214
>
> The problem is located in a mismatch between the rx_fw_stat_gstrings fields
> - used in ucc_geth_ethtool - and the ucc_geth_rx_firmware_statistics_pram
> fields - used in ucc_geth.
> Although the QE UCC Ethernet Controller includes the Rx checksum error
> counter in the 'Rx firmware counters', the related field is missing from the
> ucc_geth driver.
> After adding the RxChecksumError field in
> ucc_geth_rx_firmware_statistics_pram structure the counter works fine.
>
>
>
> Signed-off-by: Ioannis Kokkoris <ioannis.kokoris@unify.com>
>
>
> diff -Nru a/drivers/net/ethernet/freescale/ucc_geth.h
> b/drivers/net/ethernet/freescale/ucc_geth.h
> --- a/drivers/net/ethernet/freescale/ucc_geth.h 2014-10-22
> 15:19:16.000000000 +0300
> +++ b/drivers/net/ethernet/freescale/ucc_geth.h 2014-10-22
> 15:24:39.000000000 +0300
> @@ -541,6 +541,8 @@
>                                     replaced */
>          u32 insertvlan;         /* total frames that had their VLAN tag
>                                     inserted */
> +       u32 checksumerr;        /* total frames that have IP Checksum Error
> +                                */
>   } __packed;
>
>   struct ucc_geth_rx_interrupt_coalescing_entry {
>
>
>
> Best Regards,
> Ioannis
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------000209050909000306030905
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Ioannis
    ,<br>
    <br>
    Thank you very much for finding and reporting the issue.<br>
    I help to broadcast to netdev mailing-list.<br>
    <br>
    Thanks &amp; Best Regards,<br>
    Jianhua<br>
    <br>
    <div class="moz-cite-prefix">在 2014年10月22日 21:07, Kokoris, Ioannis
      写道:<br>
    </div>
    <blockquote
cite="mid:FDB831DFAAC88B42A50BA37D1BC5E13A29C63D1F@MCHP03MSX.global-ad.net"
      type="cite">
      <pre wrap="">Hi, 

The value in QE UCC ethernet interfaces shows random values:

# ethtool -S eth0
NIC statistics:
     ...
     rx-ip-checksum-errors: 3933892214

The problem is located in a mismatch between the rx_fw_stat_gstrings fields
- used in ucc_geth_ethtool - and the ucc_geth_rx_firmware_statistics_pram
fields - used in ucc_geth.
Although the QE UCC Ethernet Controller includes the Rx checksum error
counter in the 'Rx firmware counters', the related field is missing from the
ucc_geth driver.  
After adding the RxChecksumError field in
ucc_geth_rx_firmware_statistics_pram structure the counter works fine.



Signed-off-by: Ioannis Kokkoris <a class="moz-txt-link-rfc2396E" href="mailto:ioannis.kokoris@unify.com">&lt;ioannis.kokoris@unify.com&gt;</a>


diff -Nru a/drivers/net/ethernet/freescale/ucc_geth.h
b/drivers/net/ethernet/freescale/ucc_geth.h
--- a/drivers/net/ethernet/freescale/ucc_geth.h 2014-10-22
15:19:16.000000000 +0300
+++ b/drivers/net/ethernet/freescale/ucc_geth.h 2014-10-22
15:24:39.000000000 +0300
@@ -541,6 +541,8 @@
                                   replaced */
        u32 insertvlan;         /* total frames that had their VLAN tag
                                   inserted */
+       u32 checksumerr;        /* total frames that have IP Checksum Error
+                                */
 } __packed;

 struct ucc_geth_rx_interrupt_coalescing_entry {



Best Regards,
Ioannis
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------000209050909000306030905--
