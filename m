Return-Path: <pacman@kosh.dhis.org>
Received: from kosh.dhis.org (c-67-162-90-113.hsd1.in.comcast.net
	[67.162.90.113]) by ozlabs.org (Postfix) with SMTP id 539B8B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Oct 2010 12:44:37 +1100 (EST)
Message-ID: <20101010013755.1697.qmail@kosh.dhis.org>
From: pacman@kosh.dhis.org
Subject: Pegasos i8042 broken again
To: linuxppc-dev@lists.ozlabs.org
Date: Sat, 9 Oct 2010 20:37:55 -0500 (GMT+5)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pegasos has no keyboard again. I blame commit
540c6c392f01887dcc96bef0a41e63e6c1334f01, which tries to find i8042 IRQs in
the device-tree but doesn't fall back to the old hardcoded 1 and 12 in all
failure cases.

Specifically, the case where the device-tree contains nothing matching
pnpPNP,303 or pnpPNP,f03 doesn't seem to be handled well. It sort of falls
through to the old code, but leaves the IRQs set to 0.

The last time something like this happened, I submitted a patch:
http://lists.ozlabs.org/pipermail/linuxppc-dev/2007-July/039988.html
which got committed, but afterward I was scolded for working around a bug
instead of fixing it in nvramrc.

This time I just won't send my workaround patch, at least until it's decided
that the kernel should be made to understand the device-tree as is.

If it's decided instead that the firmware should be patched... well I just
don't feel comfortable inventing my own patch for nvramrc, since it's written
in a language I don't know and presumably could brick the machine if I get it
wrong. Also I'm not even sure what the kernel is expecting to find there.

-- 
Alan Curry
