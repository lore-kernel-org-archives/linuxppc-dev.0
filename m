Message-Id: <200011161356.HAA11163@lists.linuxppc.org>
Date: Thu, 16 Nov 2000 14:56:18 +0100
Reply-To: Jacques.Menu@epfl.ch
Content-Type: text/plain;
	charset=iso-8859-1
From: Jacques MENU <Jacques.Menu@epfl.ch>
To: linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0 (Apple Message framework v337)
Subject: Linux/PPC assembly language documentation ?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi folks,

I'm doing work on GNU Prolog that features a ppc_linux.c file, generating code the way shown below.

I'd like to find a description of ''@ha' and '@l' used in instructions like  :
	addis	9,0,.Lcont001@ha
and
	addi		9,9,.Lcont003@l

Please answer by email too since I'm not yet a member of this list. Thanks a lot !

Regards,

____________________

void
Pl_Call(char *label)
{
#ifndef MAP_REG_CP
  Inst_Printf("addis", "9,0,.Lcont%d@ha", w_label);
  Inst_Printf("addi", "9,9,.Lcont%d@l", w_label);
  Inst_Printf("stw", "9,%s", asm_reg_cp);
#else
  Inst_Printf("addis", "%s,0,.Lcont%d@ha", asm_reg_cp, w_label);
  Inst_Printf("addi", "%s,%s,.Lcont%d@l", asm_reg_cp, asm_reg_cp, w_label);
#endif

  Pl_Jump(label);
  Label_Printf(".Lcont%d:", w_label++);

#ifndef MAP_REG_E
  if (use_envir)
    Inst_Printf("lwz", "%s,%d(%s)", asm_reg_e, MAP_OFFSET_E, asm_reg_bank);
#endif
}

--
Dr Jacques MENU
CUI - Université de Genève

Tel:	++ 41 21 693 45 87
mailto:Jacques.Menu@cui.unige.ch
http://cui.unige.ch/~menu/1804

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
