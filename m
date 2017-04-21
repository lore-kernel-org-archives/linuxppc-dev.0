Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8c275yshzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:26:07 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LDOGB2039379
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:26:01 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y0hem7db-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:26:00 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 23:25:58 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3LDPklI66978036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:25:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3LDPHuX029355
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:25:17 +1000
Date: Fri, 21 Apr 2017 13:25:00 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/7] kprobes: validate the symbol name provided during
 probe registration
To: Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, pc@us.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123234.6895-1-naveen.n.rao@linux.vnet.ibm.com>
 <dc950d45-4e98-9bd7-d435-4a6005507f94@us.ibm.com>
In-Reply-To: <dc950d45-4e98-9bd7-d435-4a6005507f94@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492781012.pcpyah5v9j.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Paul Clarke's message of April 21, 2017 18:41:
> a nit or two, below...
>=20
> On 04/21/2017 07:32 AM, Naveen N. Rao wrote:
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 6a128f3a7ed1..ff9b1ac72a38 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1383,6 +1383,34 @@ bool within_kprobe_blacklist(unsigned long addr)
>>  }
>>=20
>>  /*
>> + * We mainly want to ensure that the provided string is of a reasonable=
 length
>> + * and is of the form [<mod_name>:]<sym_name>, so that this is safe to =
process
>> + * further.
>> + * We don't worry about invalid characters as those will just prevent
>> + * matching existing kallsyms.
>> + */
>> +bool is_valid_kprobe_symbol_name(const char *name)
>> +{
>> +	size_t sym_len;
>> +	const char *s;
>> +
>> +	s =3D strnchr(name, ':', MODULE_NAME_LEN + KSYM_NAME_LEN + 1);
>> +	if (s) {
>> +		sym_len =3D (size_t)(s - name);
>> +		if (sym_len <=3D 0  || sym_len >=3D MODULE_NAME_LEN)
>=20
> "sym_len <=3D 0" looks odd here, since sym_len is likely unsigned and wou=
ld never be less than zero, anyway.

Ugh.. habits :/
I'll wait for Masami/Michael's feedback before re-spinning.

Thanks for the review,
- Naveen

=
