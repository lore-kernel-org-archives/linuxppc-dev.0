Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 38FA6DDEB6
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 06:03:32 +1000 (EST)
Date: Fri, 20 Jul 2007 13:02:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] OProfile - Enable SPU switch notification to detect
	currently active SPU tasks - update
Message-Id: <20070720130241.176c50a5.akpm@linux-foundation.org>
In-Reply-To: <200707201424.07292.rrnelson@linux.vnet.ibm.com>
References: <200707201424.07292.rrnelson@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc <linuxppc-dev@ozlabs.org>,
	Maynard Johnson <maynardj@linux.vnet.ibm.com>,
	Arnd Bergmann <arndb@de.ibm.com>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jul 2007 14:24:07 -0500
Bob Nelson <rrnelson@linux.vnet.ibm.com> wrote:

> From: Maynard Johnson <mpjohn@us.ibm.com>
> 
> This patch adds to the capability of spu_switch_event_register so that
> the caller is also notified of currently active SPU tasks.
> Exports spu_switch_event_register and spu_switch_event_unregister so
> that OProfile can get access to the notifications provided.
> 
> Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
> Signed-off-by: Carl Love <carll@us.ibm.com>
> Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Acked-by: Paul Mackerras <paulus@samba.org>
> 
> ---
> 
> We would like this patch included in -mm and 2.6.23
> 
> Changed "for (node = 0; node < MAX_NUMNODES; node++)" loop to 
> for_each_online_node(node).
> Added comment to memory barrier.
> Better info in changelog.

here it is:

--- a/arch/powerpc/platforms/cell/spufs/sched.c~oprofile-enable-spu-switch-notification-to-detect-currently-active-spu-tasks-update
+++ a/arch/powerpc/platforms/cell/spufs/sched.c
@@ -220,13 +220,14 @@ static void notify_spus_active(void)
 	 * When the awakened processes see their "notify_active" flag is set,
 	 * they will call spu_switch_notify();
 	 */
-	for (node = 0; node < MAX_NUMNODES; node++) {
+	for_each_online_node(node) {
 		struct spu *spu;
 		mutex_lock(&spu_prio->active_mutex[node]);
 		list_for_each_entry(spu, &spu_prio->active_list[node], list) {
 			struct spu_context *ctx = spu->ctx;
 			set_bit(SPU_SCHED_NOTIFY_ACTIVE, &ctx->sched_flags);
-			mb();
+			mb();	/* make sure any tasks woken up below */
+				/* can see the bit(s) set above */
 			wake_up_all(&ctx->stop_wq);
 		}
 		mutex_unlock(&spu_prio->active_mutex[node]);
_

I still wonder about that barrier.  At the least it should be smp_mb(). 
But aren't our set_bit() semantics _alone_ sufficient to make this barrier
unneeded?

If it _is_ possible for the effects of a set_bit() to not be visible to a
woken-up thread then I suspect we'll have nasty little problems in quite a
few places.  Maybe wake_up() should itself have a barrier to prevent such
things?

Doing that would be a documentation-only change, I suspect, given that the
current implementation of wake_up() starts out with a spin_lock_irqsave().
