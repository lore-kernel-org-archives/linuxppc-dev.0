Date: Wed, 8 Dec 1999 13:46:36 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PowerPC 4xx Port Progress
Message-ID: <Pine.SGI.4.10.9912081326290.56447-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've made some small bit of progress on getting the 2.3.30 kernel to boot
on IBM's 403GCX "Oak" evaluation board:

  Linux version 2.3.30 (grant@brule) (gcc version 2.95.2 19991024 (release)) #33 Wed Dec 8 11:05:44 PST 1999.
  On node 0 totalpages: 00000400.
  zone(0): 1024 pages.
  zone(1): 0 pages.
  zone(2): 0 pages.
  Calibrating delay loop... 12.95 BogoMIPS.
  Memory: 2648k available (752k kernel code, 656k data, 40k init) [c0000000, c0400000].
  Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes).
  POSIX conformance testing by UNIFIX

Then it runs off into nowhere land which isn't too surprising considering
that there are a lot of holes yet.

Major issues to resolve/finish:

  o Figure out why the stack on exception entry never looks the same as on
    exception exit (a cache issue no doubt).
  o Figure out why paging_init still causes things to die (I've worked
    around it in the interim).
  o 403GCX Async Interrupt Controller (AIC) (arch/ppc/kernel/ppc4xx_pic.c)
  o Ethernet: National Semiconductor DP83902AV (drivers/net/oaknet.c)
  o Serial: /dev/ttyS0 (On-chip 403GCX SCC), /dev/ttyS1 (NS 16550DV)
  o MMU: finish up page table code and D/ITLB miss exception handlers.
  o Timer code is probably wrong, BogoMIPS seems low.

I'll try to get the latest code to Cort for inclusion in the next kernel.
In the interim, I'll be posting patches, etc. to:

	http://www.lcse.umn.edu/~grant/Linux/index.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
