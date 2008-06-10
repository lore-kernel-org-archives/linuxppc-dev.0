Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07766DDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 17:20:26 +1000 (EST)
Subject: Re: linux-next: powerpc build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080610165441.a7c5ddd0.sfr@canb.auug.org.au>
References: <20080610165441.a7c5ddd0.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 17:20:09 +1000
Message-Id: <1213082409.25745.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-10 at 16:54 +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> Today's linux-next tree build (powerpc ppc64_defconfig) failed like this:
> 
>   UPD     include/linux/compile.h
> arch/powerpc/mm/built-in.o: In function `ht64_insert_pte':
> hash_native_64.c:(.text+0x4756): undefined reference to `_PAGE_HPTE_SUB0'
> 
> I have reverted commit 2d9a973b0fee245af43b73412a08e88bc955644d
> ("powerpc: Free a PTE bit on ppc64 with 64K pages") for now.

Yup, that's the way to go. It's broken, I'll have to do things a bit
differently, I "forgot" our 64K SPU hack when using 4K pages assumes
we have the same PTE format :-( I'll have to implement a separate low
level asm function for hashing 64K pages on a 4K kernel.

Ben.
