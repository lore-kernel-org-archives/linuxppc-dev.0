Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 73CB1DDF3A
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 18:52:42 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9D7pYjm616744
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 07:51:34 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9D7pYDg3227660
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:51:34 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9D7pWj8013149
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:51:33 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with
	callbacks
Date: Mon, 13 Oct 2008 09:51:31 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031445.22561.borntraeger@de.ibm.com>
	<1223875013.8157.230.camel@pasglop>
In-Reply-To: <1223875013.8157.230.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810130951.31733.borntraeger@de.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Montag, 13. Oktober 2008 schrieb Benjamin Herrenschmidt:
> =A0 ... key =A0 =A0 =A0at: [<c000000000939018>] proc_subdir_lock+0x18/0x38
> =A0... acquired at:
> =A0 =A0[<c0000000000832e8>] .__lock_acquire+0x814/0x8ec
> =A0 =A0[<c000000000083464>] .lock_acquire+0xa4/0xec
> =A0 =A0[<c0000000004e713c>] ._spin_lock+0x44/0xa0
> =A0 =A0[<c000000000139144>] .xlate_proc_name+0x50/0xf8
> =A0 =A0[<c0000000001392f4>] .remove_proc_entry+0x44/0x298
> =A0 =A0[<c0000000000a1e74>] .unregister_handler_proc+0x40/0x58
> =A0 =A0[<c00000000009fc58>] .free_irq+0x124/0x18c
> =A0 =A0[<c0000000002e6634>] .notifier_del_irq+0x28/0x48
> =A0 =A0[<c0000000002e5ddc>] .hvc_close+0xa0/0x110
> =A0 =A0[<c0000000002cc328>] .release_dev+0x244/0x580
> =A0 =A0[<c0000000002cc688>] .tty_release+0x24/0x44
> =A0 =A0[<c0000000000e5384>] .__fput+0xf8/0x1dc
> =A0 =A0[<c0000000000e1bec>] .filp_close+0xb4/0xdc
> =A0 =A0[<c0000000000e33a4>] .sys_close+0xac/0x100
> =A0 =A0[<c0000000000084d4>] syscall_exit+0x0/0x40


Hmmm.=20
Can you try if this patch fixes the lockdep trace?

This would be analog to
commit b1b135c8d619cb2c7045d6ee4e48375882518bb5
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Thu Aug 7 09:18:34 2008 +0200

    fix spinlock recursion in hvc_console

    commit 611e097d7707741a336a0677d9d69bec40f29f3d
    Author: Christian Borntraeger <borntraeger@de.ibm.com>
    hvc_console: rework setup to replace irq functions with callbacks
    introduced a spinlock recursion problem.


Signed-off-by: Christian Borntraeger<borntraeger@de.ibm.com>
=2D--
 drivers/char/hvc_console.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/char/hvc_console.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/drivers/char/hvc_console.c
+++ linux-2.6/drivers/char/hvc_console.c
@@ -367,13 +367,13 @@ static void hvc_close(struct tty_struct=20
 	spin_lock_irqsave(&hp->lock, flags);
=20
 	if (--hp->count =3D=3D 0) {
=2D		if (hp->ops->notifier_del)
=2D			hp->ops->notifier_del(hp, hp->data);
=2D
 		/* We are done with the tty pointer now. */
 		hp->tty =3D NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
=20
+		if (hp->ops->notifier_del)
+			hp->ops->notifier_del(hp, hp->data);
+
 		/*
 		 * Chain calls chars_in_buffer() and returns immediately if
 		 * there is no buffered data otherwise sleeps on a wait queue
@@ -416,11 +416,11 @@ static void hvc_hangup(struct tty_struct
 	hp->n_outbuf =3D 0;
 	hp->tty =3D NULL;
=20
+	spin_unlock_irqrestore(&hp->lock, flags);
+
 	if (hp->ops->notifier_del)
 			hp->ops->notifier_del(hp, hp->data);
=20
=2D	spin_unlock_irqrestore(&hp->lock, flags);
=2D
 	while(temp_open_count) {
 		--temp_open_count;
 		kref_put(&hp->kref, destroy_hvc_struct);
