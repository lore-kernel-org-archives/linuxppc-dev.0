From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15552.1573.160528.28254@zaphod.musenki.com>
Date: Fri, 19 Apr 2002 06:57:25 -0500
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bogomips and loops_per_jiffy
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've noticed that about half the time, the kernels I build take what I
think is a long time (> 20 seconds) in calibrate_delay().

That is, there is quite a pause between
    Calibrating delay loop...
and (the answer, of sorts)
    133.12 BogoMIPS

    => bootm ff800000
    ## Booting image at ff800000 ...
       Image Name:   Musenki kernel 2.4.19pre1
       Image Type:   PowerPC Linux Kernel Image (gzip compressed)
       Data Size:    674330 Bytes = 658 kB = 0 MB
       Load Address: 00000000
       Entry Point:  00000000
       Verifying Checksum ... OK
       Uncompressing Kernel Image ... OK
    Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
    Linux version 2.4.19pre1 (jim@ford) (gcc version 2.95.4 20011002 (Debian prerelease)) #4 Fri Apr 19 05:58:00 CDT 2002
    Musenki M3/M1: See www.musenki.com for details
    On node 0 totalpages: 8192
    zone(0): 8192 pages.
    zone(1): 0 pages.
    zone(2): 0 pages.
    Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.8:/usr/local/m1_nfsroot ip=192.168.0.42:192.168.0.8:192.168.0.1:255.255.255.0:fuckme::off
    OpenPIC Version 1.2 (1 CPUs and 138 IRQ sources) at fc040000
    time_init: decrementer frequency = 25.000000 MHz
    Calibrating delay loop... 133.12 BogoMIPS
    Memory: 30452k available (1200k kernel code, 480k data, 88k init, 0k highmem)
    Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
    Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
    Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
    Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
    POSIX conformance testing by UNIFIX
    PCI: Probing PCI hardware
    [...]

I, as on so many other machines in arch/ppc/platforms/, set

	loops_per_jiffy = 50000000 / HZ;

as the first line of musenki_setup_arch(), though I've tried
"100000000 / HZ;" with no difference in effect.

Interestingly, loops_per_jiffy is apparently over-written when
calibrate_delay() is called:

    void __init calibrate_delay(void)
    {
	    unsigned long ticks, loopbit;
	    int lps_precision = LPS_PREC;

	    loops_per_jiffy = (1<<12);

	    printk("Calibrating delay loop... ");
	    while (loops_per_jiffy <<= 1) {
		    /* wait for "start of" clock tick */
		    ticks = jiffies;
		    while (ticks == jiffies)
			    /* nothing */;
		    /* Go .. */
		    ticks = jiffies;
		    __delay(loops_per_jiffy);
		    ticks = jiffies - ticks;
		    if (ticks)
			    break;
	    }

    /* Do a binary approximation to get loops_per_jiffy set to equal one clock
       (up to lps_precision bits) */
	    loops_per_jiffy >>= 1;
	    loopbit = loops_per_jiffy;
	    while ( lps_precision-- && (loopbit >>= 1) ) {
		    loops_per_jiffy |= loopbit;
		    ticks = jiffies;
		    while (ticks == jiffies);
		    ticks = jiffies;
		    __delay(loops_per_jiffy);
		    if (jiffies != ticks)   /* longer than 1 tick */
			    loops_per_jiffy &= ~loopbit;
	    }

    /* Round the value and print it */
	    printk("%lu.%02lu BogoMIPS\n",
		    loops_per_jiffy/(500000/HZ),
		    (loops_per_jiffy/(5000/HZ)) % 100);
    }



anyone have a clue to offer?

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
