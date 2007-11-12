Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] Optimize counting distinct entries in the
	relocation sections
Date: Mon, 12 Nov 2007 19:01:38 +1100
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
	<18231.60427.229658.485287@cargo.ozlabs.ibm.com>
In-Reply-To: <18231.60427.229658.485287@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711121901.39163.rusty@rustcorp.com.au>
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org, ntl@pobox.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 12 November 2007 17:00:43 Paul Mackerras wrote:
> Emil Medve writes:
> > (Not sure why the relocation tables could contain lots of duplicates and
> > why they are not trimmed at compile time by the linker. In some test
> > cases, out of 35K relocation entries only 1.5K were distinct/unique)
>
> Presumably you have lots of calls to the same function, or lots of
> references to the same variable.

Yes, and objdump -r is your friend here.  It might be worth checking that 
we're counting relocs in a section we actually care about (ie. it's 
SHF_ALLOC).

It'd be a shame to optimize this only to find it could be fixed with a 
one-liner.

> The first is to use the st_other field in the symbol to
> record whether we have seen a R_PPC_REL24 reloc referring to the
> symbol with r_addend=0.  That would make count_relocs of complexity
> O(N) for N relocs.

Just note when you implement this: there may be two PLT entries per symbol: 
one for init code and one for core code.  But that's just two bits.

If Paul is right about r_addend=0 being common, you can simply count unique 
occurences of that, and add all the r_addend != 0 cases as if they were 
unique (note: it's fine to over-estimate).

> As far as your proposed patch is concerned, I don't like having a
> function called "count_relocs" changing the array of relocations.  At
> the very least it needs a different name.

Yes, and it should also return "u32" not "uint32_t" if you're going to change 
the return type.

Cheers,
Rusty.
