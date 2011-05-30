Return-Path: <rob@landley.net>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8DF9AB6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 06:00:32 +1000 (EST)
Received: by pwi9 with SMTP id 9so1812526pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 May 2011 13:00:30 -0700 (PDT)
Message-ID: <4DE3F754.1060806@landley.net>
Date: Mon, 30 May 2011 15:00:20 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PMAC_ZILOG serial driver locks up.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc systems I emulate under qemu use the "mac99" board 
emulation, which routes the serial console through a PMAC_ZILOG serial 
chip.

It got screwed up by Alan Cox's refactoring of the tty layer in 2.6.28:

  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-December/078700.html

And then partially fixed here:

  http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg40477.html

However, if significant input and output traffic overlaps, the serial 
port locks up.  Here's a test for that.  Grab this tarball:

  http://landley.net/aboriginal/downloads/binaries/system-image-powerpc.tar.bz2

And do this:

  echo -e "                    \necho hello world" | ./run-emulator.sh

That's echo a line of 20 spaces, a newline, and a command to see
if it makes it through to the comand prompt.

Data makes it out the serial console right up until init launches
(and interrupts are enabled), then it locks hard.

if you just ./run-emulator.sh directly and don't type anything until
you get a shell prompt, it works fine.  It's the data crossing in
both directions at once that screws the driver up.

Trivially reproducible.  I've tested back to 2.6.32 and it was doing
it back then.  (2.6.31 was a build break.)

Rob
