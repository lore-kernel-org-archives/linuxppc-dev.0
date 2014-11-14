Return-Path: <vvijayan@mvista.com>
Received: from mail-ie0-f173.google.com (mail-ie0-f173.google.com
 [209.85.223.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52EF81A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 16:33:52 +1100 (AEDT)
Received: by mail-ie0-f173.google.com with SMTP id y20so415361ier.18
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 21:33:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOpNGcsgX0wVOgMN77+RuKVsb_iHQ7XQk8U_05-up__wC6zuZQ@mail.gmail.com>
References: <1412919926-13123-1-git-send-email-vvijayan@mvista.com>
 <20141015020811.7904E14011B@ozlabs.org>
 <CAOpNGcsgX0wVOgMN77+RuKVsb_iHQ7XQk8U_05-up__wC6zuZQ@mail.gmail.com>
From: Vineeth Vijayan <vvijayan@mvista.com>
Date: Fri, 14 Nov 2014 11:03:30 +0530
Message-ID: <CAOpNGcsQX1d4=MpHKKKnBotBb11dq55_kQp4PG8OA++U6peqKg@mail.gmail.com>
Subject: Re: powerpc: Fix Text randomization
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping !

any update on this ? As i understand, only powerpc and s390 uses the
randomize_et_dyn call; for all other architecture this is an obsolete
function call.

this call for another patch where randomize_et_dyn is removed.

On Wed, Oct 15, 2014 at 12:08 PM, Vineeth Vijayan <vvijayan@mvista.com> wro=
te:
> On Wed, Oct 15, 2014 at 7:38 AM, Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>> On Fri, 2014-10-10 at 05:45:26 UTC, Vineeth Vijayan wrote:
>>> Right now there is no way to disable TEXT randomization on a PPC32
>>> machine. text randomization happens even in the case of "echo 0 >
>>> /proc/sys/kernel/randomize_va_space"
>>
>> Yeah it seems to happen on ppc64 too.
>>
>>> This happens due to the incorrect definition of ELF_ET_DYN_BASE at
>>> arch/powerpc/include/asm/elf.h
>>
>> What is incorrect about it? We are not the only arch that does that.
>>
>
> I think we are one of the arch which does it.
> The same has been tested on x86 and arm, where ELF_ET_DYN_BASE doesn=E2=
=80=99t
> use randomize_et_dyn call, and it works properly as per the user-space
> definition of randomization;
>
> (i.e when at "echo 0 > /proc/sys/kernel/randomize_va_space", TEXT
> randomization should not happen.)
>
>> I'm not clear on what has changed to break this?
>>
>> cheers
