Date: Fri, 10 Dec 1999 12:00:24 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerPC 4xx Port Progress
In-Reply-To: <Pine.SGI.4.10.9912081326290.56447-100000@brule.borg.umn.edu>
Message-ID: <Pine.SGI.4.10.9912101131200.164510-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've been able to squish a few bugs over the last few days and have
consequently made a little* bit more progress with the Linux boot sequence
on the IBM 403GCX "Oak" evaluation board. It gets a little* further, dying
in the serial_init stuff. This is expected though since I haven't yet
gotten the serial code working (printk just dumps to log_buf which I
extract with the hardware debugger--painful but it works):

   Linux version 2.3.31 (grant@brule) (gcc version 2.95.2 19991024 (release)) #23 Fri Dec 10 09:25:17 CST 1999.
   On node 0 totalpages: 00000400.
   zone(0): 1024 pages.
   zone(1): 0 pages.
   zone(2): 0 pages.
   Calibrating delay loop... 12.95 BogoMIPS.
   Memory: 2648k available (752k kernel code, 656k data, 40k init) [c0000000,c0400000].
   Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes).
   POSIX conformance testing by UNIFIX
   Linux NET4.0 for Linux 2.3
   Based upon Swansea University Computer Society NET3.039
   NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
   NET4: Linux TCP/IP 1.0 for NET4.0
   IP Protocols: ICMP, UDP, TCP, IGMP
   TCP: Hash tables configured (established 512 bind 1024)
   Starting kswapd v1.6
   Serial driver version 4.91 (1999-11-17) with no serial options enabled

Then it dies with a DTLB miss exception (for which there's no handler
yet).

Major issues to resolve/finish:
 
   o Figure out why the stack on exception entry never looks the same as on
     exception exit.

     - Definitely a cache issue. Running with the caches disabled 
       in both real-mode (DR/IR = 00) and virtual mode (DR/IR = 11) fixes
       things for the time being.

   o Figure out why paging_init still causes things to die (I've worked
     around it in the interim).

     - Still not 100% sure what this code needs to do, but the following
       seems to work on the 4MB Oak board:

            unsigned int zones_size[MAX_NR_ZONES] = {0, 0, 0};
            /* 
             * All pages are DMA-able so this is wrong - the zone code is
             * assuming both regions have a value so this is necessary for
             * now.
             * -- Cort
             */

             zones_size[ZONE_DMA] = virt_to_phys(end_of_DRAM) >> PAGE_SHIFT;
             free_area_init(zones_size);

  o 403GCX Async Interrupt Controller (AIC) (arch/ppc/kernel/ppc4xx_pic.c)

    - Filled in a little more code here.

  o Ethernet: National Semiconductor DP83902AV (drivers/net/oaknet.c)
  o Serial: /dev/ttyS0 (On-chip 403GCX SCC), /dev/ttyS1 (NS 16550DV)
  o MMU: finish up page table code and D/ITLB miss exception handlers.

  o Timer code is probably wrong, BogoMIPS seems low.

    - I think I've got this mostly* correct now.

As before, later today, I'll be posting patches, etc. to:
 
  http://www.lcse.umn.edu/~grant/Linux/index.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
