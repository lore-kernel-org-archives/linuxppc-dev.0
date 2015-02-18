Return-Path: <runaway@candw.ms>
Received: from mail-yk0-f179.google.com (mail-yk0-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9975C1A09C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 06:45:35 +1100 (AEDT)
Received: by mail-yk0-f179.google.com with SMTP id 9so1915035ykp.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:45:33 -0800 (PST)
Message-ID: <54E4EBD7.5000307@candw.ms>
Date: Wed, 18 Feb 2015 15:45:27 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au>
In-Reply-To: <1424045921.3018.4.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------090000010205050302050700"
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090000010205050302050700
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/2015 8:18 PM, Michael Ellerman wrote:
> On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
>> Hi
>>
>> I am unable to get any kernel beyond  the 3.16 branch working on an
>> Acube Sam460ex
>>   AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
> Does reverting b0345bbc6d09 change anything?
>
>> [    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>> [    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
>> [    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
>> [    6.495055] Faulting instruction address: 0xc032202c
>> [    6.500033] Vector: 300 (Data Access) at [efa31cf0]
>> [    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
>> [    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
>> [    6.515600]     sp: efa31da0
>> [    6.518491]    msr: 21000
>> [    6.521112]    dar: fa06c7c
>> [    6.523915]  dsisr: 0
>> [    6.526190]   current = 0xef8bab00
>> [    6.529603]     pid   = 115, comm = kworker/0:1
>> [    6.534163] enter ? for help
>> [    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
>> [    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
>> [    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
>> [    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
>> [    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
>> [    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
>> [    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
>> [    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
>> [    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
>> [    6.591910] mon>  <no input ...>
>
> cheers
>
>
>
Managed to do a third git bisect  with the following results .

git bisect bad
9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
commit 9279d3286e10736766edcaf815ae10e00856e448
Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Wed Aug 6 16:10:16 2014 -0700

     lib: bitmap: change parameter of bitmap_*_region to unsigned
     
     Changing the pos parameter of __reg_op to unsigned allows the compiler
     to generate slightly smaller and simpler code.  Also update its callers
     bitmap_*_region to receive and pass unsigned int.  The return types of
     bitmap_find_free_region and bitmap_allocate_region are still int to
     allow a negative error code to be returned.  An int is certainly capable
     of representing any realistic return value.
     
     Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 4f560a7caaba2d05c146a3cea27e0d93739d950c c3d4539acad26667a2d78844ead7b75af753f41e M	include
:040000 040000 7a6fb894aac2a1d4e72f8e36b7c6de3c24509ad3 31d756da185e07d2de090c9e6aeb12689d58d310 M	lib



--------------090000010205050302050700
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2/15/2015 8:18 PM, Michael Ellerman
      wrote:<br>
    </div>
    <blockquote cite="mid:1424045921.3018.4.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Hi

I am unable to get any kernel beyond  the 3.16 branch working on an
Acube Sam460ex
 AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
</pre>
      </blockquote>
      <pre wrap="">
Does reverting b0345bbc6d09 change anything?

</pre>
      <blockquote type="cite">
        <pre wrap="">[    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
[    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
[    6.495055] Faulting instruction address: 0xc032202c
[    6.500033] Vector: 300 (Data Access) at [efa31cf0]
[    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
[    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
[    6.515600]     sp: efa31da0
[    6.518491]    msr: 21000
[    6.521112]    dar: fa06c7c
[    6.523915]  dsisr: 0
[    6.526190]   current = 0xef8bab00
[    6.529603]     pid   = 115, comm = kworker/0:1
[    6.534163] enter ? for help
[    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
[    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
[    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
[    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
[    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
[    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
[    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
[    6.591910] mon&gt;  &lt;no input ...&gt;
</pre>
      </blockquote>
      <pre wrap="">

cheers



</pre>
    </blockquote>
    Managed to do a third git bisect  with the following results .<br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">git bisect bad
9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
commit 9279d3286e10736766edcaf815ae10e00856e448
Author: Rasmus Villemoes <a class="moz-txt-link-rfc2396E" href="mailto:linux@rasmusvillemoes.dk">&lt;linux@rasmusvillemoes.dk&gt;</a>
Date:   Wed Aug 6 16:10:16 2014 -0700

    lib: bitmap: change parameter of bitmap_*_region to unsigned
    
    Changing the pos parameter of __reg_op to unsigned allows the compiler
    to generate slightly smaller and simpler code.  Also update its callers
    bitmap_*_region to receive and pass unsigned int.  The return types of
    bitmap_find_free_region and bitmap_allocate_region are still int to
    allow a negative error code to be returned.  An int is certainly capable
    of representing any realistic return value.
    
    Signed-off-by: Rasmus Villemoes <a class="moz-txt-link-rfc2396E" href="mailto:linux@rasmusvillemoes.dk">&lt;linux@rasmusvillemoes.dk&gt;</a>
    Signed-off-by: Andrew Morton <a class="moz-txt-link-rfc2396E" href="mailto:akpm@linux-foundation.org">&lt;akpm@linux-foundation.org&gt;</a>
    Signed-off-by: Linus Torvalds <a class="moz-txt-link-rfc2396E" href="mailto:torvalds@linux-foundation.org">&lt;torvalds@linux-foundation.org&gt;</a>

:040000 040000 4f560a7caaba2d05c146a3cea27e0d93739d950c c3d4539acad26667a2d78844ead7b75af753f41e M	include
:040000 040000 7a6fb894aac2a1d4e72f8e36b7c6de3c24509ad3 31d756da185e07d2de090c9e6aeb12689d58d310 M	lib

</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
	</style><br>
  </body>
</html>

--------------090000010205050302050700--
