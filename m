Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 866EFDDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 04:07:38 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH][v2] powerpc 44x: support for 256KB PAGE_SIZE
References: <200812211446.56783.yur@emcraft.com>
Date: Sun, 21 Dec 2008 18:07:27 +0100
In-Reply-To: <200812211446.56783.yur@emcraft.com> (Yuri Tikhonov's message of
	"Sun, 21 Dec 2008 14:46:56 +0300")
Message-ID: <je4p0x319s.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yuri Tikhonov <yur@emcraft.com> writes:

> Because ELF standard supports only page sizes up to 64K, then you should
> use patched binutils for building applications to be run with the 256KB-
> page sized kernel. The patch for binutils is rather trivial, and may
> look as follows:
>
> --- binutils/bfd/elf32-ppc.c.orig
> +++ binutils/bfd/elf32-ppc.c
>
> -#define ELF_MAXPAGESIZE                0x10000
> +#define ELF_MAXPAGESIZE                0x40000

You don't have to patch it, it's enough to pass -zmax-page-size=0x40000
to the linker.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
