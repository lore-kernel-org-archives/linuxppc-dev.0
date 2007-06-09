Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DA864DDE2A
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jun 2007 08:47:25 +1000 (EST)
Message-ID: <466B2DF5.7050603@am.sony.com>
Date: Sat, 09 Jun 2007 15:47:17 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 08/18] PS3: Kexec support (and a tutoral on the kexec
	flow for 64 bit powerpc)
References: <aedf9b62aefb7f14cb71ba5bba9c5e38@bga.com>
In-Reply-To: <aedf9b62aefb7f14cb71ba5bba9c5e38@bga.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Milton.

Milton Miller wrote:
> On Wed Jun 6 13:00:15 EST 2007, Geoff Levand wrote:
> 
>> Fixup the core platform parts needed for kexec to work on the PS3.
>>  - Setup ps3_hpte_clear correctly.
>>  - Mask interrupts on irq removal.
>>  - Release all hypervisor resources.

>>  static void ps3_hpte_clear(void)
>>  {
>> -       /* Make sure to clean up the frame buffer device first */
>> -       ps3fb_cleanup();
> 
> I'm glad to see this go.  Which patch added the call to the driver?


I don't know the exact history, but I am pretty sure that is a left
over from before the framebuffer driver used the dma support now
provided by the ps3_system_bus.  The old fb code managed its own
IOPTE's, and I think this call cleaned those.  But as Geert was
re-writing the fb driver ps3fb_cleanup became a place to put general
fb shutdown code.  At the time we were working to just get it to boot
and run, and had no concern what happened at shutdown let alone
kexec.  It wasn't like someone consciously made a single change to
do driver shutdown here, it just was a result of the churn.


>> +       int result;
>>
>> -       lv1_unmap_htab(htab_addr);
>> +       DBG(" -> %s:%d\n", __func__, __LINE__);
>> +
>> +       result = lv1_unmap_htab(htab_addr);
>> +       BUG_ON(result);
>> +
>> +       ps3_mm_shutdown();
>> +
>> +       ps3_mm_vas_destroy();
>>
> I tried to look at these to check that nothing dynamically allocated 
> was being touched.   I didn't find anything if the memory had been 
> hot-unplugged, but it also looked like they skipped the last one.


By 'last one' I guess you mean the rm region (map.rm).  That is
the 'real mode' boot mem region.  It is allocated by the hypervisor
for the life of the lpar.  It's not hot-pluggable.


>> @@ -209,31 +209,28 @@ static int __init ps3_probe(void)
>>  #if defined(CONFIG_KEXEC)
>>  static void ps3_kexec_cpu_down(int crash_shutdown, int secondary)
>>  {
>> -       DBG(" -> %s:%d\n", __func__, __LINE__);
>> +       int result;
>> +       u64 ppe_id;
>> +       u64 thread_id = secondary ? 1 : 0;
> 
> This is wrong.   This is not what secondary means.  To get the 
> thread_id you must use smp_processor_id for logical or 
> hard_smp_processor_id() for the hardware thread id.
> 
>> +       DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, secondary);
>> +       ps3_smp_cleanup_cpu(thread_id);
>> +
>> +       lv1_get_logical_ppe_id(&ppe_id);
>> +       result = lv1_configure_irq_state_bitmap(ppe_id, secondary ? 0 
>> : 1, 0);
>> +       /* seems to fail on second call */
>> +       DBG("%s:%d: lv1_configure_irq_state_bitmap (%d) %s\n", 
> 
> As the second argument is thread id, again this is wrong.


OK, I setup a new routine ps3_shutdown_IRQ() to mirror ps3_init_IRQ().
ps3_shutdown_IRQ() uses the hard processor id.


> Once linux is running, all processors are identical.  That is the S in 
...
> location as it must when started from open firmware.


Thanks for the explanation.  I wish I had that before starting this
work, but it still explained a few points I still wasn't clear on.
I think we should put it somewhere formal like the kernel source
Documentntation directory.  What do you think?

-Geoff
