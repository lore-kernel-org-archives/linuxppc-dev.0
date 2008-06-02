Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D15DDDDE9
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 07:06:45 +1000 (EST)
In-Reply-To: <8945FFBA-5552-4CF4-B185-8FDD7885B744@kernel.crashing.org>
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<1212180199-968-2-git-send-email-galak@kernel.crashing.org>
	<165963514fdb3980898f3babaad546a9@kernel.crashing.org>
	<8945FFBA-5552-4CF4-B185-8FDD7885B744@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fe9c3824f2fd9c5013ae3eb037a017e9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add next-level-cache property
Date: Mon, 2 Jun 2008 23:06:27 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Added next-level-cache to the L1 and a reference to the new L2 label.
>>
>> Where is this property defined?  I can't find it.
>>
>> The PowerPC binding defines an "l2-cache" property for this (it
>> points from CPU node to L2 cache node, from L2 cache node to L3
>> cache node, from L3 cache node to L4 cache node, etc.)
>
> So looking at the PPC binding its not terrible clear about "l3-cache" 
> being a valid property.

It isn't.  The property is called "l2-cache" at every level.

> I believe the discussion w/ePAPR was to create something a bit more 
> generic and clarify/update the PPC binding.

Nasty.  Sure, "l2-cache" isn't the nicest name to point to deeper
cache levels, but introducing a new property with (substantially)
the same semantics is worse.

There really shouldn't be a new property name until new functionality
is introduced.  For example, it could allow to describe more than one
cache at each level (the current binding already allows more than one
parent for each cache, but only one child; and cache hierarchies like
that actually exist).

> I'm going to stick with the new binding as we don't use this linking 
> currently.

Dunno what's the best thing to do here.  If you don't need the
functionality yet, it might be best to postpone putting either
property in there.  Sigh, what a mess.


Segher
