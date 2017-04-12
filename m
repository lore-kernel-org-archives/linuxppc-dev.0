Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w36fq4CmbzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 01:05:23 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CExjT7144392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:05:14 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sm4x105h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:05:14 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 20:35:11 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3CF586N5046476
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:35:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3CF56Yq018957
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 20:35:07 +0530
Date: Wed, 12 Apr 2017 15:05:03 +0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@au1.ibm.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
 <20170328102109.GC4762@naverao1-tp.localdomain>
 <87a884jow3.fsf@concordia.ellerman.id.au>
 <20170330071613.GE4762@naverao1-tp.localdomain>
 <CANc+2y4v=3y=Wv+SUet4RvGDJ7JvoAfePyBEyajG4VvGh4ABzA@mail.gmail.com>
In-Reply-To: <CANc+2y4v=3y=Wv+SUet4RvGDJ7JvoAfePyBEyajG4VvGh4ABzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1492008223.s7vdo7w6wt.astroid@naverao1-tp.none>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from PrasannaKumar Muralidharan's message of April 5, 2017 11:21:
> On 30 March 2017 at 12:46, Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> Also, with a simple module to memset64() a 1GB vmalloc'ed buffer, here
>> are the results:
>> generic:        0.245315533 seconds time elapsed        ( +-  1.83% )
>> optimized:      0.169282701 seconds time elapsed        ( +-  1.96% )
>=20
> Wondering what makes gcc not to produce efficient assembly code. Can
> you please post the disassembly of C implementation of memset64? Just
> for info purpose.

It's largely the same as what Christophe posted for powerpc32.

Others will have better insights, but afaics, gcc only seems to be=20
unrolling the loop with -funroll-loops (which we don't use).

As an aside, it looks like gcc recently picked up an optimization in v7=20
that can also help (from https://gcc.gnu.org/gcc-7/changes.html):
"A new store merging pass has been added. It merges constant stores to=20
adjacent memory locations into fewer, wider, stores. It is enabled by=20
the -fstore-merging option and at the -O2 optimization level or higher=20
(and -Os)."


- Naveen

=
