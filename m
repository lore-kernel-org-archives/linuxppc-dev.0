Return-Path: <nhorman@tuxdriver.com>
Received: from smtp.tuxdriver.com (charlotte.tuxdriver.com [70.61.120.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 222771007D4
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 05:16:11 +1100 (EST)
Date: Mon, 30 Nov 2009 13:16:00 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: re-enable kexec to allow module loads with
	CONFIG_MODVERSIONS and CONFIG_RELOCATABLE turned on
Message-ID: <20091130181600.GA11583@hmsreliant.think-freely.org>
References: <20091119195216.GC11414@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091119195216.GC11414@hmsreliant.think-freely.org>
Cc: rusty@rustcorp.com.au, paulus@samba.org, nhorman@tuxdriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 19, 2009 at 02:52:16PM -0500, Neil Horman wrote:
> Hey there-
> 	Before anyone flames me for what a oddball solution this is, let me just
> say I'm trying to get the ball rolling here.  I think there may be better
> solutions that can be impemented in reloc_64.S, but I've yet to make any of the
> ones I've tried work successfully.  I'm open to suggestions, but this solution
> is the only one so far that I've been able to get to work. thanks :)
> 
> 
> Adjust crcs in __kcrctab_* sections if relocs are used with CONFIG_RELOCATABLE
> 
> When CONFIG_MODVERSIONS and CONFIG_RELOCATABLE are enabled on powerpc platforms,
> kdump has been failing in a rather odd way.  specifically modules will not
> install.  This is because when validating the crcs of symbols that the module
> needs, the crc of the module never matches the crc that is stored in the kernel.
> 
> The underlying cause of this is how CONFIG_MODVERSIONS is implemented, and how
> CONFIG_RELOCATABLE are implemented.  with CONFIG_MODVERSIONS enabled, for every
> exported symbol in the kernel we emit 2 symbols, __crc_#sym which is declared
> extern and __kcrctab_##sym, which is placed in the __kcrctab section of the
> binary.  The latter has its value set equal to the address of the former
> (recalling it is declared extern).  After the object file is built, genksyms is
> run on the processed source, and crcs are computed for each exported symbol.
> genksyms then emits a linker script which defines each of the needed __crc_##sym
> symbols, and sets their addresses euqal to their respective crcs.  This script
> is then used in a secondary link to the previously build object file, so that
> the crcs of the missing symbol can be validated on module insert.
> 
> The problem here is that because __kcrctab_sym is set equal to &__crc_##sym, a
> relocation entry is emitted by the compiler for the __kcrctab__##sym.  Normally
> this is not a problem, since relocation on other arches is done without the aid
> of .rel.dyn sections.  PPC however uses these relocations when
> CONFIG_RELOCATABLE is enabled.  nominally, since addressing starts at 0 for ppc,
> its irrelevant, but if we start at a non-zero address (like we do when booting
> via kexec from reserved crashkernel memory), the ppc boot code iterates over the
> relocation entries, and winds up adding that relocation offset to all symbols,
> including the symbols that are actually the aforementioned crc values in the
> __kcrctab_* sections.  This effectively corrupts the crcs and prevents any
> module loads from happening during a kdump.
> 
> My solution is to 'undo' these relocations prior to boot up.  If
> ARCH_USES_RELOC_ENTRIES is defined, we add a symbol at address zero to the
> linker script for that arch (I call it reloc_start, so that &reloc_start = 0).
> This symbol will then indicate the relocation offset for any given boot.  We
> also add an initcall to the module code that, during boot, scans the __kcrctab_*
> sections and subtracts &reloc_start from every entry in those sections,
> restoring the appropriate crc value.
> 
> I've verified that this allows kexec to work properly on ppc64 systems myself.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 

Paul, Ben, given that Rusty hasn't come back with any opinion on this patch, do you
feel comfortable merging it via the ppc tree?  Currently the earlyinit routine
is only compiled in and used for your arch, so I think its fairly benign.

Regards
Neil
