Return-Path: <schmitzmic@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413wp11lK4zF3Bk
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 11:45:44 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so11377554plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 18:45:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <22a505e0f094352b9cb883935fae9f494fb2cb0b.camel@kernel.crashing.org>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
 <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
 <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com>
 <22a505e0f094352b9cb883935fae9f494fb2cb0b.camel@kernel.crashing.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Mon, 11 Jun 2018 13:45:40 +1200
Message-ID: <CAOmrzkLGWgY44puwim7bJPpkpE5cmyMEf3S+fHHMJYU6FC-tCw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Finn Thain <fthain@telegraphics.com.au>,
 Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

I'm glad Finn is caring enough to keep this 20 year old bike shed in
good repair, but this may be overdoing it a little indeed. My bad.

A comment on the V1 PMU entry everyone should be OK with, I hope.

Cheers,

  Michael



On Mon, Jun 11, 2018 at 12:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2018-06-10 at 21:12 +1200, Michael Schmitz wrote:
>> Hi Geert,
>
> Top posting, sorry ...
>
> We are painting that bike shed with way too many coats..
>
> We can keep the existing definitions, stick a comment on them stating
> "obsolete" and use new number if/when needed.
>
> Ben.
>
>
>> Am 10.06.2018 um 20:29 schrieb Geert Uytterhoeven:
>> > Hi Finn,
>> >
>> > On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>> > > > > > Is this enum used by any user space code? If so, perhaps rather
>> > > > > > leave the PMU_68K_V1 in there to avoid upsetting that?
>> > > > >
>> > > > > It also changes the value of PMU_68K_V2, which is an ABI break.
>> > > >
>> > > > Yes, that's what I worry about - but do we know of any users of that
>> > > > particular interface?
>> > >
>> > > There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
>> > > only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
>> > > series will make these UAPIs available on m68k, and for that reason I've
>> > > chosen the value PMU_UNKNOWN for pmu_kind.
>> >
>> > While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
>> > include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
>> > unless we are 100% sure there are no users.
>> >
>> > If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
>> > needing to check the PMU type, it would have a switch() statement with
>> > all existing values defined in <linux/pmu.h>. So that would become broken
>> > by your change.
>> >
>> > Hence the enum is append-only.
>>
>> The PMU type from pmu.h was never exposed to user space on m68k via
>> /proc/pmu/*, and /dev/pmu is used for ioctls to the PMU driver on
>> powerpc only (the 68k PMU driver doesn't have ioctl support). No way
>> that I can see for user space to make use of the PMU type definition
>> from pmu.h, so I suppose we can be sure there are no users.
>>
>> The m68k PMU types cannot be said to be exposed on powerpc either (which
>> has ioctl support to interrogate the PMU type), as these only return
>> values up to PMU_KEYLARGO_BASED.
>>
>> Applications like pbbuttonsd or pmud don't use the kernel PMU type at
>> all, but go straight to the PMU via the ADB bus to interrogate the
>> hardware type, so won't be affected either.
>>
>> Is there any other way besides procfs and ioctl for user space to
>> interrogate the PMU type that I'm missing here?
>>
>> (I understand that breaking the ABI should not be done as a rule, but
>> this may be a case where we can successfully argue the definitions were
>> never in use, so the rules may be bent a little).
