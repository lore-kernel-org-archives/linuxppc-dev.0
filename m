Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLwVl47GKzF0cP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 16:23:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H5NsqU064806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 00:23:56 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fhs4g76pu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 00:23:56 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Jan 2018 05:23:48 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/32: Fix hugepage allocation on 8xx at hint
 address
In-Reply-To: <7341aef1-f2ac-6e9b-8279-93b0f0649b81@c-s.fr>
References: <9a5dadc10f88e2fc0ac9fb5d18c5424df33f3f4c.1515169256.git.christophe.leroy@c-s.fr>
 <876081by7g.fsf@linux.vnet.ibm.com>
 <b5e34a5b-94b8-9405-929d-d35dde3fcb3b@c-s.fr>
 <945affcd-b25c-bc6e-68e5-8bbbcd31c0fd@linux.vnet.ibm.com>
 <7341aef1-f2ac-6e9b-8279-93b0f0649b81@c-s.fr>
Date: Wed, 17 Jan 2018 10:53:41 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87y3kxrrc2.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

>>
>>> How should I split in separate patches ? Something like ?
>>> 1/ Slice support for PPC32 > 2/ Activate slice for 8xx
>>=20
>> Yes something like that. Will you=C2=A0 be able to avoid that
>>  =C2=A0if (SLICE_NUM_HIGH) from the code? That makes the code ugly. Righ=
t now=20
>> i don't have definite suggestion on what we could do though.
>>=20
>
> Could use #ifdefs instead, but in my mind it would be even more ugly.
>
> I would have liked just doing nothing, but the issue is that at the=20
> moment bitmap_xxx() functions are not prepared to handle bitmaps of size=
=20
> zero. Should we try to change that ? Any chance to succeed ?
>

How much code duplication it is to do slice_32.c?

Michael,

What do you suggest here?

-aneesh
