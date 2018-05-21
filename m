Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qMfz52jbzF16W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:11:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LF8nUr120048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:11:04 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3wjd9bgd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:11:04 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 21 May 2018 16:11:01 +0100
Date: Mon, 21 May 2018 20:40:55 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: add test to verify rfi flush across a
 system call
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180406165546.19433-1-naveen.n.rao@linux.vnet.ibm.com>
 <877eo3nle3.fsf@concordia.ellerman.id.au>
In-Reply-To: <877eo3nle3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1526914785.dnc989oa1u.naveen@linux.ibm.com>
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
>=20
>> diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/sel=
ftests/powerpc/utils.c
>> index d46916867a6f..c6b1d20ed3ba 100644
>> --- a/tools/testing/selftests/powerpc/utils.c
>> +++ b/tools/testing/selftests/powerpc/utils.c
>> @@ -104,3 +111,149 @@ int pick_online_cpu(void)
>>  	printf("No cpus in affinity mask?!\n");
>>  	return -1;
>>  }
> ...
>> +
>> +static void sigill_handler(int signr, siginfo_t *info, void *unused)
>> +{
>> +	static int warned =3D 0;
>> +	ucontext_t *ctx =3D (ucontext_t *)unused;
>> +	unsigned int *pc =3D (unsigned int *)ctx->uc_mcontext.gp_regs[PT_NIP];
>=20
> The above doesn't work on 32-bit, and this code is sometimes built 32-bit=
.
>=20
> For an example of how to handle 32 and 64-bit, see eg:
>=20
>   tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad.c

Thanks. I'll post a v2 that addresses the 32-bit build issue.

- Naveen

=
