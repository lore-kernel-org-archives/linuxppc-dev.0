Return-Path: <york.sun@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0074.outbound.protection.outlook.com [104.47.2.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnSQz0HmWzDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 01:38:17 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Leo Li
 <leoyang.li@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Wed, 6 Sep 2017 15:38:10 +0000
Message-ID: <VI1PR04MB2078E4FFD1B27961F63D88689A970@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1504265576.20777.61.camel@infinera.com>
 <1504600831.27247.20.camel@infinera.com>
Reply-To: York Sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott is no longer with Freescale/NXP. Adding Leo.=0A=
=0A=
On 09/05/2017 01:40 AM, Joakim Tjernlund wrote:=0A=
> So after some debugging I found this bug:=0A=
> @@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)=0A=
>          if (is_in_pci_mem_space(addr)) {=0A=
>                  if (user_mode(regs)) {=0A=
>                          pagefault_disable();=0A=
> -                       ret =3D get_user(regs->nip, &inst);=0A=
> +                       ret =3D get_user(inst, (__u32 __user *)regs->nip)=
;=0A=
>                          pagefault_enable();=0A=
>                  } else {=0A=
>                          ret =3D probe_kernel_address(regs->nip, inst);=
=0A=
> =0A=
> However, the kernel still locked up after fixing that.=0A=
> Now I wonder why this fixup is there in the first place? The routine=0A=
> will not really fixup the insn, just return 0xffffffff for the failing=0A=
> read and then advance the process NIP.=0A=
> =0A=
> Removing the fixup does not help either, kernel still locks up:=0A=
> [   28.170532] Machine check in kernel mode.=0A=
> [   28.174538] Caused by (from MCSR=3D10008):=0A=
> [   28.182804] Bus - Read Data Bus Error: DAR:b7013000=0A=
> [   28.197079] Oops: Machine check, sig: 7 [#1]=0A=
> [   28.201343] P1010 RDB=0A=
> [   28.203608] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) l=
inux_kernel_bde(PO)=0A=
> [   28.211796] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O  =
  4.1.38+ #201=0A=
> [   28.219540] task: db16ed10 ti: df122000 task.ti: df122000=0A=
> [   28.224935] NIP: 10a4e2f4 LR: 10a4e404 CTR: 10046c38=0A=
> [   28.229896] REGS: df123f10 TRAP: 0204   Tainted: P           O     (4.=
1.38+)=0A=
> [   28.236942] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000=
=0A=
> [   28.243306] DEAR: b7013000 ESR: 00000000=0A=
> GPR00: 10a4e404 bfab2730 b7b354a0 132f9fa8 07006000 07000000 00000000 132=
f9fd8=0A=
> GPR08: b6fd5000 b6fe5000 0003e000 bfab2720 24004424 11d6cf7c 00000000 000=
00000=0A=
> GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 000=
00001=0A=
> GPR24: 01a5bd3e 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 000=
00000=0A=
> [   28.275547] NIP [10a4e2f4] 0x10a4e2f4=0A=
> [   28.279204] LR [10a4e404] 0x10a4e404=0A=
> [   28.282772] Call Trace:=0A=
> [   28.285213] ---[ end trace 9f8b64ab1e83f449 ]---=0A=
> [   28.289825]=0A=
> =0A=
> =0A=
>   Jocke=0A=
> =0A=
> On Fri, 2017-09-01 at 13:32 +0200, Joakim Tjernlund wrote:=0A=
>> I am trying to debug a Machine Check for a P2010 (e500v2) CPU:=0A=
>>=0A=
>> [   28.111816] Caused by (from MCSR=3D10008): Bus - Read Data Bus Error=
=0A=
>> [   28.117998] Oops: Machine check, sig: 7 [#1]=0A=
>> [   28.122263] P1010 RDB=0A=
>> [   28.124529] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) =
linux_kernel_bde(PO)=0A=
>> [   28.132718] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O =
   4.1.38+ #49=0A=
>> [   28.140376] task: db16cd10 ti: df128000 task.ti: df128000=0A=
>> [   28.145770] NIP: 00000000 LR: 10a4e404 CTR: 10046c38=0A=
>> [   28.150730] REGS: df129f10 TRAP: 0204   Tainted: P           O     (4=
.1.38+)=0A=
>> [   28.157776] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000=
=0A=
>> [   28.164140] DEAR: b7187000 ESR: 00000000=0A=
>> GPR00: 10a4e404 bf86ea30 b7ca94a0 132f9fa8 07006000 07000000 00000000 13=
2f9fd8=0A=
>> GPR08: b7149000 b7159000 0003e000 bf86ea20 24004424 11d6cf7c 00000000 00=
000000=0A=
>> GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 00=
000001=0A=
>> GPR24: 01a4d12d 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 00=
000000=0A=
>> [   28.196375] NIP [00000000]   (null)=0A=
>> [   28.199859] LR [10a4e404] 0x10a4e404=0A=
>> [   28.203426] Call Trace:=0A=
>> [   28.205866] ---[ end trace f456255ddf9bee83 ]---=0A=
>>=0A=
>> I cannot figure out why NIP is NULL ? It LOOKs like NIP is set to=0A=
>> MCSRR0 early on but maybe it is lost somehow?=0A=
>>=0A=
>> Anyhow, looking at entry_32.S:=0A=
>> 	.globl	mcheck_transfer_to_handler=0A=
>> mcheck_transfer_to_handler:=0A=
>> 	mfspr	r0,SPRN_DSRR0=0A=
>> 	stw	r0,_DSRR0(r11)=0A=
>> 	mfspr	r0,SPRN_DSRR1=0A=
>> 	stw	r0,_DSRR1(r11)=0A=
>> 	/* fall through */=0A=
>>=0A=
>> 	.globl	debug_transfer_to_handler=0A=
>> debug_transfer_to_handler:=0A=
>> 	mfspr	r0,SPRN_CSRR0=0A=
>> 	stw	r0,_CSRR0(r11)=0A=
>> 	mfspr	r0,SPRN_CSRR1=0A=
>> 	stw	r0,_CSRR1(r11)=0A=
>> 	/* fall through */=0A=
>>=0A=
>> 	.globl	crit_transfer_to_handler=0A=
>> crit_transfer_to_handler:=0A=
>>=0A=
>> It looks odd that DSRRx is assigned in mcheck and CSRRx in debug and=0A=
>> crit has none. Should not this assigment be shifted down one level?=0A=
>>=0A=
>>    Jocke=0A=
> =0A=
=0A=
