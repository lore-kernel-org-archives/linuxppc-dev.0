Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 252DFDDFD1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 08:17:04 +1000 (EST)
Message-Id: <75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Date: Wed, 6 Aug 2008 17:11:36 -0500
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2008, at 4:54 PM, Grant Likely wrote:

> On Wed, Aug 6, 2008 at 8:07 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>>
>> On Aug 6, 2008, at 1:02 AM, Grant Likely wrote:
>>
>>> From: Grant Likely <grant.likely@secretlab.ca>
>>>
>>> ioremap_bat() is useful for things like mapping SoC internally  
>>> memory
>>> mapped
>>> register and early text because it allows mappings to devices to  
>>> be setup
>>> early in the boot process where they are needed, and the mappings  
>>> persist
>>> after the MMU is configured.
>>>
>>> Without ioremap_bat(), setting up the MMU would cause the early text
>>> mappings to get lost and mostly likely result in a kernel panic on  
>>> the
>>> next
>>> attempt at output.
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>> ---
>>
>> why can't we just do this in ioremap itself?
>
> I suppose we could; but the usecase is somewhat different and I wanted
> to keep it simple.  Using a separate API also helps reenforce that the
> caller really needs to know what they are doing because BATs are a
> limited resource.

there is a bunch of error checking and difference in semantics that  
you need to fix.  I think introduce a new API for this is silly,  
especially since we expect there to only be one actual invocation of  
the API for serial console access.

- k
