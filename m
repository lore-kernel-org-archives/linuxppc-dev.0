Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFD43DDEBC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:45:43 +1000 (EST)
In-Reply-To: <20070911135717.GD1932@ld0162-tx32.am.freescale.net>
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
	<20070911135717.GD1932@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] fsl_soc.c cleanup
Date: Tue, 11 Sep 2007 10:48:26 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 8:57 AM, Scott Wood wrote:

> On Tue, Sep 11, 2007 at 12:35:56AM -0500, Kumar Gala wrote:
>>
>> On Aug 28, 2007, at 3:16 PM, Scott Wood wrote:
>>
>>> 1. Fix get_immrbase() to use ranges, rather than reg.
>>>
>>> It is not always the case that the SoC's first reg property points
>>> to the beginning of the entire SoC block.
>>
>> when is this true?
>
> The intent was to eliminate the need for the reg property in /soc.
>
>> Upon further testing this breaks some platforms.  I don't think
>> assuming the first range entry is mapping to the SOC register space
>> is a good idea.
>
> Let me guess, 8544ds and 8548cds?  Because of the same recent ranges
> changes that we were arguing about in another thread? :-P

Yep.  However, after some discussion with Segher on this for 83xx/ 
85xx/86xx I think we want to keep the reg prop and have it cover the  
initial soc registers [size on 83xx is 0x100, size on 85xx/86xx would  
be 0x1000].

What we need is a saner way to determine immr on 82xx & 8xx.   
Segher's rule is that a given "reg" prop shouldn't overlap w/any  
other reg.  We currently violate that on 8xx.  Not as clear on 82xx  
if we do that.

I'm thinking on 8xx we should move to grabbing a top level compat  
value (mpc8xx) and use the SPRN_IMMR to set immrbase. On mpc82xx-pq2  
we could add a immr "device" to search for.

- k
