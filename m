Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6591DE65C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 08:32:03 +1000 (EST)
Message-ID: <489A264D.4030607@freescale.com>
Date: Wed, 06 Aug 2008 17:31:41 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>	<CD66FAA8-BC99-4630-9FFF-E2C651E5DE9A@kernel.crashing.org>	<fa686aa40808061454t14737278h3fd15fb0ccdbf251@mail.gmail.com>
	<75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
In-Reply-To: <75A0A752-FF2C-41B6-A6D3-E510E8FD4E91@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Aug 6, 2008, at 4:54 PM, Grant Likely wrote:
>> I suppose we could; but the usecase is somewhat different and I
>> wanted to keep it simple.  Using a separate API also helps
>> reenforce that the caller really needs to know what they are doing
>> because BATs are a limited resource.
> 
> there is a bunch of error checking and difference in semantics that
> you need to fix.  I think introduce a new API for this is silly,

Why is it silly?  It seems silly to me to complicate ioremap() with 
knowing when to use BATs and when not to use them.

> especially since we expect there to only be one actual invocation of
> the API for serial console access.

I could also see a BAT (or equivalent) being used for IMMR-space, or
other frequently accessed registers, to save TLB entries.

-Scott
