From: Arun Dharankar <ADharankar@attbi.com>
To: "Wright, David" <dwright@infiniswitch.com>
Subject: Re: Linux kernel panics and core dumps.
Date: Wed, 9 Apr 2003 13:18:06 -0400
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3D296C067098F149B11A8F4FC37C054685D89F@EXVS1.ops.infiniswitch.com>
In-Reply-To: <3D296C067098F149B11A8F4FC37C054685D89F@EXVS1.ops.infiniswitch.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304091318.06120.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David, Thanks very much!

It looks like I need to spend some time to understand debug the
problem. The crash init seems to go through ok, prints relevant
info. Then just as init starts the exceptions start to occur, and
dont stop till a bus timeout happens.

Probably it makes sense for me to gather some more information
to ask any sensible question.

Thanks again!
Best regards,
-Arun.

Just for completeness, snippets of the console output are as follow.

  Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 0Mb
  Total memory = 512MB; using 1024kB for hash table (at c0300000)
  Linux version 2.4.20 (root@host) (gcc version 2.95.2 19991024
    (release)) #68 Wed Apr 9 13:26:50 EDT 2003
  crash_init (crash_va: c0021000)
  crash_dump_header c0021000 {
      magic[0]            = bf61001c
      map                 = 7cbb2b78
      map_pages           = 3bc0ffea
      data_pages          = 408201f8
      compr_units         = 2f840000
      boot_reserved_start = 419e015c
      boot_reserved_end   = 8002027c
  memset...done
  On node 0 totalpages: 131072
  zone(0): 131072 pages.
  zone(1): 0 pages.
  zone(2): 0 pages.
  ... ... ...
  ... ... ...
  Mounted devfs on /dev
  Freeing unused kernel memory: 224k init
  INIT: version 2.78 booting
  Oops: Exception in kernel mode, sig: 4
  NIP: C0021000 XER: 00000000 LR: C000701C SP: C02ADEF0 REGS: c02ade40
      TRAP: 0700
     Not tainted
  MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
  TASK = c02ac000[1] 'init' Last syscall: 174
  last math c02ac000 last altivec 00000000
  GPR00: C000701C C02ADEF0 C02AC000 00000000 7FFFF6B8 7FFFF738
  ... ... ...
  Kernel panic: Attempted to kill init!
  save_core: started on CPU0
  Oops: Exception in kernel mode, sig: 4

On Wednesday 09 April 2003 12:19 pm, Wright, David wrote:
> Boy, it took me a while to dig this out of my notes.
>
>
> This is the proper way to do the call to crash_init:
>
> #if defined(CONFIG_MCL_COREDUMP)
> 	crash_init((u_long)phys_to_virt(start),
> 		   (u_long)phys_to_virt(start + (33 * PAGE_SIZE)),
> 		   (u_long)phys_to_virt(start + (33 + crash_pages)*PAGE_SIZE));
> #endif
>
> Well, OK, those "33" literals in the code aren't so great, but
> there are limits to how much cleanup I was able to do.
>
> Also, in panic.c, these lines:
>
> #ifdef CONFIG_MCL_COREDUMP
> 	smp_call_function((void*)smp_crash_funnel_cpu,0,0,0);
> 	crash_save_current_state(current);
> #endif
>
> should come after the invocation of "notifier_call_chain", if
> you have any sort of watchdog timer on your system.  We did, and
> the watchdog would expire while the crash was being generated,
> since it was the call chain that shut down the watchdog.
>
>   -- David Wright, InfiniSwitch Corp.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
