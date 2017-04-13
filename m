Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3ZJH6ySyzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 18:50:55 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D8mqk7027465
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 04:50:43 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29t19xtyt5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 04:50:43 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 14:20:40 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3D8oWFW18546714
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:20:32 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3D8oaX8025635
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 14:20:37 +0530
Date: Thu, 13 Apr 2017 08:50:33 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/5] powerpc: kprobes: factor out code to emulate
 instruction into a helper
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <6058a453bd013d5fad41201c01915889cccb0ac6.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170413133448.d13e8489238b4dc8bee9471c@kernel.org>
In-Reply-To: <20170413133448.d13e8489238b4dc8bee9471c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492073293.wa42fra50w.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Masami Hiramatsu's message of April 13, 2017 10:04:
> On Wed, 12 Apr 2017 16:28:27 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> This helper will be used in a subsequent patch to emulate instructions
>> on re-entering the kprobe handler. No functional change.
>=20
> In this case, please merge this patch into the next patch which
> actually uses the factored out function unless that changes
> too much.

In hindsight, this patch actually just refactors the code so that the=20
helper can be re-used subsequently. Using the helper constitutes a=20
separate unrelated change, so I'm keeping this patch as is. I am=20
updating the description to convey this better.

- Naveen

>=20
> Thank you,
>=20
>>=20
>> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/kprobes.c | 52 ++++++++++++++++++++++++++----------=
-------
>>  1 file changed, 31 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes=
.c
>> index 0732a0291ace..8b48f7d046bd 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -207,6 +207,35 @@ void __kprobes arch_prepare_kretprobe(struct kretpr=
obe_instance *ri,
>>  	regs->link =3D (unsigned long)kretprobe_trampoline;
>>  }
>> =20
>> +int __kprobes try_to_emulate(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +	int ret;
>> +	unsigned int insn =3D *p->ainsn.insn;
>> +
>> +	/* regs->nip is also adjusted if emulate_step returns 1 */
>> +	ret =3D emulate_step(regs, insn);
>> +	if (ret > 0) {
>> +		/*
>> +		 * Once this instruction has been boosted
>> +		 * successfully, set the boostable flag
>> +		 */
>> +		if (unlikely(p->ainsn.boostable =3D=3D 0))
>> +			p->ainsn.boostable =3D 1;
>> +	} else if (ret < 0) {
>> +		/*
>> +		 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
>> +		 * So, we should never get here... but, its still
>> +		 * good to catch them, just in case...
>> +		 */
>> +		printk("Can't step on instruction %x\n", insn);
>> +		BUG();
>> +	} else if (ret =3D=3D 0)
>> +		/* This instruction can't be boosted */
>> +		p->ainsn.boostable =3D -1;
>> +
>> +	return ret;
>> +}
>> +
>>  int __kprobes kprobe_handler(struct pt_regs *regs)
>>  {
>>  	struct kprobe *p;
>> @@ -302,18 +331,9 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>> =20
>>  ss_probe:
>>  	if (p->ainsn.boostable >=3D 0) {
>> -		unsigned int insn =3D *p->ainsn.insn;
>> +		ret =3D try_to_emulate(p, regs);
>> =20
>> -		/* regs->nip is also adjusted if emulate_step returns 1 */
>> -		ret =3D emulate_step(regs, insn);
>>  		if (ret > 0) {
>> -			/*
>> -			 * Once this instruction has been boosted
>> -			 * successfully, set the boostable flag
>> -			 */
>> -			if (unlikely(p->ainsn.boostable =3D=3D 0))
>> -				p->ainsn.boostable =3D 1;
>> -
>>  			if (p->post_handler)
>>  				p->post_handler(p, regs, 0);
>> =20
>> @@ -321,17 +341,7 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>>  			reset_current_kprobe();
>>  			preempt_enable_no_resched();
>>  			return 1;
>> -		} else if (ret < 0) {
>> -			/*
>> -			 * We don't allow kprobes on mtmsr(d)/rfi(d), etc.
>> -			 * So, we should never get here... but, its still
>> -			 * good to catch them, just in case...
>> -			 */
>> -			printk("Can't step on instruction %x\n", insn);
>> -			BUG();
>> -		} else if (ret =3D=3D 0)
>> -			/* This instruction can't be boosted */
>> -			p->ainsn.boostable =3D -1;
>> +		}
>>  	}
>>  	prepare_singlestep(p, regs);
>>  	kcb->kprobe_status =3D KPROBE_HIT_SS;
>> --=20
>> 2.12.1
>>=20
>=20
>=20
> --=20
> Masami Hiramatsu <mhiramat@kernel.org>
>=20
>=20
=
