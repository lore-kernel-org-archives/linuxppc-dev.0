Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5212DDF3A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 11:52:23 +1000 (EST)
Message-Id: <969C9C6E-42DC-4CA1-84AA-5F47799BD291@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808061602v53c2104cm1b666a4a6b180433@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Date: Wed, 6 Aug 2008 20:52:10 -0500
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<fa686aa40808061602v53c2104cm1b666a4a6b180433@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> why can't we just do this in ioremap itself?
>>>
>>> I suppose we could; but the usecase is somewhat different and I  
>>> wanted
>>> to keep it simple.  Using a separate API also helps reenforce that  
>>> the
>>> caller really needs to know what they are doing because BATs are a
>>> limited resource.
>>
>> there is a bunch of error checking and difference in semantics that  
>> you need
>> to fix.
>
> details please?  I agree that it can be tightened up in some areas,
> but I'd like to know if you've seen something I haven't.

The alignment checks for one?  Why does the caller need to ensure  
alignment.. we just force alignment in __ioremap().. we should be  
doing the same thing here.

>> I think introduce a new API for this is silly,
>
> I don't think so.  I actually prefer it being an different API.  It
> forces the caller to understand what the function does.  It forces the
> programmer to think and to understand the effect of mapping large io
> blocks.

Ok.. My feeling is the same core logic should be used so I don't have  
to fix 2 places in the future.

>> especially since we
>> expect there to only be one actual invocation of the API for serial  
>> console
>> access.
>
> Actually, this is not only for early serial.  Early serial just
> happens to be the first user.

Than this really should be done as part of __ioremap() since you have  
to deal with doing different things depending on how mem_init_done is  
set.

- k
