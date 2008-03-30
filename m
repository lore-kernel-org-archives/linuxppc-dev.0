Return-Path: <gaash-ppclnx@gaashh.com>
Received: from web39606.mail.mud.yahoo.com (web39606.mail.mud.yahoo.com
	[209.191.106.37]) by ozlabs.org (Postfix) with SMTP id ED491DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 21:54:20 +1000 (EST)
Date: Sun, 30 Mar 2008 04:47:38 -0700 (PDT)
From: Gaash Hazan <gaash-ppclnx@gaashh.com>
Subject: mmu_hash_lock deadlock causes kernel stuck at 2.6.21 SMP powerpc 32bit
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <633561.38010.qm@web39606.mail.mud.yahoo.com>
Cc: gaash-ppclnx@gaashh.com, gilad@codefidence.com
Reply-To: gaash-ppclnx@gaashh.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello PPC SMP MM experts,

mmu_hash_lock (arch/powerpc/mm/hash_low_32.S) is a
(non-standard) spin lock that protects the CPU MMU
hashing table. It exists and used only with SMP
configurations.

In some scenarios, the spin lock is taken when
interrupts are *enabled* causing kernel deadlock at
the next take attempt in the same CPU.

The deadlock happened on 2.6.21 kernel, Powerpc 32 bit
with SMP enabled. At this moment system had one active
CPU. The sequence I saw was:

do_exit (program termination) 
exit_mm
mmput 
exit_mmap 
free_pgtables
free_pgd_range
unmap_vmas 
pte_free
hash_page_sync (takes mmu_hash_lock. Note: interrupts
are enabled)

timer_interrupt (timer interrupts occurs during
hash_page_sync, lock is taken)
irq_exit
do_softirq
__do_softirq
net_rx_action (packet received from network)
( ... omitted ... )
xdr_skb_read_bits
skb_copy_bits
memcpy - memcpy causes DSI exception(0x300). This is
OK. 
DSI exception handler calls hash_page
hash_page waits for mmu_mash_lock. It waits forever
since the lock is already taken. 
Deadlock! with interrupts disabled. kernel is dead.

I think the rout cause of the problem is
hash_page_sync() taking the mmu_hash_lock spin lock
without disabling interrupts. This leads to the
deadlock.

To verify the theory, hash_page_sync() was wrapped
with interrupts disabled code and problem never
occurred again. Of course this is temporary workaround
as there are several places needed to be fixed.

What do you think?

Thanks,

Gaash
