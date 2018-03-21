Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405spc5TgWzDqjS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 01:37:44 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LEXjTu029710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 10:37:42 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gupn7g6k7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 10:37:41 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 14:37:39 -0000
Date: Wed, 21 Mar 2018 20:07:32 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 5/5] powerpc64/ftrace: Implement support for
 ftrace_regs_caller()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, sathnaga@linux.vnet.ibm.com
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <764a63e7418b05185434fe660814ce762c93c7d0.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180321095912.212e0b0d@gandalf.local.home>
In-Reply-To: <20180321095912.212e0b0d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521642624.97rikdhoqw.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Wed, 21 Mar 2018 16:13:22 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>>  int module_finalize_ftrace(struct module *mod, const Elf_Shdr *sechdrs)
>>  {
>>  	mod->arch.toc =3D my_r2(sechdrs, mod);
>> -	mod->arch.tramp =3D create_ftrace_stub(sechdrs, mod);
>> +	mod->arch.tramp =3D create_ftrace_stub(sechdrs, mod,
>> +					(unsigned long)ftrace_caller);
>> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>> +	mod->arch.tramp_regs =3D create_ftrace_stub(sechdrs, mod,
>> +					(unsigned long)ftrace_regs_caller);
>=20
> So you only reference ftrace_regs_caller if you have
> DYNAMIC_FTRACE_WITH_REGS defined?

Yes.

>=20
>> +	if (!mod->arch.tramp_regs)
>> +		return -ENOENT;
>> +#endif
>> =20
>>  	if (!mod->arch.tramp)
>>  		return -ENOENT;
>=20
>=20
>> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/power=
pc/kernel/trace/ftrace_64_mprofile.S
>> index 8f2380304ef1..7b81db85f76e 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
>> @@ -20,8 +20,8 @@
>>  #ifdef CONFIG_DYNAMIC_FTRACE
>>  /*
>>   *
>> - * ftrace_caller() is the function that replaces _mcount() when ftrace =
is
>> - * active.
>> + * ftrace_caller()/ftrace_regs_caller() is the function that replaces _=
mcount()
>> + * when ftrace is active.
>>   *
>>   * We arrive here after a function A calls function B, and we are the t=
race
>>   * function for B. When we enter r1 points to A's stack frame, B has no=
t yet
>> @@ -37,7 +37,7 @@
>>   * Our job is to save the register state into a struct pt_regs (on the =
stack)
>>   * and then arrange for the ftrace function to be called.
>>   */
>=20
> Perhaps you want to add:
>=20
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>=20
> here.

I think that will always be set here. ftrace_64_mprofile.S is only built=20
for -mprofile-kernel and we select HAVE_DYNAMIC_FTRACE_WITH_REGS if=20
MPROFILE_KERNEL is enabled. It looks like there is no way to unset just=20
CONFIG_DYNAMIC_FTRACE_WITH_REGS and so, for -mprofile-kernel, we can=20
assume it is always set?

- Naveen

=
