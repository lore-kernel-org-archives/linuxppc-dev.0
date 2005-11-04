Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0222968672
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2005 06:20:43 +1100 (EST)
Date: Fri, 4 Nov 2005 11:20:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <17249.30677.31240.212459@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0511041115000.28804@g5.osdl.org>
References: <17249.30677.31240.212459@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: ppc32/64 merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Paul, I get:

  arch/ppc64/include/asm/elf.h:190:8: warning: memset with byte count of -160

when checking ppc64 with sparse.

It looks like it's even correct. I think elf_gregset_t gets set to 
elf_gregset_t32, which is why "struct pt_regs" is so much bigger than 
elf_gregset_t.

Maybe it's a sparse bug. And maybe it isn't.

			Linus
