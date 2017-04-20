Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7qds3SZkzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:05:53 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K74NT4121658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:05:47 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x7542yfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:05:43 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 17:05:07 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K74wNZ53018760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:05:06 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K74XVT002024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:04:34 +1000
Date: Thu, 20 Apr 2017 07:04:11 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: kprobes: blacklist exception handlers
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>
References: <cover.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
 <1ec8a69d73b38e365347f0c4b6329407d8861afa.1492614257.git.naveen.n.rao@linux.vnet.ibm.com>
 <87inlz4mgp.fsf@concordia.ellerman.id.au>
In-Reply-To: <87inlz4mgp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492671481.pxvikq7i2m.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of April 20, 2017 12:03:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>=20
>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes=
.c
>> index 71286dfd76a0..59159337a097 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -112,6 +113,14 @@ kprobe_opcode_t *kprobe_lookup_name(const char *nam=
e, unsigned int offset)
>>  	return addr;
>>  }
>> =20
>> +bool arch_within_kprobe_blacklist(unsigned long addr)
>> +{
>> +	return  (addr >=3D (unsigned long)__kprobes_text_start &&
>> +		 addr < (unsigned long)__kprobes_text_end) ||
>> +		(addr >=3D (unsigned long)_stext &&
>> +		 addr < (unsigned long)__head_end);
>> +}
>=20
> This isn't quite right when the kernel is relocated.
>=20
> _stext and __head_end will be updated to point to the relocated copy of
> the kernel, eg:
>=20
> # grep -e _stext /proc/kallsyms=20
> c000000002000000 T _stext
>=20
> So you probably also want something like:
>=20
>   if (_stext !=3D PAGE_OFFSET &&
>       addr >=3D PAGE_OFFSET &&
>       addr < (PAGE_OFFSET + (__head_end - _stext)))
>       return true;

Ah, so that's for ensuring we don't allow probing at the real exception=20
vectors, which get copied down from _stext. In that case, we are covered=20
by the test for kernel_text_address() in check_kprobe_address_safe(). We=20
only allow probing from _stext to _etext.

>=20
> But that's entirely untested :)
>=20
> You can test the relocatable case by enabling CONFIG_RELOCATABLE_TEST.

Done, thanks. This is working as expected (without the need for the=20
changes above).  I am not allowed to probe at the real exception vectors=20
(and PAGE_OFFSET) as well as between _stext and __head_end.

Thanks,
Naveen

=
