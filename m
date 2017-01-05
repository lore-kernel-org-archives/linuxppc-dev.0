Return-Path: <tuliom@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvQ8r6w0KzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 22:15:56 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05BDtcV079297
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 06:15:54 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sfvhq4w3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 06:15:53 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 09:15:52 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 245DA3520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 06:15:19 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05BFnkx4345964
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 09:15:49 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05BFmkM017281
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 09:15:48 -0200
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>, wschmidt@us.ibm.com
Cc: 
Subject: Re: [PATCH 9/9] powerpc: A new cache shape aux vectors
In-Reply-To: <1483567434.15843.28.camel@kernel.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
 <20170104051535.9454-9-benh@kernel.crashing.org>
 <87lgurkmd4.fsf@linux.vnet.ibm.com>
 <1483567434.15843.28.camel@kernel.crashing.org>
Date: Thu, 05 Jan 2017 09:15:47 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87inptlpuk.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-01-04 at 11:04 -0200, Tulio Magno Quites Machado Filho
>
>> > +#define AT_L1I_CACHESIZE	40
>> > +#define AT_L1I_CACHESHAPE	41
>> > +#define AT_L1D_CACHESIZE	42
>> > +#define AT_L1D_CACHESHAPE	43
>> > +#define AT_L2_CACHESIZE		44
>> > +#define AT_L2_CACHESHAPE	45
>> > +#define AT_L3_CACHESIZE		46
>> > +#define AT_L3_CACHESHAPE	47
>>=20
>> These names will clash with the other ones defined by alpha and sh:
>>=20
>> /* Shapes of the caches.=C2=A0=C2=A0Bits 0-3 contains associativity; bit=
s 4-7
>> contains
>> =C2=A0=C2=A0=C2=A0log2 of line size; mask those to get cache size.=C2=A0=
=C2=A0*/
>> #define AT_L1I_CACHESHAPE	34
>> #define AT_L1D_CACHESHAPE	35
>> #define AT_L2_CACHESHAPE	36
>> #define AT_L3_CACHESHAPE	37
>
> Is this a problem though ? In the kernel at least these are defined in
> arch specific headers so there is no clash.

It could become a problem if an architecture tries to use both of these
types.

glibc doesn't distinct between them:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Delf/elf.h#l1113

> Otherwise, I can change them to *_CACHEGEOMETRY, is that ok ?

Looks good to me.

--=20
Tulio Magno
