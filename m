Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35434DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 22:11:23 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9GB9qaf632098
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 11:09:52 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m9GB9prR3465320
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 13:09:51 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m9GB9oNB001305
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 13:09:51 +0200
Date: Thu, 16 Oct 2008 13:09:50 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 2/5] hvc_console: Add tty driver flag
	TTY_DRIVER_RESET_TERMIOS
Message-ID: <20081016110950.GA4125@cetus.boeblingen.de.ibm.com>
References: <20081014091247.433079967@linux.vnet.ibm.com>
	<20081014091413.003841094@linux.vnet.ibm.com>
	<20081014104025.517ae734@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081014104025.517ae734@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

for the sake of completion, here are few more details why I have suggest to
add the TTY_DRIVER_RESET_TERMIOS flag:

On Tue, Oct 14, 2008 at 10:40:25AM +0100, Alan Cox wrote:
> On Tue, 14 Oct 2008 11:12:49 +0200
> Hendrik Brueckner <brueckner@linux.vnet.ibm.com> wrote:
> 
> > After a tty hangup() or close() operation, processes might not reset the
> > termio settings to a sane state.
> That is the job of the getty task normally. pty is special as the reissue
> of the same pty is done as a new device (with new state).

During some testing, I have experienced that the bash alters few termios
settings before showing the bash prompt:
-
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETSW, {B38400 opost isig -icanon -echo ...}) = 0
write(2, "root@t6345050:~# ", 17) = 17
-
If the tty gets a hangup, the bash gets terminated but the settings still
remains after init has respawned the getty process.
For my network-based hvc backend, a tty_hangup() is caused by a disconnect.

I looked into the tty_io.c source and found out that the termios settings
are stored in an array of the tty driver struct and they remains unchanged
if a tty device is released and initialized again.
At tty device initialization, the tty_init_termios() set tty->termios to the
tty->driver->termios[tty->index].

The idea is to ensure that when a tty is initialized it has the
default (initial) termio settings; and that is actually done if
TTY_DRIVER_RESET_TERMIOS is set.

Anyhow the other possibility might be to always set the initial termios
when the tty is initialized (see patch below).
But I am not sure if that case is the general behavior of ttys.
Please let me know if there is a reason not to re-initialize the termios
of a new tty.

Thanks.

Best regards
Hendrik

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/char/tty_io.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/char/tty_io.c	2008-10-16 09:48:00.000000000 +0200
+++ b/drivers/char/tty_io.c	2008-10-16 12:55:52.000000000 +0200
@@ -1243,10 +1243,9 @@ int tty_init_termios(struct tty_struct *
 		tp = kzalloc(sizeof(struct ktermios[2]), GFP_KERNEL);
 		if (tp == NULL)
 			return -ENOMEM;
-		memcpy(tp, &tty->driver->init_termios,
-						sizeof(struct ktermios));
 		tty->driver->termios[idx] = tp;
 	}
+	memcpy(tp, &tty->driver->init_termios, sizeof(struct ktermios));
 	tty->termios = tp;
 	tty->termios_locked = tp + 1;
 
-- 
Hendrik Brueckner
D/3303 Linux on System z Development
Tel: +49 7031 16-1073
Fax: +49 7031 16-3456
eMail: brueckner@linux.vnet.ibm.com
IBM Deutschland Research & Development GmbH, Schoenaicher Str. 220, 71032 Boeblingen

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschaeftsfuehrung: Erich Baier
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
