Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQtGQ07HRzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 19:56:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
In-Reply-To: <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org> <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
Date: Mon, 07 Aug 2017 19:56:28 +1000
Message-ID: <877eyfpupf.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri, 04 Aug 2017 21:54:57 +0200
> Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> No, this is really a 4.13-rc1 regression.
>> 
>> Andreas.
>> 
>
> SLB miss with MSR[RI]=0 on
>
> lbz     r0,THREAD+THREAD_LOAD_FP(r7)
>
> Caused by bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f

Ah of course. Not sure why I haven't seen it in any of my testing :/

> Hmm, I'll see if something can be done, but that MSR_RI stuff in syscall
> exit makes things fairly difficult (and will reduce performance improvement
> of this patch anyway).
>
> I'm trying to work to a point where we have a soft-RI bit for these kinds of
> uses that would avoid all this complexity. Until then it may be best to
> just revert this patch.

OK. Let me know in the next day or two what you want to do.

One option would be to load THREAD_LOAD_FP/THREAD_LOAD_VEC before we
turn off RI.

It would be ugly, but if we think we can clean it up in the medium term
with soft-RI then maybe that would be OK.

cheers
