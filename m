Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGN572Xc9zDqm2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 23:48:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH 02/24] powerpc/mm: Pre-filter SRR1 bits before
 do_page_fault()
In-Reply-To: <20170722184314.Horde.gxxJYSiYc2SSqQhjpzVdwQ1@messagerie.c-s.fr>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-2-benh@kernel.crashing.org>
 <20170722184314.Horde.gxxJYSiYc2SSqQhjpzVdwQ1@messagerie.c-s.fr>
Date: Mon, 24 Jul 2017 23:48:58 +1000
Message-ID: <87eft6j67p.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index faddc87d0205..f04bc9f6b134 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -203,23 +203,13 @@ static int __do_page_fault(struct pt_regs=20=20
>> *regs, unsigned long address,
>>  	unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>>  	int code =3D SEGV_MAPERR;
>>  	int is_write =3D 0;
>> -	int trap =3D TRAP(regs);
>> - 	int is_exec =3D trap =3D=3D 0x400;
>> + 	int is_exec =3D TRAP(regs) =3D=3D 0x400;
>
> Don't we have a tab/space issue here ?

We do:

  Warnings for commit 0f9b89d759ba 'powerpc/mm: Pre-filter SRR1 bits before=
 do_page_fault()'
    Lines beginning with space in arch/powerpc/mm/fault.c
      + 	int is_exec =3D TRAP(regs) =3D=3D 0x400;

I can fix it up.

cheers
