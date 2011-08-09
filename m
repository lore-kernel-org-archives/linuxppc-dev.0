Return-Path: <xenidis@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFC60B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 01:00:50 +1000 (EST)
Received: by yxm34 with SMTP id 34so55550yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 09 Aug 2011 08:00:47 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
Subject: Re: [PATCH 3/3] powerpc: icswx: Simple ACOP fault handler for both
	book3e and book3s parts.
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <500B0F0F-658A-4B95-8BEC-978D738A926F@kernel.crashing.org>
Date: Tue, 9 Aug 2011 10:00:34 -0500
Message-Id: <7AC386D2-D272-4A7B-8433-1B4AE1CB8FF1@pobox.com>
References: <1312842408-21482-1-git-send-email-jimix@pobox.com>
	<1312842408-21482-4-git-send-email-jimix@pobox.com>
	<500B0F0F-658A-4B95-8BEC-978D738A926F@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2011, at 12:26 AM, Kumar Gala wrote:

>=20
> On Aug 8, 2011, at 5:26 PM, Jimi Xenidis wrote:
>=20
>> This patch adds a fault handler that responds to illegal Coprocessor
>> types.  Currently all CTs are treated and illegal.  There are two =
ways
>> to report the fault back to the application.  If the application used
>> the record form ("icswx.") then the architected "reject" is emulated.
>> If the application did not used the record form ("icswx") then it is
>> selectable by config whether the failure is silent (as architected) =
or
>> a SIGILL is generated.
>>=20
>> In all cases pr_warn() is used to log the bad CT.
>>=20
>> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
>> ---
>> arch/powerpc/mm/fault.c                |   16 +++++
>> arch/powerpc/mm/icswx.c                |  114 =
++++++++++++++++++++++++++++++++
>> arch/powerpc/mm/icswx.h                |   34 ++++++++++
>> arch/powerpc/platforms/Kconfig.cputype |   11 +++
>> 4 files changed, 175 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 5efe8c9..88abe70 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -43,6 +43,7 @@
>> #include <asm/tlbflush.h>
>> #include <asm/siginfo.h>
>> #include <mm/mmu_decl.h>
>> +#include <mm/icswx.h>
>>=20
>> #ifdef CONFIG_KPROBES
>> static inline int notify_page_fault(struct pt_regs *regs)
>> @@ -143,6 +144,21 @@ int __kprobes do_page_fault(struct pt_regs =
*regs, unsigned long address,
>> 	is_write =3D error_code & ESR_DST;
>> #endif /* CONFIG_4xx || CONFIG_BOOKE */
>>=20
>> +#ifdef CONFIG_PPC_ICSWX
>> +	/*
>> +	 * we need to do this early because this "data storage
>> +	 * interrupt" does not update the DAR/DEAR so we don't want to
>> +	 * look at it
>> +	 */
>> +	if (error_code & ICSWX_DSI_UCT) {
>> +		int ret;
>> +
>> +		ret =3D acop_handle_fault(regs, address, error_code);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +#endif
>> +
>> 	if (notify_page_fault(regs))
>> 		return 0;
>>=20
>> diff --git a/arch/powerpc/mm/icswx.c b/arch/powerpc/mm/icswx.c
>> index 667330e..fbf71b4 100644
>> --- a/arch/powerpc/mm/icswx.c
>> +++ b/arch/powerpc/mm/icswx.c
>> @@ -17,6 +17,9 @@
>> #include <linux/mm.h>
>> #include <linux/spinlock.h>
>> #include <linux/module.h>
>> +
>> +#include <asm/uaccess.h>
>> +
>> #include "icswx.h"
>>=20
>>=20
>> @@ -161,3 +164,114 @@ void drop_cop(unsigned long acop, struct =
mm_struct *mm)
>> 	up_read(&mm->mmap_sem);
>> }
>> EXPORT_SYMBOL_GPL(drop_cop);
>> +
>> +static int acop_use_cop(int ct)
>> +{
>> +	/* todo */
>> +	return -1;
>> +}
>> +
>> +/*
>> + * Get the instruction word at the NIP
>> + */
>> +static u32 acop_get_inst(struct pt_regs *regs)
>> +{
>> +	u32 inst;
>> +	u32 __user *p;
>> +
>> +	p =3D (u32 __user *)regs->nip;
>> +	if (!access_ok(VERIFY_READ, p, sizeof(*p)))
>> +		return 0;
>> +
>> +	if (__get_user(inst, p))
>> +		return 0;
>> +
>> +	return inst;
>> +}
>> +
>> +/**
>> + * @regs: regsiters at time of interrupt
>> + * @address: storage address
>> + * @error_code: Fault code, usually the DSISR or ESR depending on
>> + *		processor type
>> + *
>> + * Return 0 if we are able to resolve the data storage fault that
>> + * results from a CT miss in the ACOP register.
>> + */
>> +int acop_handle_fault(struct pt_regs *regs, unsigned long address,
>> +		      unsigned long error_code)
>> +{
>> +	int ct;
>> +	u32 inst =3D 0;
>> +
>> +	if (!cpu_has_feature(CPU_FTR_ICSWX)) {
>> +		pr_info("No coprocessors available");
>> +		_exception(SIGILL, regs, ILL_ILLOPN, address);
>> +	}
>> +
>> +	if (!user_mode(regs)) {
>> +		/* this could happen if the HV denies the
>> +		 * kernel access, for now we just die */
>> +		die("ICSWX from kernel failed", regs, SIGSEGV);
>> +	}
>> +
>> +	/* Some implementations leave us a hint for the CT */
>> +	ct =3D ICSWX_GET_CT_HINT(error_code);
>> +	if (ct < 0) {
>> +		/* we have to peek at the instruction work to figure out =
CT */
>> +		union cop_ccw ccw;
>=20
> don't use a union, we don't do this for any other place we decode =
instructions (just use shift/mask).  Utilize ppc-opcode.h

ack, union begone.  I'll just do the single shift below to get the CT =
since its the only spot I need it.

>=20
>> +		u32 rs;
>> +
>> +		inst =3D acop_get_inst(regs);
>> +		if (inst =3D=3D 0)
>> +			return -1;
>> +
>> +		rs =3D (inst >> (31 - 10)) & 0x1f;
>> +		ccw._val =3D regs->gpr[rs];
>> +		ct =3D ccw.ct;
>> +	}
>> +
>> +	if (!acop_use_cop(ct))
>> +		return 0;
>> +
>> +	/* at this point the CT is unknown to the system */
>> +	pr_warn("%s[%d]: Coprocessor %d is unavailable",
>> +		current->comm, current->pid, ct);
>> +
>> +	/* get inst if we don't already have it */
>> +	if (inst =3D=3D 0) {
>> +		inst =3D acop_get_inst(regs);
>> +		if (inst =3D=3D 0)
>> +			return -1;
>> +	}
>> +
>> +	/* Check if the instruction is the "record form" */
>> +	if (inst & 1) {
>> +		/*=20
>> +		 * the instruction is "record" form so we can reject
>> +		 * using CR0
>> +		 */
>> +		regs->ccr &=3D ~(0xful << 28);
>> +		regs->ccr |=3D ICSWX_RC_NOT_FOUND << 28;
>> +
>> +		/* Move on to the next instruction */
>> +		regs->nip +=3D 4;
>> +	} else {
>> +		/*
>> +		 * There is no architected mechanism to report a bad
>> +		 * CT so we could either SIGILL or report nothing.
>> +		 * Since the non-record version should only bu used
>> +		 * for "hints" or "don't care" we should probably do
>> +		 * nothing.  However, I could see how some people
>> +		 * might want an SIGILL so it here if you want it.
>> +		 */
>> +#ifdef CONFIG_ICSWX_USE_SIGILL
>> +		_exception(SIGILL, regs, ILL_ILLOPN, address);
>=20
> Where is CONFIG_ICSWX_USE_SIGILL defined? You have =
PPC_ICSWX_USE_SIGILL

ack, they are the same just a typo.

>=20
>> +#else
>> +		regs->nip +=3D 4;
>> +#endif
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acop_handle_fault);
>> diff --git a/arch/powerpc/mm/icswx.h b/arch/powerpc/mm/icswx.h
>> index 5121ddd..920d9f3 100644
>> --- a/arch/powerpc/mm/icswx.h
>> +++ b/arch/powerpc/mm/icswx.h
>> @@ -32,3 +32,37 @@ extern void free_cop_pid(int free_pid);
>> #define disable_cop_pid(m) (COP_PID_NONE)
>> #define free_cop_pid(p)
>> #endif
>> +
>> +/*
>> + * These are implementation bits for architected registers.  If this
>> + * ever becomes architecture the should be moved to reg.h et. al.
>> + */
>> +/* UCT is the same bit for Server and Embedded */
>> +#define ICSWX_DSI_UCT		0x00004000  /* Unavailable =
Coprocessor Type */
>> +
>> +#ifdef CONFIG_BOOKE
>> +/* Embedded implementation gives us no hits as to what the CT is */
>> +#define ICSWX_GET_CT_HINT(x) (-1)
>> +#else
>> +/* Server implementation contains the CT value in the DSISR */
>> +#define ICSWX_DSISR_CTMASK	0x00003f00
>> +#define ICSWX_GET_CT_HINT(x)	(((x) & ICSWX_DSISR_CTMASK) >> =
8)
>> +#endif
>> +
>> +union cop_ccw {
>> +	u32 _val;
>> +	struct {
>> +		u32 msb:8;
>> +		u32 reserved:2;
>> +		u32 ct:6;
>> +		u32 cd:16;
>> +	};
>> +};
>=20
> kill the union, move some of the opcode stuff into ppc-opcode.h

Union is gone.
Not sure what else you would like in ppc-opcode.h since everything else =
is register decode and not exactly architecture.
Can you be more specific?
-JX

>=20
>> +
>> +#define ICSWX_RC_STARTED	0x8	/* The request has been started =
*/
>> +#define ICSWX_RC_NOT_IDLE	0x4	/* No coprocessor found idle */
>> +#define ICSWX_RC_NOT_FOUND	0x2	/* No coprocessor found */
>> +#define ICSWX_RC_UNDEFINED	0x1	/* Reserved */
>> +
>> +extern int acop_handle_fault(struct pt_regs *regs, unsigned long =
address,
>> +			     unsigned long error_code);
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype =
b/arch/powerpc/platforms/Kconfig.cputype
>> index 3cd22e5..817d723 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -258,6 +258,17 @@ config PPC_ICSWX_PID
>> 	  PID register in server is used explicitly for ICSWX.  In
>> 	  embedded systems PID managment is done by the system.
>>=20
>> +config PPC_ICSWX_USE_SIGILL
>> +	bool "Should a bad CT cause a SIGILL?"
>=20
> Is there some reason to even have this cfg option?

Fixed the mismatch you pointed out above.
-jx

>=20
>> +	depends on PPC_ICSWX
>> +	default n
>> +	---help---
>> +	  Should a bad CT used for "non-record form ICSWX" cause an
>> +	  illegal intruction signal or should it be silent as
>> +	  architected.
>> +
>> +  	  If in doubt, say N here.
>> +
>> config SPE
>> 	bool "SPE Support"
>> 	depends on E200 || (E500 && !PPC_E500MC)
>> --=20
>> 1.7.0.4
>>=20
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
