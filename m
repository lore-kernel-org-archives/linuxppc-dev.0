Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4765CDDF58
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 15:19:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Message-ID: <18906.57833.843101.770634@drongo.ozlabs.ibm.com>
Date: Tue, 7 Apr 2009 15:17:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Move dtc and libfdt sources from arch/powerpc/boot to scripts/dtc
In-Reply-To: <20090331044701.GD25418@yookeroo.seuss>
References: <20090331044701.GD25418@yookeroo.seuss>
Cc: Andrew Morton <akpm@osdl.org>, monstr@monstr.eu,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, Michal Simek <monstr@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> The vast bulk of this patch is a literal move, the rest is adjusting
> the various Makefiles to use dtc and libfdt correctly from their new
> locations.

Did you test this with a separate object directory?  I get:

$ make O=../test-64k V=1
[snip]
  gcc -Wp,-MD,scripts/dtc/.dtc-lexer.lex.o.d -Iscripts/dtc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -I/home/paulus/kernel/powerpc/scripts/dtc/libfdt -Iscripts/dtc/libfdt -c -o scripts/dtc/dtc-lexer.lex.o scripts/dtc/dtc-lexer.lex.c
dtc-lexer.l:37:17: error: dtc.h: No such file or directory
dtc-lexer.l:38:20: error: srcpos.h: No such file or directory
In file included from dtc-lexer.l:39:
dtc-parser.y:42: error: expected specifier-qualifier-list before ,F!(Buint8_t,F"(B

followed by lots more errors.

Paul.
