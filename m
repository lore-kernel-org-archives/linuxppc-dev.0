Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A9E51A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:16:35 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 08:16:32 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 633753E40030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:16:29 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HFGT6H31457374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:16:29 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HFGSfr013094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:16:29 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix BUG_ON() reporting in real mode on powerpc
In-Reply-To: <1455693365.3089.8.camel@gmail.com>
References: <1455684191.3089.3.camel@gmail.com>
 <20160217045606.GA19276@oak.ozlabs.ibm.com>
 <1455693365.3089.8.camel@gmail.com>
Date: Wed, 17 Feb 2016 20:46:24 +0530
Message-ID: <8760xnz7sn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

>> It might be a little better to do this:
>>=20
>> 		bugaddr =3D regs->nip;
>> 		if (REGION_ID(bugaddr) =3D=3D 0 && !(regs->msr & MSR_IR))
>> 			bugaddr +=3D PAGE_OFFSET;
>>=20
>> It is possible to execute from addresses with the 0xc000... on top in
>> real mode, because the CPU ignores the top 4 address bits in real
>> mode.
>
> Good catch! Thank you
>
> Changelog:
>      Don't add PAGE_OFFSET blindly, check if REGION_ID is 0
>
> I ran into this issue while debugging an early boot problem.
> The system hit a BUG_ON() but report bug failed to print the
> line number and file name. The reason being that the system
> was running in real mode and report_bug() searches for
> addresses in the PAGE_OFFSET+ region
>
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
> =C2=A0arch/powerpc/kernel/traps.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index b6becc7..4de4fe7 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1148,6 +1148,7 @@ void __kprobes program_check_exception(struct pt_re=
gs *regs)
> =C2=A0		goto bail;
> =C2=A0	}
> =C2=A0	if (reason & REASON_TRAP) {
> +		unsigned long bugaddr;
> =C2=A0		/* Debugger is first in line to stop recursive faults in
> =C2=A0		=C2=A0* rcu_lock, notify_die, or atomic_notifier_call_chain */
> =C2=A0		if (debugger_bpt(regs))
> @@ -1158,8 +1159,12 @@ void __kprobes program_check_exception(struct pt_r=
egs *regs)
> =C2=A0				=3D=3D NOTIFY_STOP)
> =C2=A0			goto bail;
> =C2=A0
> +		bugaddr =3D regs->nip;
> +		if ((REGION_ID(bugaddr) =3D=3D 0) && !(regs->msr & MSR_IR))
> +			bugaddr +=3D PAGE_OFFSET;
> +

Can we add some comments around this. When i looked at this first, i was
wondering how nip can be in user region. But then realized that what we
are checking here is kernel address used in real mode. The use of
REGION_ID eventhough simpler is confusing. Hence adding the comment with
details Paul mentioned in email will help.


> =C2=A0		if (!(regs->msr & MSR_PR) &&=C2=A0=C2=A0/* not user-mode */
> -		=C2=A0=C2=A0=C2=A0=C2=A0report_bug(regs->nip, regs) =3D=3D BUG_TRAP_TY=
PE_WARN) {
> +		=C2=A0=C2=A0=C2=A0=C2=A0report_bug(bugaddr, regs) =3D=3D BUG_TRAP_TYPE=
_WARN) {
> =C2=A0			regs->nip +=3D 4;
> =C2=A0			goto bail;
> =C2=A0		}
> --=C2=A0

-aneesh
