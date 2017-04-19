Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7SWQ4xDbzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:44:02 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JGhluV134574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:43:51 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x6x1786p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:43:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 02:43:48 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JGhbYK36765912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:43:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JGhCJG030805
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:43:12 +1000
Date: Wed, 19 Apr 2017 16:42:50 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 6/7] powerpc: kprobes: emulate instructions on kprobe
 handler re-entry
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <0d4193a90e4b2ad3cd2ef33d41228b80a2ac9f91.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419234319.7893df9c158e565fede4a386@kernel.org>
In-Reply-To: <20170419234319.7893df9c158e565fede4a386@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492620027.h27iuc5j5o.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Masami Hiramatsu's message of April 19, 2017 20:13:
>=20
> BTW, as I pointed, 5/7 and 6/7 should be merged since this actually
> makes meaningful change.

Yes, sorry if I wasn't clear in my previous reply in the (!) previous=20
patch series.

Since this has to go through the powerpc tree, I followed this since I=20
felt that Michael Ellerman prefers to keep functional changes separate=20
from refactoring. I'm fine with either approach.

Michael?

Thanks!
- Naveen

>=20
> Thank you,
>=20
> On Wed, 19 Apr 2017 18:21:05 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> On kprobe handler re-entry, try to emulate the instruction rather than
>> single stepping always.
>>=20
>> Acked-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/kprobes.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>=20
>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes=
.c
>> index 46e8c1e03ce4..067e9863bfdf 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -276,6 +276,14 @@ int __kprobes kprobe_handler(struct pt_regs *regs)
>>  			kprobes_inc_nmissed_count(p);
>>  			prepare_singlestep(p, regs);
>>  			kcb->kprobe_status =3D KPROBE_REENTER;
>> +			if (p->ainsn.boostable >=3D 0) {
>> +				ret =3D try_to_emulate(p, regs);
>> +
>> +				if (ret > 0) {
>> +					restore_previous_kprobe(kcb);
>> +					return 1;
>> +				}
>> +			}
>>  			return 1;
>>  		} else {
>>  			if (*addr !=3D BREAKPOINT_INSTRUCTION) {
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
