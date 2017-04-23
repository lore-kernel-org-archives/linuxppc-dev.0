Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9v250LbZzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 01:45:32 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3NFin6L096136
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 11:45:30 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a03b2meuy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 11:45:30 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 01:45:27 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3NFjHKR20906058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 01:45:25 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3NFimNA032596
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 01:44:48 +1000
Date: Sun, 23 Apr 2017 15:44:32 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419233750.8552f5de8ce1ed1398807284@kernel.org>
 <1492619420.q0fv2gslsy.astroid@naverao1-tp.none>
 <20170421224236.d1c53002f0b3c4750fd6f664@kernel.org>
In-Reply-To: <20170421224236.d1c53002f0b3c4750fd6f664@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492962128.c0nhtlqdo4.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Masami Hiramatsu's message of April 21, 2017 19:12:
> On Wed, 19 Apr 2017 16:38:22 +0000
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Excerpts from Masami Hiramatsu's message of April 19, 2017 20:07:
>> > On Wed, 19 Apr 2017 18:21:02 +0530
>> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> >=20
>> >> When a kprobe is being registered, we use the symbol_name field to
>> >> lookup the address where the probe should be placed. Since this is a
>> >> user-provided field, let's ensure that the length of the string is
>> >> within expected limits.
>> >=20
>> > Would we really need this? Of course it may filter out longer
>> > strings... anyway such name should be rejected by kallsyms.
>>=20
>> I felt this would be good to have generically, as kallsyms does many=20
>> string operations on the symbol name, including an unbounded=20
>> strchr().
>=20
> OK, so this is actually for performance reason.
>=20
>>=20
>> >=20
>> > [...]
>> >> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>> >> index 6a128f3a7ed1..bb86681c8a10 100644
>> >> --- a/kernel/kprobes.c
>> >> +++ b/kernel/kprobes.c
>> >> @@ -1382,6 +1382,28 @@ bool within_kprobe_blacklist(unsigned long add=
r)
>> >>  	return false;
>> >>  }
>> >> =20
>> >> +bool is_valid_kprobe_symbol_name(const char *name)
>> >=20
>> > This just check the length of symbol_name buffer, and can contain
>> > some invalid chars.
>>=20
>> Yes, I kept the function name generic incase we would like to do more=20
>> validation in future, plus it's shorter than=20
>> is_valid_kprobe_symbol_name_len() ;-)
>=20
> OK, if this is enough general, we'd better define this in
> kernel/kallsyms.c or in kallsyms.h. Of course the function
> should be called is_valid_symbol_name(). :-)

I actually think this should be done in kprobes itself. The primary=20
intent is to perform such validation right when we first obtain the=20
input from the user. In this case, however, kallsyms_lookup_name() is=20
also an exported symbol, so I do think some validation there would be=20
good to have as well.

>=20
>> >> +{
>> >> +	size_t sym_len;
>> >> +	char *s;
>> >> +
>> >> +	s =3D strchr(name, ':');
>>=20
>> Hmm.. this should be strnchr(). I re-factored the code that moved the=20
>> strnlen() above this below. I'll fix this.
>>=20
>> >> +	if (s) {
>> >> +		sym_len =3D strnlen(s+1, KSYM_NAME_LEN);
>> >=20
>> > If you use strnlen() here, you just need to ensure sym_len < KSYM_NAME=
_LEN.
>>=20
>> Hmm.. not sure I follow. Are you saying the check for sym_len <=3D 0 is=20
>> not needed?
>=20
> You can check sym_len !=3D 0, but anyway, here we concern about
> "longer" string (for performance reason), we can focus on
> such case.
> (BTW, could you also check the name !=3D NULL at first?)
>=20
> So, what I think it can be;
>=20
> if (strnlen(s+1, KSYM_NAME_LEN) =3D=3D KSYM_NAME_LEN ||
>     (size_t)(s - name) >=3D MODULE_NAME_LEN)
> 	return false;

Sure, thanks. I clearly need to refactor this code better!

- Naveen

=
