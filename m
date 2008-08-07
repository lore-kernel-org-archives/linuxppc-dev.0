Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADE0FDDF53
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 11:51:41 +1000 (EST)
Message-Id: <63451E1F-30C1-4146-9D1A-BD4973E8F17A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1218061709.24157.249.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Date: Wed, 6 Aug 2008 20:49:22 -0500
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>
	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
	<1218061709.24157.249.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2008, at 5:28 PM, Benjamin Herrenschmidt wrote:

>
>> there is a bunch of error checking and difference in semantics that
>> you need to fix.  I think introduce a new API for this is silly,
>> especially since we expect there to only be one actual invocation of
>> the API for serial console access.
>
> Not necessarily....
>
> There's another aspect to BAT mappings here. First, they should be
> permanent (ie, not unmappable). That way, we have ioremap just use
> an existing BAT mapping when asked for a device that is covered
> by a BAT. This allows to have platform code do something like setup
> a BAT over a bunch of SOC registers or over a device, to automagically
> get drivers doing ioremap to that area benefit from it.

why should they be permanent.. We could implement reference counting  
around the regions and free BATs if the count = 0.

I'm more concerned about this being implemented around the existing  
ioremap core in __ioremap().  We can easily use a flag bit to say use  
"large mappings" or the fact that mem_init_done == 0.

- k
