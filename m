Date: Mon, 10 Feb 2003 15:45:41 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <A60FFE6CA339C742BE11C311EA8BFF540164DD@mdsms2.inside.mdsroc.com>
To: "Ruhland, Paul" <PRuhland@microwavedata.com>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCECBFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The pasting into the console bug is actually caused in
> 'drivers/char/n_tty.c' (standard tty line discipline) by not handling a
> failed call to 'opost(...)' (if returns -1 if tx buffer is full and char
> must be retried) in 'echo_char()'.  The pasted data is received fine....just
> the echo fails.
>

Hi again

Thanks to Paul Ruhland I was able to fix my problem with chars getting
lost.

This little patch of mine works really fine for me, I just want to known
if it's a good solution or if something else is to prefer.

 Jocke

Index: drivers/char/n_tty.c
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/drivers/char/n_tty.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 n_tty.c
--- drivers/char/n_tty.c	1 Nov 2002 13:43:27 -0000	1.1.1.1
+++ drivers/char/n_tty.c	10 Feb 2003 14:38:56 -0000
@@ -186,8 +186,10 @@
 static int opost(unsigned char c, struct tty_struct *tty)
 {
 	int	space, spaces;
+	unsigned long tmo = jiffies + HZ/10;

-	space = tty->driver.write_room(tty);
+	while(!(space = tty->driver.write_room(tty)) && !time_after(jiffies, tmo))
+		cond_resched();
 	if (!space)
 		return -1;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
