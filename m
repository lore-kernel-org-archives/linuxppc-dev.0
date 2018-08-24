Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xVbZ6h9pzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 15:44:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Russell Currey <ruscur@russell.cc>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
In-Reply-To: <20180823144118.GU24439@gate.crashing.org>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
 <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
 <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr>
 <20180823103625.GR24439@gate.crashing.org>
 <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr>
 <87a7pdl2jy.fsf@concordia.ellerman.id.au>
 <d561e11b-b85e-6f6c-0936-4a93cf309915@au1.ibm.com>
 <20180823144118.GU24439@gate.crashing.org>
Date: Fri, 24 Aug 2018 15:44:42 +1000
Message-ID: <87r2iojp2t.fsf@concordia.ellerman.id.au>
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

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Thu, Aug 23, 2018 at 11:32:16PM +1000, Andrew Donnellan wrote:
>> On 23/08/18 21:56, Michael Ellerman wrote:
>> >Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> >
>> >>Le 23/08/2018 =C3=A0 12:36, Segher Boessenkool a =C3=A9crit=C2=A0:
>> >>>On Thu, Aug 23, 2018 at 11:40:22AM +0200, Christophe LEROY wrote:
>> >>>>The only small probl=C3=A8me I have is that some version of GCC seem=
s to
>> >>>>complain about big memset() (132k and 256k ones). Is there a way to =
tell
>> >>>>GCC we really want to do it ?
>> >>>
>> >>>I'm not sure what you mean.  Complain, is that a warning, is that an=
=20
>> >>>error?
>> >>>What does it say?  Do you have some example code to reproduce it?  Et=
c.
>> >>
>> >>I saw the warnings in the checks at
>> >>https://patchwork.ozlabs.org/patch/957566/
>> >>Unfortunatly the link is now broken.
>> >
>> >ruscur/ajd any idea what happened to the snowpatch links here?
>>=20
>> I think they've disappeared because our log rotation is too fast - I've=
=20
>> now upped it to 30 days. I guess over time we'll figure out what we need=
=20
>> in this regard, ideally we'd keep logs indefinitely but they're several=
=20
>> megs per build.
>>=20
>> I've kicked off another build for this series and the links in Patchwork=
=20
>> should update to point to the new job when it's done (probably in the=20
>> next couple of hours).
>
> It's back, thanks Andrew!
>
> The warnings are not from GCC at all: the warnings are from sparse.

We really need to split them out so it's less confusing.

cheers
