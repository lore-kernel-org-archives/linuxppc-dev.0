Message-ID: <411FDEBD.8050805@elitedvb.net>
Date: Mon, 16 Aug 2004 00:07:57 +0200
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Poor IDE performance on Linux 2.6.x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

i'm using a Linux 2.6.8-rc4 (linuxppc tree) on a Pallas (PPC405 core
plus Set-Top-Box-specialized SOC)-based  board (Redwood 5 like).

The IDE driver in use is ibm_ocp_ide.c, in UDMA-33 mode.

When measured with "hdparm -t", we get a HDD performance of about
11MB/s. With an older kernel like 2.4.20, the performance was - with
same Hardware - about 22MB/s, i.e. twice as high.

I tried different IO-schedulers, but, as expected, as there is only one
process accessing the harddisk, there was no difference. The IDE-driver
seems to be ok - i made some measurements, and the time from
"ide_do_rw_disk" until the end of the IDE-irq isn't longer than expected
(and gives a raw IDE performance of about ~29MB/s, which is near the
theoretical limit of 33MB/s of the UDMA-Bus. The harddisk performance
doesn't seem to matter as it's >11MB/s, and seems to make some prefetch,
so that the next data is already read from disk into the drive's cache
when the DMA transfer starts. The first DMA transfers are slower,
probably due seek time and real read time etc. ).
The time measured (i won't tell exact numbers as they depend on the
transfered size and the time required for the printks) included the IDE
command processing time (i.e., time after issuing the IDE command until
the IDE device asserted DRQ), so it's some "worst case timing".

The problem seems to be the delay after the successfull termination of
the read-command until the next ide_do_rw_disk is called. I was - mainly
because i don't know the IO subsystem of the kernel too much - unable to
trace down what's going on there.

I hacked the kernel profiler to use a critical interrupt (available on
4xx) and an on-cpu compare timer, so i was able to profile even in IRQ
time.
The profile, sorted and tailed, looks like:
    31 run_timer_softirq                          0.0718
    42 __flush_dcache_icache                      0.5526
    94 invalidate_dcache_range                    1.9583
   103 finish_task_switch                         0.5598
   199 memset                                     2.1630
   533 __do_softirq                               2.3795
  4404 __copy_tofrom_user                         7.8085
  9819 cpu_idle                                 175.3393
 27760 default_idle                             301.7391
 43154 total                                      0.2316

so except some "copy_tofrom_user", the CPU is just idling around.

Can anybody tell me where to look at, i.e. where the time is spend
between a successfull termination of a transfer and the start of the
next io? Userspace just reads BIG blocks (10MB or so), so userspace
latency doesn't seem to be the problem.

hdparm -T gives about 46MB/s, which is about the half of our memory
performance.

Felix

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
