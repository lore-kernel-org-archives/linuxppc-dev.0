Return-Path: <mmarek@suse.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C3FB1A1825
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:50:23 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F27FD140D6F
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 16:50:20 +1000 (AEST)
Subject: Re: [RFC PATCH 1/2] scripts/kconfig/Makefile: Allow KBUILD_DEFCONFIG
 to be a target
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1442986835-13985-1-git-send-email-mpe@ellerman.id.au>
 <560275FC.60104@suse.com>
 <FE248B88-D584-4E66-A59F-B2A2C254000C@ellerman.id.au>
 <5605B2AE.1080409@suse.com> <1443680055.16900.0.camel@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, yann.morin.1998@free.fr
From: Michal Marek <mmarek@suse.com>
Message-ID: <560CD7A6.2040905@suse.com>
Date: Thu, 1 Oct 2015 08:50:14 +0200
MIME-Version: 1.0
In-Reply-To: <1443680055.16900.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015-10-01 08:14, Michael Ellerman wrote:
> On Fri, 2015-09-25 at 22:46 +0200, Michal Marek wrote:
>> Dne 24.9.2015 v 00:16 Michael Ellerman napsal(a):
>>>
>>>
>>> On 23 September 2015 19:50:52 GMT+10:00, Michal Marek
>>> <mmarek@suse.com> wrote:
>>>> On 2015-09-23 07:40, Michael Ellerman wrote:
>>>>> +else ifneq ($(wildcard
>>>> arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)),)
>>>>> @$(kecho) "*** Default configuration is based on
>>>> '$(KBUILD_DEFCONFIG)'"
>>>>> $(Q)$< $(silent)
>>>> --defconfig=arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kconfig)
>>>>> +else +	@$(kecho) "*** Default configuration is based on target
>>>> '$(KBUILD_DEFCONFIG)'"
>>>>> +	$(Q)$(MAKE) -f $(srctree)/Makefile $(KBUILD_DEFCONFIG) endif
>>>>
>>>> What is the anticipated usage of this? The patch is not needed to
>>>> make
>>>>
>>>> make ppc64le_defconfig
>>>>
>>>> work with the second patch. If it was, this would create a loop
>>>> anyway.
>>>
>>> The idea is to make 'make defconfig' work when KBUILD_DEFCONFIG is
>>> ppc64le_defconfig (which happens for us when uname returns ppc64le)
>>> and additionally when ppc64le_defconfig is not a real file.
>>
>> Ah, that makes sense. You can add
>>
>> Acked-by: Michal Marek <mmarek@suse.com>
>>
>> if you want.
> 
> Thanks. I'll assume by that you mean you're happy if I take both patches
> through the powerpc tree.

Yes, I assumed that this was your plan.

Michal
