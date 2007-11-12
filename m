Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18231.60427.229658.485287@cargo.ozlabs.ibm.com>
Date: Mon, 12 Nov 2007 17:00:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH] [POWERPC] Optimize counting distinct entries in the
	relocation sections
In-Reply-To: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: sfr@canb.auug.org.au, rusty@rustcorp.com.au, linuxppc-dev@ozlabs.org,
	ntl@pobox.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emil Medve writes:

> (Not sure why the relocation tables could contain lots of duplicates and why
> they are not trimmed at compile time by the linker. In some test cases, out of
> 35K relocation entries only 1.5K were distinct/unique)

Presumably you have lots of calls to the same function, or lots of
references to the same variable.

Actually I notice that count_relocs is counting all relocs, not just
the R_PPC_REL24 ones, which are all that we actually care about in
sizing the PLT.  And I would be willing to bet that every single
R_PPC_REL24 reloc has r_addend == 0.

Also I notice that even with your patch, the actual process of doing
the relocations will take time proportional to the product of the
number of PLT entries times the number of R_PPC_REL24 relocations,
since we do a linear search through the PLT entries each time.

So, two approaches suggest themselves.  Both optimize the r_addend=0
case and fall back to something like the current code if r_addend is
not zero.  The first is to use the st_other field in the symbol to
record whether we have seen a R_PPC_REL24 reloc referring to the
symbol with r_addend=0.  That would make count_relocs of complexity
O(N) for N relocs.

The second is to allocate an array with 1 pointer per symbol that
points to the PLT entry (if any) for the symbol.  The count_relocs
scan can then use that array to store a 'seen before' flag to make its
scan O(N), and do_plt_call can then later use the same array to find
PLT entries without needing the linear scan.

As far as your proposed patch is concerned, I don't like having a
function called "count_relocs" changing the array of relocations.  At
the very least it needs a different name.  But I also think we can do
better than O(N * log N), as I have explained above, if my assertion
that r_addend=0 in all the cases we care about is correct.

Paul.
