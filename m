Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7SQN58mMzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:39:40 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JGXcb2105638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:39:32 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29xb7us2gj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 12:39:26 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 02:39:19 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JGd8Wc57933938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:39:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JGch2q013485
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 02:38:44 +1000
Date: Wed, 19 Apr 2017 16:38:22 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419233750.8552f5de8ce1ed1398807284@kernel.org>
In-Reply-To: <20170419233750.8552f5de8ce1ed1398807284@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492619420.q0fv2gslsy.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Masami Hiramatsu's message of April 19, 2017 20:07:
> On Wed, 19 Apr 2017 18:21:02 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> When a kprobe is being registered, we use the symbol_name field to
>> lookup the address where the probe should be placed. Since this is a
>> user-provided field, let's ensure that the length of the string is
>> within expected limits.
>=20
> Would we really need this? Of course it may filter out longer
> strings... anyway such name should be rejected by kallsyms.

I felt this would be good to have generically, as kallsyms does many=20
string operations on the symbol name, including an unbounded strchr().

>=20
> [...]
>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> index 6a128f3a7ed1..bb86681c8a10 100644
>> --- a/kernel/kprobes.c
>> +++ b/kernel/kprobes.c
>> @@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long addr)
>>  	return false;
>>  }
>> =20
>> +bool is_valid_kprobe_symbol_name(const char *name)
>=20
> This just check the length of symbol_name buffer, and can contain
> some invalid chars.

Yes, I kept the function name generic incase we would like to do more=20
validation in future, plus it's shorter than=20
is_valid_kprobe_symbol_name_len() ;-)

>=20
>> +{
>> +	size_t sym_len;
>> +	char *s;
>> +
>> +	s =3D strchr(name, ':');

Hmm.. this should be strnchr(). I re-factored the code that moved the=20
strnlen() above this below. I'll fix this.

>> +	if (s) {
>> +		sym_len =3D strnlen(s+1, KSYM_NAME_LEN);
>=20
> If you use strnlen() here, you just need to ensure sym_len < KSYM_NAME_LE=
N.

Hmm.. not sure I follow. Are you saying the check for sym_len <=3D 0 is=20
not needed?

>=20
>> +		if (sym_len <=3D 0 || sym_len >=3D KSYM_NAME_LEN)
>> +			return false;
>> +		sym_len =3D (size_t)(s - name);
>> +		if (sym_len <=3D 0 || sym_len >=3D MODULE_NAME_LEN)
>> +			return false;
>> +	} else {
>> +		sym_len =3D strnlen(name, MODULE_NAME_LEN);
>> +		if (sym_len <=3D 0 || sym_len >=3D MODULE_NAME_LEN)
>=20
> Would you mean KSYM_NAME_LEN here?

Oops... nice catch, Thanks!

- Naveen

>=20
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  /*
>>   * If we have a symbol_name argument, look it up and add the offset fie=
ld
>>   * to it. This way, we can specify a relative address to a symbol.
>> @@ -1397,6 +1419,8 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe =
*p)
>>  		goto invalid;
>> =20
>>  	if (p->symbol_name) {
>> +		if (!is_valid_kprobe_symbol_name(p->symbol_name))
>> +			return ERR_PTR(-EINVAL);
>>  		addr =3D kprobe_lookup_name(p->symbol_name, p->offset);
>>  		if (!addr)
>>  			return ERR_PTR(-ENOENT);
>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>> index 5f688cc724f0..bf73e5f31128 100644
>> --- a/kernel/trace/trace_kprobe.c
>> +++ b/kernel/trace/trace_kprobe.c
>> @@ -704,6 +704,10 @@ static int create_trace_kprobe(int argc, char **arg=
v)
>>  			pr_info("Return probe must be used without offset.\n");
>>  			return -EINVAL;
>>  		}
>> +		if (!is_valid_kprobe_symbol_name(symbol)) {
>> +			pr_info("Symbol name is too long.\n");
>> +			return -EINVAL;
>> +		}
>>  	}
>>  	argc -=3D 2; argv +=3D 2;
>> =20
>> --=20
>> 2.12.1
>>=20
>=20
> Thanks,
>=20
> --=20
> Masami Hiramatsu <mhiramat@kernel.org>
>=20
>=20
=
