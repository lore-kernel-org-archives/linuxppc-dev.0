Return-Path: <efault@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E4E9C1007D2
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 13:46:34 +1000 (EST)
Subject: Re: CONFIG_NO_HZ causing poor console responsiveness
From: Mike Galbraith <efault@gmx.de>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <AANLkTikLivGEFl_DJsvWArbvE1yYUBFn9yiQxqsZgTma@mail.gmail.com>
References: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
	<AANLkTikLivGEFl_DJsvWArbvE1yYUBFn9yiQxqsZgTma@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 02 Jul 2010 05:46:30 +0200
Message-Id: <1278042390.19236.5.camel@marge.simson.net>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-01 at 16:55 -0500, Timur Tabi wrote:
> On Tue, Jun 29, 2010 at 2:54 PM, Timur Tabi <timur@freescale.com> wrote:
> > I'm adding support for a new e500-based board (the P1022DS), and in
> > the process I've discovered that enabling CONFIG_NO_HZ (Tickless
> > System / Dynamic Ticks) causes significant responsiveness problems on
> > the serial console.  When I type on the console, I see delays of up to
> > a half-second for almost every character.  It acts as if there's a
> > background process eating all the CPU.
> 
> I finally finished my git-bisect, and it wasn't that helpful.  I had
> to skip several commits because the kernel just wouldn't boot:
> 
> There are only 'skip'ped commits left to test.
> The first bad commit could be any of:
> 6bc6cf2b61336ed0c55a615eb4c0c8ed5daf3f08
> 8b911acdf08477c059d1c36c21113ab1696c612b
> 21406928afe43f1db6acab4931bb8c886f4d04ce
> 5ca9880c6f4ba4c84b517bc2fed5366adf63d191
> a64692a3afd85fe048551ab89142fd5ca99a0dbd
> f2e74eeac03ffb779d64b66a643c5e598145a28b
> c6ee36c423c3ed1fb86bb3eabba9fc256a300d16
> e12f31d3e5d36328c7fbd0fce40a95e70b59152c
> 13814d42e45dfbe845a0bbe5184565d9236896ae
> b42e0c41a422a212ddea0666d5a3a0e3c35206db
> 39c0cbe2150cbd848a25ba6cdb271d1ad46818ad <== the crime scene
> beac4c7e4a1cc6d57801f690e5e82fa2c9c245c8
> 41acab8851a0408c1d5ad6c21a07456f88b54d40
> 6427462bfa50f50dc6c088c07037264fcc73eca1
> c9494727cf293ae2ec66af57547a3e79c724fec2
> We cannot bisect more!
> 
> These correspond to a batch of scheduler patches, most from Mike Galbraith.
> 
> I don't know what to do now.  I can't test any of these commits.  Even
> if I could, they look like they're all part of one set, so I doubt I
> could narrow it down to one commit anyway.

Hi Timur,

This has already fixed.  Below is the final fix from tip.

commit 3310d4d38fbc514e7b18bd3b1eea8effdd63b5aa
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Jun 17 18:02:37 2010 +0200

    nohz: Fix nohz ratelimit
    
    Chris Wedgwood reports that 39c0cbe (sched: Rate-limit nohz) causes a
    serial console regression, unresponsiveness, and indeed it does. The
    reason is that the nohz code is skipped even when the tick was already
    stopped before the nohz_ratelimit(cpu) condition changed.
    
    Move the nohz_ratelimit() check to the other conditions which prevent
    long idle sleeps.
    
    Reported-by: Chris Wedgwood <cw@f00f.org>
    Tested-by: Brian Bloniarz <bmb@athenacr.com>
    Signed-off-by: Mike Galbraith <efault@gmx.de>
    Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Jiri Kosina <jkosina@suse.cz>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Greg KH <gregkh@suse.de>
    Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
    Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
    Cc: Jef Driesen <jefdriesen@telenet.be>
    LKML-Reference: <1276790557.27822.516.camel@twins>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1d7b9bc..783fbad 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -315,9 +315,6 @@ void tick_nohz_stop_sched_tick(int inidle)
 		goto end;
 	}
 
-	if (nohz_ratelimit(cpu))
-		goto end;
-
 	ts->idle_calls++;
 	/* Read jiffies and the time when jiffies were updated last */
 	do {
@@ -328,7 +325,7 @@ void tick_nohz_stop_sched_tick(int inidle)
 	} while (read_seqretry(&xtime_lock, seq));
 
 	if (rcu_needs_cpu(cpu) || printk_needs_cpu(cpu) ||
-	    arch_needs_cpu(cpu)) {
+	    arch_needs_cpu(cpu) || nohz_ratelimit(cpu)) {
 		next_jiffies = last_jiffies + 1;
 		delta_jiffies = 1;
 	} else {
