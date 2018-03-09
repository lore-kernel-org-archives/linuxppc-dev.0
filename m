Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyR0Z5SxjzF1rm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 23:05:34 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w29C54fd032647
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 07:05:31 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gksnc8q6p-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 07:05:31 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 12:05:29 -0000
Date: Fri, 09 Mar 2018 17:35:25 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <87efkve0a2.fsf@concordia.ellerman.id.au>
 <1520581934.wrzeu3w6z6.naveen@linux.ibm.com>
 <87ina5v91g.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ina5v91g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1520595927.fm6mw6c4zi.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> My earlier assumption was that we have other scenarios when we are in=20
>> realmode (specifically with MSR_RI unset) where we won't be able to=20
>> recover from a trap, during function tracing (*). I did a set of=20
>> experiments yesterday to verify that, but I was not able to uncover=20
>> any such scenarios with my brief testing. So, we seem to be=20
>> functioning just fine while tracing realmode C code, except for KVM.
>=20
> Hmm. If MSR_RI is clear then that should indicate that you can't recover
> from an interrupt, typically because you'd lose state in SRR0/1. So I
> would expect things to go badly in that case.

Yes, so it looks like we aren't calling into any C code (that isn't=20
already annotated with 'notrace') with MSR_RI unset. At least, with the=20
usual interrupt handling on powernv. I tested this by putting a 'trap'=20
in the function tracer callback after the recursion test. This forces a=20
trap for each function that we trace non-recursively.

There may be other paths where we do so, but it isn't as pervasive as I=20
previously thought. So, we should be able to exclude those paths using=20
the paca field, as and when we find them.

- Naveen

=
