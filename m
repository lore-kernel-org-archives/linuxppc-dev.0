Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEE2C433E8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 16:52:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FFF20771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 16:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FFF20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCJKW5dmXzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 02:52:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCJCH1TJ3zDrQR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 02:47:03 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BCJC36yTGzB09bR;
 Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Jaygyj04Nb8u; Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BCJC33NBqzB09bN;
 Thu, 23 Jul 2020 18:46:55 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 3746D72B; Thu, 23 Jul 2020 18:48:14 +0200 (CEST)
Received: from 37-172-34-2.coucou-networks.fr
 (37-172-34-2.coucou-networks.fr [37.172.34.2]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Thu, 23 Jul 2020 18:48:14 +0200
Date: Thu, 23 Jul 2020 18:48:14 +0200
Message-ID: <20200723184814.Horde.pk5BO9iFqyGX5D4TW5wqmg1@messagerie.si.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/64s: system call support for scv/rfscv
 instructions
References: <20200611081203.995112-1-npiggin@gmail.com>
 <20200611081203.995112-3-npiggin@gmail.com>
 <871rl2ralk.fsf@mpe.ellerman.id.au>
In-Reply-To: <871rl2ralk.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-api@vger.kernel.org, musl@lists.openwall.com,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> Nicholas Piggin <npiggin@gmail.com> writes:
>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h=20=20
>>=20b/arch/powerpc/include/asm/ppc-opcode.h
>> index 2a39c716c343..b2bdc4de1292 100644
>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -257,6 +257,7 @@
>>  #define PPC_INST_MFVSRD			0x7c000066
>>  #define PPC_INST_MTVSRD			0x7c000166
>>  #define PPC_INST_SC			0x44000002
>> +#define PPC_INST_SCV			0x44000001
> ...
>> @@ -411,6 +412,7 @@
> ...
>> +#define __PPC_LEV(l)	(((l) & 0x7f) << 5)
>
> These conflicted and didn't seem to be used so I dropped them.
>
>> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
>> index 5abe98216dc2..161bfccbc309 100644
>> --- a/arch/powerpc/lib/sstep.c
>> +++ b/arch/powerpc/lib/sstep.c
>> @@ -3378,6 +3382,16 @@ int emulate_step(struct pt_regs *regs,=20=20
>>=20struct ppc_inst instr)
>>  		regs->msr =3D MSR_KERNEL;
>>  		return 1;
>>
>> +	case SYSCALL_VECTORED_0:	/* scv 0 */
>> +		regs->gpr[9] =3D regs->gpr[13];
>> +		regs->gpr[10] =3D MSR_KERNEL;
>> +		regs->gpr[11] =3D regs->nip + 4;
>> +		regs->gpr[12] =3D regs->msr & MSR_MASK;
>> +		regs->gpr[13] =3D (unsigned long) get_paca();
>> +		regs->nip =3D (unsigned long) &system_call_vectored_emulate;
>> +		regs->msr =3D MSR_KERNEL;
>> +		return 1;
>> +
>
> This broke the ppc64e build:
>
>   ld: arch/powerpc/lib/sstep.o:(.toc+0x0): undefined reference to=20=20
>=20`system_call_vectored_emulate'
>   make[1]: *** [/home/michael/linux/Makefile:1139: vmlinux] Error 1
>
> I wrapped it in #ifdef CONFIG_PPC64_BOOK3S.

You mean CONFIG_PPC_BOOK3S_64 ?

Christophe
>
> cheers


