Message-ID: <20001116110452.B31662@lx.c-side.com>
Date: Thu, 16 Nov 2000 11:04:52 -0800
From: Neil Russell <caret@c-side.com>
To: Jacques.Menu@epfl.ch
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux/PPC assembly language documentation ?
References: <200011161356.HAA11163@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200011161356.HAA11163@lists.linuxppc.org>; from Jacques MENU on Thu, Nov 16, 2000 at 02:56:18PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


@l gives the lower 16-bits of the constant.
@h gives the upper 16-bits.
@ha gives the upper 16-bits adjusted so that carry from the lower 16-bits
    gives the correct result.

So, an example of correct use is:

	lis	r3, const@h
	ori	r3, r3, const@l

or

	lis	r3, const@ha
	addi	r3, r3, const@l

or

	lis	r3, addr@ha
	lbz	r4, addr@l(r3)

("lis rx, c" is "addis rx, rx, c").


Neil.



On Thu, Nov 16, 2000 at 02:56:18PM +0100, Jacques MENU wrote:
> I'm doing work on GNU Prolog that features a ppc_linux.c file, generating code the way shown below.
>
> I'd like to find a description of ''@ha' and '@l' used in instructions like  :
> 	addis	9,0,.Lcont001@ha
> and
> 	addi		9,9,.Lcont003@l
>
> Please answer by email too since I'm not yet a member of this list. Thanks a lot !
>
> Regards,
>
> ____________________
>
> void
> Pl_Call(char *label)
> {
> #ifndef MAP_REG_CP
>   Inst_Printf("addis", "9,0,.Lcont%d@ha", w_label);
>   Inst_Printf("addi", "9,9,.Lcont%d@l", w_label);
>   Inst_Printf("stw", "9,%s", asm_reg_cp);
> #else
>   Inst_Printf("addis", "%s,0,.Lcont%d@ha", asm_reg_cp, w_label);
>   Inst_Printf("addi", "%s,%s,.Lcont%d@l", asm_reg_cp, asm_reg_cp, w_label);
> #endif
>
>   Pl_Jump(label);
>   Label_Printf(".Lcont%d:", w_label++);
>
> #ifndef MAP_REG_E
>   if (use_envir)
>     Inst_Printf("lwz", "%s,%d(%s)", asm_reg_e, MAP_OFFSET_E, asm_reg_bank);
> #endif
> }
>
> --
> Dr Jacques MENU
> CUI - Université de Genève
>
> Tel:	++ 41 21 693 45 87
> mailto:Jacques.Menu@cui.unige.ch
> http://cui.unige.ch/~menu/1804
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
