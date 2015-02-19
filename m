Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA1961A0B7A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 14:25:23 +1100 (AEDT)
Received: by mail-vc0-f175.google.com with SMTP id hq12so318728vcb.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 19:25:20 -0800 (PST)
Message-ID: <54E55796.6000401@candw.ms>
Date: Wed, 18 Feb 2015 23:25:10 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>		
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>	
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au>
In-Reply-To: <1424314594.22408.1.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------060101050406060206050701"
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
--------------060101050406060206050701
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/2015 10:56 PM, Michael Ellerman wrote:
> On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
>> On 2/18/2015 8:13 PM, Michael Ellerman wrote:
>>
>>> On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
>>>> On 2/15/2015 8:18 PM, Michael Ellerman wrote:
>>>>
>>>>> On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
>>>>>> Hi
>>>>>>
>>>>>> I am unable to get any kernel beyond  the 3.16 branch working on an
>>>>>> Acube Sam460ex
>>>>>>   AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
>>>>> Does reverting b0345bbc6d09 change anything?
>>>>>
>>>>>> [    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>>>>>> [    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
>>>>>> [    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
>>>>>> [    6.495055] Faulting instruction address: 0xc032202c
>>>>>> [    6.500033] Vector: 300 (Data Access) at [efa31cf0]
>>>>>> [    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
>>>>>> [    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
>>>>>> [    6.515600]     sp: efa31da0
>>>>>> [    6.518491]    msr: 21000
>>>>>> [    6.521112]    dar: fa06c7c
>>>>>> [    6.523915]  dsisr: 0
>>>>>> [    6.526190]   current = 0xef8bab00
>>>>>> [    6.529603]     pid   = 115, comm = kworker/0:1
>>>>>> [    6.534163] enter ? for help
>>>>>> [    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
>>>>>> [    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
>>>>>> [    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
>>>>>> [    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
>>>>>> [    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
>>>>>> [    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
>>>>>> [    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
>>>>>> [    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
>>>>>> [    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
>>>>>> [    6.591910] mon>  <no input ...>
>>>> Managed to do a third git bisect  with the following results .
>>> Great work.
>>>
>>>> git bisect bad
>>>> 9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
>>>> commit 9279d3286e10736766edcaf815ae10e00856e448
>>>> Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>> Date:   Wed Aug 6 16:10:16 2014 -0700
>>>>
>>>>      lib: bitmap: change parameter of bitmap_*_region to unsigned
>>> So the bug is in the 4xx MSI code, and has always been there, in fact I don't
>>> see how that code has *ever* worked. The commit you bisected to just caused the
>>> existing bug to cause an oops.
>>>
>>> Can you try this?
>>>
>>> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
>>> index 6e2e6aa378bb..effb5b878a78 100644
>>> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
>>> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
>>> @@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>   
>>>   	list_for_each_entry(entry, &dev->msi_list, list) {
>>>   		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>>> -		if (int_no >= 0)
>>> -			break;
>>>   		if (int_no < 0) {
>>> -			pr_debug("%s: fail allocating msi interrupt\n",
>>> -					__func__);
>>> +			pr_warn("%s: fail allocating msi interrupt\n", __func__);
>>> +			return -ENOSPC;
>>>   		}
>>>   		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
>>>   		if (virq == NO_IRQ) {
>>>
>> Thanks.
>> This works with 3.17-rc1. Will try with the 3.18 Branch .
> OK great.
>
>> Any ideas why drm is not  working ? (It never worked) .
> No sorry. You might have more luck if you post a new thread to the dri list.
>
>> [    5.809802] Linux agpgart interface v0.103
>> [    6.137893] [drm] Initialized drm 1.1.0 20060810
>> [    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>> [    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
> I'm curious why it's failing to allocate MSIs. Possibly it's just run out.
>
> Can you post the output of 'cat /proc/interrupts'?
>
> cheers
>
>
>
cat /proc/interrupts
            CPU0
  18:          0       UIC  11 Edge      L2C
  19:          0       UIC  12 Level     snd_ice1724
  20:          1       UIC  16 Level
  21:        306       UIC  17 Level     snd_hda_intel
  22:      12212       UIC   0 Level     0002:00:04.0
  25:        619       UIC   6 Level     MAL TX EOB
  26:        937       UIC   7 Level     MAL RX EOB
  27:          0       UIC   3 Level     MAL SERR
  28:          0       UIC   4 Level     MAL TX DE
  31:          0       UIC   5 Level     MAL RX DE
  32:       6607       UIC  29 Level     ehci_hcd:usb1
  33:          1       UIC  30 Level     ohci_hcd:usb2
  38:         19       UIC   2 Level     IBM IIC
  39:          0       UIC   3 Level     IBM IIC
  40:          0       UIC  16 Level     EMAC
  44:          0       UIC   0 Edge      aerdrv
  45:          0       UIC   2 Edge      aerdrv
LOC:     117318   Local timer interrupts for timer event device
LOC:         53   Local timer interrupts for others
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions


--------------060101050406060206050701
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2/18/2015 10:56 PM, Michael Ellerman
      wrote:<br>
    </div>
    <blockquote cite="mid:1424314594.22408.1.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 2/18/2015 8:13 PM, Michael Ellerman wrote:

</pre>
        <blockquote type="cite">
          <pre wrap="">On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">On 2/15/2015 8:18 PM, Michael Ellerman wrote:

</pre>
            <blockquote type="cite">
              <pre wrap="">On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
</pre>
              <blockquote type="cite">
                <pre wrap="">Hi

I am unable to get any kernel beyond  the 3.16 branch working on an
Acube Sam460ex
 AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
</pre>
              </blockquote>
              <pre wrap="">Does reverting b0345bbc6d09 change anything?

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
            </blockquote>
            <pre wrap="">Managed to do a third git bisect  with the following results .
</pre>
          </blockquote>
          <pre wrap="">Great work.

</pre>
          <blockquote type="cite">
            <pre wrap="">git bisect bad
9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
commit 9279d3286e10736766edcaf815ae10e00856e448
Author: Rasmus Villemoes <a class="moz-txt-link-rfc2396E" href="mailto:linux@rasmusvillemoes.dk">&lt;linux@rasmusvillemoes.dk&gt;</a>
Date:   Wed Aug 6 16:10:16 2014 -0700

    lib: bitmap: change parameter of bitmap_*_region to unsigned
</pre>
          </blockquote>
          <pre wrap="">
So the bug is in the 4xx MSI code, and has always been there, in fact I don't
see how that code has *ever* worked. The commit you bisected to just caused the
existing bug to cause an oops.

Can you try this?

diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 6e2e6aa378bb..effb5b878a78 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	list_for_each_entry(entry, &amp;dev-&gt;msi_list, list) {
 		int_no = msi_bitmap_alloc_hwirqs(&amp;msi_data-&gt;bitmap, 1);
-		if (int_no &gt;= 0)
-			break;
 		if (int_no &lt; 0) {
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
+			pr_warn("%s: fail allocating msi interrupt\n", __func__);
+			return -ENOSPC;
 		}
 		virq = irq_of_parse_and_map(msi_data-&gt;msi_dev, int_no);
 		if (virq == NO_IRQ) {

</pre>
        </blockquote>
        <pre wrap="">Thanks.
</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">This works with 3.17-rc1. Will try with the 3.18 Branch .
</pre>
      </blockquote>
      <pre wrap="">
OK great.

</pre>
      <blockquote type="cite">
        <pre wrap="">Any ideas why drm is not  working ? (It never worked) .
</pre>
      </blockquote>
      <pre wrap="">
No sorry. You might have more luck if you post a new thread to the dri list.

</pre>
      <blockquote type="cite">
        <pre wrap="">[    5.809802] Linux agpgart interface v0.103
[    6.137893] [drm] Initialized drm 1.1.0 20060810
[    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
</pre>
      </blockquote>
      <pre wrap="">
I'm curious why it's failing to allocate MSIs. Possibly it's just run out.

Can you post the output of 'cat /proc/interrupts'?

cheers



</pre>
    </blockquote>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">cat /proc/interrupts
           CPU0       
 18:          0       UIC  11 Edge      L2C
 19:          0       UIC  12 Level     snd_ice1724
 20:          1       UIC  16 Level   
 21:        306       UIC  17 Level     snd_hda_intel
 22:      12212       UIC   0 Level     0002:00:04.0
 25:        619       UIC   6 Level     MAL TX EOB
 26:        937       UIC   7 Level     MAL RX EOB
 27:          0       UIC   3 Level     MAL SERR
 28:          0       UIC   4 Level     MAL TX DE
 31:          0       UIC   5 Level     MAL RX DE
 32:       6607       UIC  29 Level     ehci_hcd:usb1
 33:          1       UIC  30 Level     ohci_hcd:usb2
 38:         19       UIC   2 Level     IBM IIC
 39:          0       UIC   3 Level     IBM IIC
 40:          0       UIC  16 Level     EMAC
 44:          0       UIC   0 Edge      aerdrv
 45:          0       UIC   2 Edge      aerdrv
LOC:     117318   Local timer interrupts for timer event device
LOC:         53   Local timer interrupts for others
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
	</style>
  </body>
</html>

--------------060101050406060206050701--
