Return-Path: <Emilian.Medve@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Optimize counting distinct entries in the
	relocation sections
Date: Mon, 12 Nov 2007 09:50:45 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E270174DB3E@az33exm24.fsl.freescale.net>
In-Reply-To: <18231.60427.229658.485287@cargo.ozlabs.ibm.com>
References: <1194564963-15626-1-git-send-email-Emilian.Medve@Freescale.com>
	<18231.60427.229658.485287@cargo.ozlabs.ibm.com>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
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

Hello Paul,


> Actually I notice that count_relocs is counting all relocs, not just
> the R_PPC_REL24 ones, which are all that we actually care about in
> sizing the PLT.  And I would be willing to bet that every single
> R_PPC_REL24 reloc has r_addend =3D=3D 0.

I'll count only the R_PPC_REL24 and I'll validate if they have r_addend
=3D=3D 0.

> Also I notice that even with your patch, the actual process of doing
> the relocations will take time proportional to the product of the
> number of PLT entries times the number of R_PPC_REL24 relocations,
> since we do a linear search through the PLT entries each time.

The reason I started working on this patch was because the kernel
detected a soft lockup in count_relocs(). It didn't complain about other
parts so I did nothing about them.

> So, two approaches suggest themselves.  Both optimize the r_addend=3D0
> case and fall back to something like the current code if r_addend is
> not zero.  The first is to use the st_other field in the symbol to
> record whether we have seen a R_PPC_REL24 reloc referring to the
> symbol with r_addend=3D0.  That would make count_relocs of complexity
> O(N) for N relocs.

Will look into it.

> The second is to allocate an array with 1 pointer per symbol that
> points to the PLT entry (if any) for the symbol.  The count_relocs
> scan can then use that array to store a 'seen before' flag to make its
> scan O(N), and do_plt_call can then later use the same array to find
> PLT entries without needing the linear scan.

This uses extra memory (which could be 'significant' for small boards)
and I was trying to avoid that.


> As far as your proposed patch is concerned, I don't like having a
> function called "count_relocs" changing the array of relocations.  At
> the very least it needs a different name.  But I also think we can do
> better than O(N * log N), as I have explained above, if my assertion
> that r_addend=3D0 in all the cases we care about is correct.

The array of relocations is not changed in count_relocs() but in
get_plt_size().


Thanks for your time and patience,
Emil.
