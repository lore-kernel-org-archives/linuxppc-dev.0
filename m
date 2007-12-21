Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Time for cell code reshuffle?
Date: Fri, 21 Dec 2007 15:22:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712211522.03841.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We've been discussing in the past a few times where we should best put
the spufs code, and when to do it. Since Jeremy and I now have all the
current patches in powerpc.git, maybe we should do it now.

To the question, where what it should go, I'd leave the decision to
Jeremy, but my current idea would be:

arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs
arch/powerpc/platforms/cell/spu_{callbacks,base,syscalls,fault,notify}.[co]
 -> arch/powerpc/spufs/{callbacks,base,syscalls,fault,notify}.[co]

If we do it in git now, that should result in a minimal breakage of patches.

A related question is what to do about the location of the other cell
related files. platforms/ps3 is already pretty self-contained once we have
spufs outside of platforms/cell, but there is still some code shared between
platforms/cell and platforms/celleb, and each of these directories also contains
code that is only relevant for a subset of the platforms.

My position on these files is that while I find the current state a little
bit confusing, I don't have an idea how to do it better either, and I think
we should just leave the platform files where they are.

	Arnd <><
