Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B1C12C0291
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 14:49:58 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Mon, 4 Feb 2013 09:17:11 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C768C125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 09:20:24 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r143nnGe13566132
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Feb 2013 09:19:49 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r143noVc026625
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Feb 2013 14:49:50 +1100
Message-ID: <510F2FDB.6020303@linux.vnet.ibm.com>
Date: Mon, 04 Feb 2013 11:49:47 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 0/3] Enable multiple MSI feature in pSeries
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1359948180.25414.11.camel@concordia>
In-Reply-To: <1359948180.25414.11.camel@concordia>
Content-Type: multipart/alternative;
 boundary="------------010903020304020801040503"
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010903020304020801040503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> On Tue, 2013-01-15 at 15:38 +0800, Mike Qiu wrote:
>> Currently, multiple MSI feature hasn't been enabled in pSeries,
>> These patches try to enbale this feature.
> Hi Mike,
>
>> These patches have been tested by using ipr driver, and the driver patch
>> has been made by Wen Xiong <wenxiong@linux.vnet.ibm.com>:
> So who wrote these patches? Normally we would expect the original author
> to post the patches if at all possible.
Hi Michael

These Multiple MSI patches were wrote by myself, you know this feature 
has not enabled
and it need device driver to test whether it works suitable. So I test 
my patches use
Wen Xiong's ipr patches, which has been send out to the maillinglist.

I'm the**original author :)
>
>> [PATCH 0/7] Add support for new IBM SAS controllers
> I would like to see the full series, including the driver enablement.
Yep, but the driver patches were wrote by Wen Xiong and has been send out.
I just use her patches to test my patches. all device support Multiple MSI
can use my feature not only IBM SAS controllers, I also test my patches use
the broadcom wireless card tg3, and also works OK.
>
>> Test platform: One partition of pSeries with one cpu core(4 SMTs) and
>>                 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) in POWER7
>> OS version: SUSE Linux Enterprise Server 11 SP2  (ppc64) with 3.8-rc3 kernel
>>
>> IRQ 21 and 22 are assigned to the ipr device which support 2 mutiple MSI.
>>
>> The test results is shown by 'cat /proc/interrups':
>>            CPU0       CPU1       CPU2       CPU3
>> 21:          6          5          5          5      XICS Level     host1-0
>> 22:        817        814        816        813      XICS Level     host1-1
> This shows that you are correctly configuring two MSIs.
>
> But the key advantage of using multiple interrupts is to distribute load
> across CPUs and improve performance. So I would like to see some
> performance numbers that show that there is a real benefit for all the
> extra complexity in the code.
Yes, the system just has suport two MSIs. Anyway, I will try to do some 
proformance
test, to show the real benefit.
But actually it needs the driver to do so. As the data show above, it 
seems there is
some problems in use the interrupt, the irq 21 use few, most use 22, I 
will discuss
with the driver author to see why and if she fixed, I will give out the 
proformance
result.

Thanks

Mike

>
> cheers
>


--------------010903020304020801040503
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <blockquote cite="mid:1359948180.25414.11.camel@concordia"
      type="cite">
      <pre wrap="">On Tue, 2013-01-15 at 15:38 +0800, Mike Qiu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Currently, multiple MSI feature hasn't been enabled in pSeries,
These patches try to enbale this feature.
</pre>
      </blockquote>
      <pre wrap="">
Hi Mike,

</pre>
      <blockquote type="cite">
        <pre wrap="">These patches have been tested by using ipr driver, and the driver patch
has been made by Wen Xiong <a class="moz-txt-link-rfc2396E" href="mailto:wenxiong@linux.vnet.ibm.com">&lt;wenxiong@linux.vnet.ibm.com&gt;</a>:
</pre>
      </blockquote>
      <pre wrap="">
So who wrote these patches? Normally we would expect the original author
to post the patches if at all possible.</pre>
    </blockquote>
    Hi Michael<br>
    <br>
    These Multiple MSI patches were wrote by myself, you know this
    feature has not enabled<br>
    and it need device driver to test whether it works suitable. So I
    test my patches use <br>
    Wen Xiong's ipr patches, which has been send out to the
    maillinglist.<br>
    <br>
    I'm the<strong> </strong>original author :)<br>
    <blockquote cite="mid:1359948180.25414.11.camel@concordia"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">[PATCH 0/7] Add support for new IBM SAS controllers
</pre>
      </blockquote>
      <pre wrap="">
I would like to see the full series, including the driver enablement.</pre>
    </blockquote>
    Yep, but the driver patches were wrote by Wen Xiong and has been
    send out.<br>
    I just use her patches to test my patches. all device support
    Multiple MSI<br>
    can use my feature not only IBM SAS controllers, I also test my
    patches use <br>
    the broadcom wireless card tg3, and also works OK.<br>
    <blockquote cite="mid:1359948180.25414.11.camel@concordia"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">Test platform: One partition of pSeries with one cpu core(4 SMTs) and 
               RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) in POWER7
OS version: SUSE Linux Enterprise Server 11 SP2  (ppc64) with 3.8-rc3 kernel 

IRQ 21 and 22 are assigned to the ipr device which support 2 mutiple MSI.

The test results is shown by 'cat /proc/interrups':
          CPU0       CPU1       CPU2       CPU3       
21:          6          5          5          5      XICS Level     host1-0
22:        817        814        816        813      XICS Level     host1-1
</pre>
      </blockquote>
      <pre wrap="">
This shows that you are correctly configuring two MSIs.

But the key advantage of using multiple interrupts is to distribute load
across CPUs and improve performance. So I would like to see some
performance numbers that show that there is a real benefit for all the
extra complexity in the code.</pre>
    </blockquote>
    Yes, the system just has suport two MSIs. Anyway, I will try to do
    some proformance<br>
    test, to show the real benefit.<br>
    But actually it needs the driver to do so. As the data show above,
    it seems there is <br>
    some problems in use the interrupt, the irq 21 use few, most use 22,
    I will discuss <br>
    with the driver author to see why and if she fixed, I will give out
    the proformance<br>
    result.<br>
    <br>
    Thanks<br>
    <br>
    Mike<br>
    <br>
    <blockquote cite="mid:1359948180.25414.11.camel@concordia"
      type="cite">
      <pre wrap="">

cheers

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------010903020304020801040503--
