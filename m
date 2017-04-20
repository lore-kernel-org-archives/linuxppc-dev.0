Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7qzX1bxyzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:21:11 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3K7E7Hp044760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:21:09 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xaptynb6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 03:21:05 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 17:20:26 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3K7KFPQ7078288
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:20:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3K7JoRs015278
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 17:19:51 +1000
Date: Thu, 20 Apr 2017 07:19:28 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
To: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <87o9vr4nm3.fsf@concordia.ellerman.id.au>
In-Reply-To: <87o9vr4nm3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492672015.e5bcoosx02.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of April 20, 2017 11:38:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>=20
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 6a128f3a7ed1..bb86681c8a10 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long addr)
>>  	return false;
>>  }
>> =20
>> +bool is_valid_kprobe_symbol_name(const char *name)
>> +{
>> +	size_t sym_len;
>> +	char *s;
>> +
>> +	s =3D strchr(name, ':');
>> +	if (s) {
>> +		sym_len =3D strnlen(s+1, KSYM_NAME_LEN);
>> +		if (sym_len <=3D 0 || sym_len >=3D KSYM_NAME_LEN)
>> +			return false;
>> +		sym_len =3D (size_t)(s - name);
>> +		if (sym_len <=3D 0 || sym_len >=3D MODULE_NAME_LEN)
>> +			return false;
>> +	} else {
>> +		sym_len =3D strnlen(name, MODULE_NAME_LEN);
>> +		if (sym_len <=3D 0 || sym_len >=3D MODULE_NAME_LEN)
>> +			return false;
>> +	}
>=20
> I think this is probably more elaborate than it needs to be.
>=20
> Why not just check the string is <=3D (MODULE_NAME_LEN + KSYM_NAME_LEN) ?

Yes, that would be sufficient for now.

It's probably just me being paranoid, but I felt it's good to have=20
stricter checks for user-provided strings, to guard against future=20
changes to how we process this.

- Naveen

=
