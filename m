Date: Fri, 07 Feb 2003 19:43:27 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <A60FFE6CA339C742BE11C311EA8BFF540164DD@mdsms2.inside.mdsroc.com>
To: "Ruhland, Paul" <PRuhland@microwavedata.com>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEBBFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The pasting into the console bug is actually caused in
> 'drivers/char/n_tty.c' (standard tty line discipline) by not handling a
> failed call to 'opost(...)' (if returns -1 if tx buffer is full and char
> must be retried) in 'echo_char()'.  The pasted data is received fine....just
> the echo fails.

got the same here.

>
> >From 'drivers/char/n_tty.c':
> ================================================
> /* Must be called only when L_ECHO(tty) is true. */
>
> static void echo_char(unsigned char c, struct tty_struct *tty)
> {
> 	if (L_ECHOCTL(tty) && iscntrl(c) && c != '\t') {
> 		put_char('^', tty);
> 		put_char(c ^ 0100, tty);
> 		tty->column += 2;
> 	} else
> 		opost(c, tty);
> }
> ===============================================
>

Great, do you have a fix?

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
