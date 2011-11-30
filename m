Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 766D8B6F68
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 01:41:20 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so392632vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 06:41:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4ED4126D.7000201@freescale.com>
References: <20111114053749.23410.63745.stgit@suzukikp.in.ibm.com>
 <20111114054144.23410.65704.stgit@suzukikp.in.ibm.com>
 <CA+5PVA6uVpB6XUFkjUABJCcVjubFiWWEQgmuMijTQpdAiN7PdQ@mail.gmail.com>
 <4ED4126D.7000201@freescale.com>
Date: Wed, 30 Nov 2011 09:41:16 -0500
Message-ID: <CA+5PVA7r215N3NZV9gaTiXzeiwBnPBMbssX0Qo3zJ-9eGJaypA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] [booke] Rename mapping based RELOCATABLE to
 DYNAMIC_MEMSTART for BookE
From: Josh Boyer <jwboyer@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 David Laight <David.Laight@aculab.com>, Alan Modra <amodra@au1.ibm.com>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 5:59 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> On 11/23/2011 10:47 AM, Josh Boyer wrote:
>> On Mon, Nov 14, 2011 at 12:41 AM, Suzuki K. Poulose <suzuki@in.ibm.com> =
wrote:
>>> The current implementation of CONFIG_RELOCATABLE in BookE is based
>>> on mapping the page aligned kernel load address to KERNELBASE. This
>>> approach however is not enough for platforms, where the TLB page size
>>> is large (e.g, 256M on 44x). So we are renaming the RELOCATABLE used
>>> currently in BookE to DYNAMIC_MEMSTART to reflect the actual method.
>
> Should reword the config help to make it clear what the alignment
> restriction is, or where to find the information for a particular
> platform. =A0Someone reading "page aligned" without any context that we'r=
e
> talking about special large pages is going to think 4K -- and on e500,
> many large page sizes are supported, so the required alignment is found
> in Linux init code rather than a CPU manual.
>
>>>
>>> The CONFIG_RELOCATABLE for PPC32(BookE) based on processing of the
>>> dynamic relocations will be introduced in the later in the patch series=
.
>>>
>>> This change would allow the use of the old method of RELOCATABLE for
>>> platforms which can afford to enforce the page alignment (platforms wit=
h
>>> smaller TLB size).
>>
>> I'm OK with the general direction, but this touches a lot of non-4xx
>> code. =A0I'd prefer it if Ben took this directly on whatever final
>> solution is done.
>>
>>> I haven tested this change only on 440x. I don't have an FSL BookE to v=
erify
>>> the changes there.
>>>
>>> Scott,
>>> Could you please test this patch on FSL and let me know the results ?
>>
>> Scott, did you ever get around to testing this? =A0In my opinion, this
>> shouldn't go in without a Tested-by: from someone that tried it on an
>> FSL platform.
>
> Booted OK for me on e500v2 with RAM starting at 256M.
>
> Tested-by: Scott Wood <scottwood@freescale.com>
>
>> We add DYNAMIC_MEMSTART for 32-bit, and we have RELOCATABLE for
>> 64-bit. =A0Then throughout almost the rest of the patch, all we're doing
>> is duplicating what RELOCATABLE already did (e.g. if ! either thing).
>> It works, but it is kind of ugly.
>>
>> Instead, could we define a helper config variable that can be used in
>> place of that construct? =A0Something like:
>>
>> config NONSTATIC_KERNEL (or whatever)
>> =A0 =A0 bool
>> =A0 =A0 default n
>>
>> ...
>>
>> config DYNAMIC_MEMSTART
>> =A0 =A0 <blah>
>> =A0 =A0 select NONSTATIC_KERNEL
>>
>> ...
>>
>> config RELOCATABLE
>> =A0 =A0 <blah>
>> =A0 =A0 select NONSTATIC_KERNEL
>
> I agree.

Suzie do you think you could respin this patch with the suggested
changes and include Scott's Tested-by?  The rest of the series looks
fine and I'd like to get it included in my next branch.

josh
