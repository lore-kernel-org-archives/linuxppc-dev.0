In-Reply-To: <199910141421.QAA10144@opal.biophys.uni-duesseldorf.de>
Date: Thu, 14 Oct 1999 16:34:25 +0200
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: serial on lombard
Message-Id: <19991014163425.001988@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>Nah, that's the 2.5 sec wait for powering up the modem, which is,
>unfortunately, before the block_til_ready. We could forgo this wait period
>on O_NONBLOCK (maybe mark the wait pending, and make the next operation wait
>instead). 
>Anyway: how come open returns successfully but minicom still gets the
>timeout? 

I fixed my minicom by bumping the timeout to 4 seconds:

--- minicom-1.82.orig/src/main.c	Thu Aug 27 00:54:16 1998
+++ minicom-1.82/src/main.c	Thu Oct 14 16:20:00 1999
@@ -158,7 +158,7 @@
   if (setjmp(albuf) == 0) {
 	portfd = -1;
 	signal(SIGALRM, get_alrm);
-	alarm(2);
+	alarm(4);
 #if defined(O_NDELAY) && defined(F_SETFL)
 	portfd = open(dial_tty, O_RDWR|O_NDELAY);
 	if (portfd >= 0){

I'll send this to the maintainer as well.

I'd like to add the patch to the existing patches in the .rpm, however I
don't know at all how RPM works and how to re-package that stuff, and I
really don't have time to read a doc today.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
