Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxMnV4v7DzF1jR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 05:37:18 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w27IYbKb146747
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Mar 2018 13:37:14 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gjk4eenx3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 13:37:14 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 7 Mar 2018 18:37:12 -0000
Date: Thu, 08 Mar 2018 00:07:07 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras
 <paulus@ozlabs.org>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180307124553.312ea88c@vmware.local.home>
In-Reply-To: <20180307124553.312ea88c@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1520447419.431mwwg71x.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steve,

Steven Rostedt wrote:
> On Wed,  7 Mar 2018 22:16:19 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> We can't take a trap in most parts of real mode code. Instead of adding
>> the 'notrace' annotation to all C functions that can be invoked from
>> real mode, detect that we are in real mode on ftrace entry and return
>> back.
>>=20
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>> This RFC only handles -mprofile-kernel to demonstrate the approach being=
=20
>> considered. We will need to handle other ftrace entry if we decide to=20
>> continue down this path.
>=20
> I do prefer this trade off.

Great, thanks!

>=20
>=20
>> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/power=
pc/kernel/trace/ftrace_64_mprofile.S
>> index 3f3e81852422..ecc0e8e38ead 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> @@ -56,6 +56,21 @@ _GLOBAL(ftrace_caller)
>> =20
>>  	/* Load special regs for save below */
>>  	mfmsr   r8
>> +
>> +	/* Only proceed if we are not in real mode and can take interrupts */
>> +	andi.	r9, r8, MSR_IR|MSR_DR|MSR_RI
>> +	cmpdi	r9, MSR_IR|MSR_DR|MSR_RI
>> +	beq	1f
>=20
> OK, I assume this check and branch is negligible compared to the mfmsr
> call?

Yes, that's negligible.
Though, to be honest, I will have to introduce a 'mfmsr' for the older=20
-pg variant. I still think that the improved reliability far outweighs=20
the minor slowdown there.

- Naveen

=
