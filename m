Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66B78DDEDA
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 04:22:23 +1000 (EST)
Message-Id: <8690346D-33E3-4430-8542-34D769DE7E9D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080807164513.GA22176@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for setting
	up BAT translated IO regions.
Date: Thu, 7 Aug 2008 13:21:47 -0500
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
	<1218061585.24157.246.camel@pasglop>
	<fa686aa40808061611p616208bp2baf9a0d5e095870@mail.gmail.com>
	<20080807164513.GA22176@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 7, 2008, at 11:45 AM, Scott Wood wrote:

> On Wed, Aug 06, 2008 at 05:11:08PM -0600, Grant Likely wrote:
>> I do this particular test to make absolute sure that the caller
>> absolutely understands the limitations of the block mapping.  If they
>> call this with something that isn't 128k aligned, then I make it fail
>> immediately so the coder is forced to go and understand what they are
>> allowed to do.  Basically, I'm reinforcing the fact that this is not
>> the same as ioremap().
>>
>> I haven't decided yet if I should test size in the same way.   
>> Thoughts?
>
> I'd prefer it round up the size as needed to cover the requested  
> mapping
> and needed alignment.
>
> The minimum size is going to be different on Book E, for example,  
> and I
> can think of at least one user that will be shared between Book E and
> classic (CPM2 early console).

Which is how ioremap works today.  We ask for a size of 3 bytes and it  
rounds up to a 4k page.  The same should be true of the new interface  
(and round up to whatever the smallest size the HW we are using can  
handle).

- k
