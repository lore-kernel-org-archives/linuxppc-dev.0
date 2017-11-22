Return-Path: <srs0=ahuq=cu=linux.vnet.ibm.com=naveen.n.rao@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhsQS2HTyzDr5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 06:07:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yhsQS1XJZz8t37
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 06:07:12 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yhsQR59k1z9ryv
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 06:07:11 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAMJ48wC092023
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2017 14:07:09 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2edegca38g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2017 14:07:07 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Nov 2017 19:07:05 -0000
Date: Thu, 23 Nov 2017 00:37:01 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Mahesh J Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
In-Reply-To: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1511377449.2a15exj7wg.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>=20
> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
> called from native_hpte_clear(). This happens if the running kernel has
> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
> execute few RCU checks regardless of whether tracing is on or off.
> We are already in the last phase of kexec sequence in real mode with
> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
> causes kexec to fail.
>=20
> Fix this by not calling trace_tlbie() from native_hpte_clear().
>=20
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/hash_native_64.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_nati=
ve_64.c
> index 3848af1..640cf56 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -47,7 +47,8 @@
>=20
>  DEFINE_RAW_SPINLOCK(native_tlbie_lock);
>=20
> -static inline void __tlbie(unsigned long vpn, int psize, int apsize, int=
 ssize)
> +static inline unsigned long  ___tlbie(unsigned long vpn, int psize,
> +						int apsize, int ssize)
>  {
>  	unsigned long va;
>  	unsigned int penc;
> @@ -100,7 +101,15 @@ static inline void __tlbie(unsigned long vpn, int ps=
ize, int apsize, int ssize)
>  			     : "memory");
>  		break;
>  	}
> -	trace_tlbie(0, 0, va, 0, 0, 0, 0);

Does it help if you use the _rcuidle variant instead, to turn off all=20
rcu checks for tracing __tlbie()?
	trace_tlbie_rcuidle(0, 0, va, 0, 0, 0, 0);


- Naveen

=
