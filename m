Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10D71DDDE3
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Sep 2008 03:49:25 +1000 (EST)
Subject: Re: [PATCH] powerpc: add support for PAGE_SIZEs greater than 4KB for
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prodyut hazarika <prodyuth@gmail.com>
In-Reply-To: <49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
References: <1221083587-8091-1-git-send-email-yanok@emcraft.com>
	<1221083587-8091-2-git-send-email-yanok@emcraft.com>
	<49c0ff980809110957h4b7b85d4ie39dbb27d1edbe39@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 13 Sep 2008 10:49:13 -0700
Message-Id: <1221328153.7675.25.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dzu@denx.de, wd@denx.de,
	Ilya Yanok <yanok@emcraft.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-11 at 09:57 -0700, prodyut hazarika wrote:

> You should mention an example of dedicated cases (eg. RAID).
> I think this help should mention that for page size 256KB, you will
> need to have a special version of binutils, since the ELF standard
> mentions page sizes only upto 64KB.

He should also put a BIG FAT warning with 256K pages. Those will -not-
work with most existing userspace. The maximum page size supported by
the current userspace ABI is 64K as this is the alignment requirement of
our toolchain for the various program sections.

(Note that uClibc last I looked was also still broken with >4K pages but
that shouldn't be a big deal to fix).

Ben.
