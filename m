Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gb0q50wyzF10S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 00:14:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 9/9] powerpc/traps: Add line prefix in
 show_instructions()
In-Reply-To: <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-10-muriloo@linux.ibm.com>
 <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
Date: Thu, 02 Aug 2018 00:14:49 +1000
Message-ID: <87ftzyfa1y.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 31/07/2018 =C3=A0 16:50, Murilo Opsfelder Araujo a =C3=A9crit=C2=A0:
>> Remove "Instruction dump:" line by adding a prefix to display current->c=
omm
>> and current->pid, along with the instructions dump.
>>=20
>> The prefix can serve as a glue that links the instructions dump to its
>> originator, allowing messages to be interleaved in the logs.
>>=20
>> Before this patch, a page fault looked like:
>>=20
>>    pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd29=
5100 code 2 in pandafault[10000000+10000]
>>    Instruction dump:
>>    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22ff=
fe
>>    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f=
0040
>>=20
>> After this patch, it looks like:
>>=20
>>    pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e=
5100 code 2 in pandafault[10000000+10000]
>>    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8=
 f821ffc1 7c3f0b78 3d22fffe
>>    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <9949000=
0> 39200000 7d234b78 383f0040
>>=20
>> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>
> Does the script scripts/decode_stacktrace.sh also works with this format=
=20
> change ?

Did it work before? I've never used it.

Would be great if it did work though.

cheers
