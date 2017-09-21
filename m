Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyYZd684mzDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:01:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: cody@codyps.com
Cc: David Binderman <dcb314@hotmail.com>,
 "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
 "paulus\@samba.org" <paulus@samba.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-4.14-rc1/arch/powerpc/perf/hv-24x7.c:541: bad condition ?
In-Reply-To: <87poankm95.fsf@concordia.ellerman.id.au>
References: <HE1PR0802MB2331572C98E215722EE4411C9C630@HE1PR0802MB2331.eurprd08.prod.outlook.com>
 <87poankm95.fsf@concordia.ellerman.id.au>
Date: Thu, 21 Sep 2017 21:01:28 +1000
Message-ID: <87y3p8b9iv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ + Cody in case he's still interested]

Michael Ellerman <mpe@ellerman.id.au> writes:
> David Binderman <dcb314@hotmail.com> writes:
>
>> Hello there,
>>
>> linux-4.14-rc1/arch/powerpc/perf/hv-24x7.c:543]: (warning) Identical condition 's1<s2', second condition is always false
>>
>> Source code is
>>
>>     if (s1 < s2)
>>         return 1;
>>     if (s2 > s1)
>>         return -1;
>>
>> Suggest code rework.
>
> Um thanks.
>
> It's trying to implement a sort comparison returning -1, 0, 1.
>
> So it's pretty obviously wrong, but also harmless AFAICS, because it's
> just an optimisation before doing a full comparison using memcmp().
>
> So yeah we should fix it, but not an actual bug AFAICS.
>
> cheers
