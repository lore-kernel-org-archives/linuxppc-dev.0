Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404lby6W2JzF1bM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 05:54:38 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2JIsKmS076286
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 14:54:36 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gtgq3nqqk-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 14:54:36 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 19 Mar 2018 18:54:34 -0000
Date: Tue, 20 Mar 2018 00:24:27 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras
 <paulus@ozlabs.org>, sathnaga@linux.vnet.ibm.com
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180319101344.72144f30@gandalf.local.home>
In-Reply-To: <20180319101344.72144f30@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521485608.a0kau5nu5z.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Mon, 19 Mar 2018 14:43:00 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/power=
pc/kernel/trace/ftrace_64_mprofile.S
>> index 3f3e81852422..fdf702b4df25 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> @@ -60,6 +60,19 @@ _GLOBAL(ftrace_caller)
>>  	mfxer   r10
>>  	mfcr	r11
>> =20
>> +#ifdef CONFIG_KVM
>> +	lbz	r3, PACA_FTRACE_DISABLED(r13)
>> +	cmpdi	r3, 0
>> +	beq	1f
>> +	mflr	r3
>> +	mtctr	r3
>> +	REST_GPR(3, r1)
>> +	addi	r1, r1, SWITCH_FRAME_SIZE
>> +	mtlr	r0
>> +	bctr
>> +1:
>> +#endif
>=20
> I wonder if we should try to move the return out of the fast path (for
> cache reasons), as most of the time the above compare will be true. That
> is:
>=20
> #ifdef CONFIG_KVM
> 	lbz	r3, PACA_FTRACE_DISABLED(r13)
> 	cmpdi	r3, 0
> 	bne	no_trace
> #endif
>=20
> /* rest of ftrace_caller code */
>=20
> /* after ftrace_caller... */
>         bctr                    /* jump after _mcount site */
>=20
> #ifdef	CONFIG_KVM
> no_trace:
> 	mflr	r3
> 	mtctr	r3
> 	REST_GPR(3, r1)
> 	addi	r1, r1, SWITCH_FRAME_SIZE
> 	mtlr	r0
> 	bctr
> #endif

Thanks, I'll incorporate those changes in my next version.

- Naveen

=
