Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id A18E6DDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 07:26:57 +1000 (EST)
Date: Mon, 2 Jun 2008 16:26:32 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add next-level-cache property
Message-ID: <20080602212632.GA7475@localdomain>
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<1212180199-968-2-git-send-email-galak@kernel.crashing.org>
	<165963514fdb3980898f3babaad546a9@kernel.crashing.org>
	<8945FFBA-5552-4CF4-B185-8FDD7885B744@kernel.crashing.org>
	<fe9c3824f2fd9c5013ae3eb037a017e9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fe9c3824f2fd9c5013ae3eb037a017e9@kernel.crashing.org>
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

Segher Boessenkool wrote:
>>>
>>> The PowerPC binding defines an "l2-cache" property for this (it
>>> points from CPU node to L2 cache node, from L2 cache node to L3
>>> cache node, from L3 cache node to L4 cache node, etc.)
>>
>> So looking at the PPC binding its not terrible clear about "l3-cache"  
>> being a valid property.
>
> It isn't.  The property is called "l2-cache" at every level.
>
>> I believe the discussion w/ePAPR was to create something a bit more  
>> generic and clarify/update the PPC binding.
>
> Nasty.  Sure, "l2-cache" isn't the nicest name to point to deeper
> cache levels, but introducing a new property with (substantially)
> the same semantics is worse.

The semantics appear to be identical, even.


> There really shouldn't be a new property name until new functionality
> is introduced.  For example, it could allow to describe more than one
> cache at each level (the current binding already allows more than one
> parent for each cache, but only one child; and cache hierarchies like
> that actually exist).
>
>> I'm going to stick with the new binding as we don't use this linking  
>> currently.
>
> Dunno what's the best thing to do here.  If you don't need the
> functionality yet, it might be best to postpone putting either
> property in there.  Sigh, what a mess.

Does existing practice count for anything?  IBM pseries firmware uses
the l2-cache property as described in the PowerPC binding.
