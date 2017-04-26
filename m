Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCpqq2KW2zDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:43:19 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3QIcwTZ001249
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 14:43:16 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2yhq4cbh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 14:43:16 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 27 Apr 2017 04:43:13 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3QIh3xF6357248
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:43:11 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3QIgcWt010510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 04:42:39 +1000
Date: Wed, 26 Apr 2017 18:42:18 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kprobes: refactor kprobe_lookup_name for safer
 string operations
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, David Laight
 <David.Laight@ACULAB.COM>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Clarke <pc@us.ibm.com>
References: <20170425160711.15332-1-naveen.n.rao@linux.vnet.ibm.com>
 <20170426134118.d1d14c5e48e65f194b56f11d@kernel.org>
In-Reply-To: <20170426134118.d1d14c5e48e65f194b56f11d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1493232011.n7d4slc7ao.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Masami Hiramatsu's message of April 26, 2017 10:11:
> On Tue, 25 Apr 2017 21:37:11 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Use safer string manipulation functions when dealing with a
>> user-provided string in kprobe_lookup_name().
>>=20
>> Reported-by: David Laight <David.Laight@ACULAB.COM>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++------------------=
-------
>>  1 file changed, 20 insertions(+), 27 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes=
.c
>> index 160ae0fa7d0d..5a17e6467be9 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -53,7 +53,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>> =20
>>  kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offs=
et)
>>  {
>> -	kprobe_opcode_t *addr;
>> +	kprobe_opcode_t *addr =3D NULL;
>> =20
>>  #ifdef PPC64_ELF_ABI_v2
>>  	/* PPC64 ABIv2 needs local entry point */
>> @@ -85,36 +85,29 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name=
, unsigned int offset)
>>  	 * Also handle <module:symbol> format.
>>  	 */
>>  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
>> -	const char *modsym;
>>  	bool dot_appended =3D false;
>> -	if ((modsym =3D strchr(name, ':')) !=3D NULL) {
>> -		modsym++;
>> -		if (*modsym !=3D '\0' && *modsym !=3D '.') {
>> -			/* Convert to <module:.symbol> */
>> -			strncpy(dot_name, name, modsym - name);
>> -			dot_name[modsym - name] =3D '.';
>> -			dot_name[modsym - name + 1] =3D '\0';
>> -			strncat(dot_name, modsym,
>> -				sizeof(dot_name) - (modsym - name) - 2);
>> -			dot_appended =3D true;
>> -		} else {
>> -			dot_name[0] =3D '\0';
>> -			strncat(dot_name, name, sizeof(dot_name) - 1);
>> -		}
>> -	} else if (name[0] !=3D '.') {
>> -		dot_name[0] =3D '.';
>> -		dot_name[1] =3D '\0';
>> -		strncat(dot_name, name, KSYM_NAME_LEN - 2);
>> +	const char *c;
>> +	ssize_t ret =3D 0;
>> +	int len =3D 0;
>> +
>> +	if ((c =3D strnchr(name, MODULE_NAME_LEN, ':')) !=3D NULL) {
>> +		c++;
>> +		len =3D c - name;
>> +		memcpy(dot_name, name, len);
>> +	} else
>> +		c =3D name;
>> +
>> +	if (*c !=3D '\0' && *c !=3D '.') {
>> +		dot_name[len++] =3D '.';
>>  		dot_appended =3D true;
>> -	} else {
>> -		dot_name[0] =3D '\0';
>> -		strncat(dot_name, name, KSYM_NAME_LEN - 1);
>>  	}
>> -	addr =3D (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
>> -	if (!addr && dot_appended) {
>> -		/* Let's try the original non-dot symbol lookup	*/
>> +	ret =3D strscpy(dot_name + len, c, KSYM_NAME_LEN);
>> +	if (ret >=3D 0)
>=20
> Here, maybe you can skip the case of ret =3D=3D 0. (Or, would we have
> a symbol which only has "."?)

Ah, indeed. Good point. We just need the test to be (ret > 0).

Michael,
If the rest of the patch is fine by you, would you be ok to make the=20
small change above? If not, please let me know and I'll re-spin. Thanks.

>=20
> Others look good to me.

Thanks for the review,
- Naveen

=
