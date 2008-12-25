Return-Path: <glppd-linuxppc-dev-3@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 6E864DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 15:05:06 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LFgIU-0004jX-Rr
	for linuxppc-dev@ozlabs.org; Thu, 25 Dec 2008 02:50:02 +0000
Received: from 83.167.112.74 ([83.167.112.74])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 02:50:02 +0000
Received: from malc by 83.167.112.74 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Dec 2008 02:50:02 +0000
To: linuxppc-dev@ozlabs.org
From: malc@pulsesoft.com
Subject: Lock-up on PPC64
Date: Thu, 25 Dec 2008 04:01:49 +0300
Message-ID: <877i5pukxu.fsf@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Benjamin Herrenschmidt asked to re-report this issue to linuxppc-dev and
here it is.

[original LKML message http://lkml.org/lkml/2008/12/21/105]

Synopsis

Plain/non-root userspace application which doesn't interface with
any weird out-of/in-tree drivers manages to lock-up a PS3 machine
running Linux.

The application in question is Mono VM running mcs.exe (C# compiler)
which tries to compile particular file, distribution is Yellow Dog Linux
6.0 with either stock (2.6.23.x) or custom compiled (2.6.27) 64bit kernel.


Symptoms are as follows (interaction is done via ssh from another
machine):

$ make
... lots of stdout/err messages
... eventually an error message

Eventually the ssh session terminates, PS3 is still pingable but
impossible to connect to, attaching keyboard and trying magic SysRq
doesn't work, typing keys into login: prompt works (as in - the terminal
shows keys that were pressed, but after hittiing enter the carret is
advanced and nothing happens, hitting random keys doesn't yield anything
either)

There's a bug in Mono bugzilla which describes exactly the same problem,
but it appears as if reporters machine continued working after hitting
the problem. https://bugzilla.novell.com/show_bug.cgi?id=414845
The reporter aslo managed to create minimal reproducible test case
(so that running `MONO_PATH=... .../mono .../mcs.exe prob.cs' kills
  this PS3 just as well)

Any pointers to what can be done to further debug this would be greatly
appreciated.

[ends here]

Unfortunatelly reproducing requires building Mono from sources.

Mono 2.0.1 can only be built in 32bit mode and still exhibits the same
(locking-up behavior):
 http://ftp.novell.com/pub/mono/sources/mono/mono-2.0.1.tar.bz2

Or the one from the SVN, instructions are at:
http://mono-project.com/AnonSVN
(Configured with: `CC='gcc -m64' ./configure' (never tried 32bit build))

Unfortunatelly the only PPC64 machine i have access to that's running
Linux is a PS3 so i can not confirm/deny the reproducibility on other
PPC64's.

P.S. FWIW custom 2.6.27 = ps3_defconfig + enabled netconsole.

-- 
mailto:av1474@comtv.ru
