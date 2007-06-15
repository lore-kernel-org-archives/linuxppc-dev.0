Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 50002DDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 18:56:20 +1000 (EST)
Message-ID: <46725411.3080002@ru.mvista.com>
Date: Fri, 15 Jun 2007 12:55:45 +0400
From: "Vladislav D. Buzov" <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<20070614222620.GA17382@mag.az.mvista.com>
	<c6cd3a9fe7713f081354cca9b4306811@kernel.crashing.org>
In-Reply-To: <c6cd3a9fe7713f081354cca9b4306811@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Segher Boessenkool wrote:
>>>>>      /* TODO: use HW flush assist when available */
>>>>
>>>> You want to get rid of this old comment though -- and
>>>> perhaps branch over the non-hardware-assisted cache
>>>> flushing code.
>>>
>>> Ok, I agree that the comment is obsolete now. Would you please explain
>>> why the branch over non-hardware-assisted code should be removed as
>>> well. Technically the cache is flushed and there is no need to use 
>>> extra
>>> commands to fill and then re-flush the cache.
>>
>> I think Segher is saying that you can skip the manual invalidation too
>> (although he said "flushing", I think he really meant "invalidation"--
>> the manual flushing is already skipped).
>
> Erm yes.
>
>> If I'm reading the manual
>> correctly, L2HWF does the invalidation as well so both the manual
>> flushing and invalidation can be skipped.
>
> Yeah.  Not that it really matters of course.
Hrm. I don't think that cache invalidation should be skipped. It is done 
after _set_L2CR() explicitly disabled the cache, in part of cache 
enabling procedure. Note that cache is flushed only if _set_L2CR() is 
called for already enabled cache. So, to skip cache invalidation there 
is a need to somehow track whether the cache has been 
flushed/invalidated before disabling or not. Since the manual 
invalidation does not break anything I think it is better to leave it as 
is rather than overload a _set_L2CR() logic.

Vlad.
>
>
> Segher
>
