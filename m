Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 190991A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 21:48:19 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: Kconfig.cputype: Disallow TUNE_CELL on LE systems
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1442585820-18623-1-git-send-email-thuth@redhat.com>
 <1442819926.354.5.camel@ellerman.id.au> <55FFD6DF.2080300@redhat.com>
 <1444125937.16578.7.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, boqun.feng@gmail.com
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5613A6ED.10806@redhat.com>
Date: Tue, 6 Oct 2015 12:48:13 +0200
MIME-Version: 1.0
In-Reply-To: <1444125937.16578.7.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/15 12:05, Michael Ellerman wrote:
> On Mon, 2015-09-21 at 12:07 +0200, Thomas Huth wrote:
>> On 21/09/15 09:18, Michael Ellerman wrote:
>>> On Fri, 2015-09-18 at 16:17 +0200, Thomas Huth wrote:
>>>> It looks somewhat weird that you can enable TUNE_CELL on little
>>>> endian systems, so let's disable this option with CPU_LITTLE_ENDIAN.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  I first thought that it might be better to make this option depend
>>>>  on PPC_CELL instead ... but I guess it's a bad idea to depend a
>>>>  CPU option on a platform option? Alternatively, would it make
>>>>  sense to make it depend on (GENERIC_CPU || CELL_CPU) instead?
>>>
>>> Hmm, it's a little backward, but I think it would be fine, and less confusing
>>> for users. Both PS3 and Cell select PPC_CELL, so it would work in both those
>>> cases.
>>
>> It's just that when you step through the kernel config (e.g. with "make
>> menuconfig"), you normally step through the "Processor support" first,
>> and then later do the "Platform support". I think most users won't look
>> back into "Processor support" again once they already reached the
>> "Platform support" section, so this TUNE_CELL option then might appear
>> unnoticed when you enable a Cell platform under "Platform support".
> 
> Ah OK. Personally I almost never use menuconfig, but I guess some folks do.
> 
> That actually seems like we should reorder those sections, ie. put platform
> support first, and then processor support. After all there's not much point
> agonising over whether to tune for CELL cpus if you then don't enable a Cell
> platform.

Not sure whether reordering the sections make much sense - others might
think "I want to support Cell chips with my distro, so let's enable that
first, then let's see which platforms I can select next..." - so I'd
rather not do that.

> I'm not sure if it's that simple in practice ... :)

Maybe we could also simply remove the TUNE_CELL option nowadays? I think
this was used for building generic Linux distros, which are just
optimized for Cell ... but who is still doing that nowadays?

Alternatively, if that is not an option and if you don't like my patch
with CPU_LITTLE_ENDIAN, what about changing it to check "depends on
(GENERIC_CPU || CELL_CPU)" instead?

 Thomas
