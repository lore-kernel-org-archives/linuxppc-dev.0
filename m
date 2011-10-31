Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 73841B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2011 01:19:30 +1100 (EST)
Subject: Re: RFC: ESR_I/DLK processing
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <00A1F69B-FCB7-4F45-8BE4-4C4B35D53D59@pobox.com>
Date: Mon, 31 Oct 2011 09:19:23 -0500
Message-Id: <7004CC61-3425-4D00-A8E9-BE49DDDD1D26@kernel.crashing.org>
References: <00A1F69B-FCB7-4F45-8BE4-4C4B35D53D59@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 28, 2011, at 3:43 PM, Jimi Xenidis wrote:

> arch/powerpc/kernel/head_fsl_booke.S has the following code:
>> 	/* Data Storage Interrupt */
>> 	START_EXCEPTION(DataStorage)
>> 	NORMAL_EXCEPTION_PROLOG
>> 	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass =
arg3 */
>> 	stw	r5,_ESR(r11)
>> 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass =
arg2 */
>> 	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
>> 	bne	1f
>> 	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
>> 1:
>> 	addi	r3,r1,STACK_FRAME_OVERHEAD
>> 	EXC_XFER_EE_LITE(0x0300, CacheLockingException)
>=20
>=20
> I need something similar for A2 (and all book3e) and was wondering, =
why this isn't just:
>=20
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 88abe70..8451822 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -159,6 +159,14 @@ int __kprobes do_page_fault(struct pt_regs =
*regs, unsigned long address,
>> 	}
>> #endif
>>=20
>> +#ifdef CONFIG_PPC_BOOK3E
>> +	if (error_code & (ESR_DLK|ESR_ILK)) {
>> +		/* detect that this is a privileged op and SIGILL */
>> +		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
>> +		return 0;
>> +	}
>> +#endif
>> +
>> 	if (notify_page_fault(regs))
>> 		return 0;
>=20
> Its not like this need to be fast or anything.
> I'd be happy to submit a patch that adds to fault.c and removed the =
I/DLK processing from head_fsl_booke.S
>=20
> Thoughts?
> -jx

Probably because at one point in time DSI had a fast path handling for =
us.  I've got no issues w/the proposed patch, just remember to mixup the =
CONFIG_PPC_BOOK3E as we don't define that in 32-bit fsl-booke=20

- k=
