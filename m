Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38773B7D47
	for <linuxppc-dev@ozlabs.org>; Fri, 21 May 2010 02:04:35 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4KG4Vw2003326
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 09:04:31 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o4KGFSWe027287
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 11:15:28 -0500 (CDT)
Message-ID: <4BF55D8D.5070801@freescale.com>
Date: Thu, 20 May 2010 11:04:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: make the padding for the device tree
	a	configurable option
References: <1274298809-12772-1-git-send-email-timur@freescale.com>	<1274304013.1931.6.camel@pasglop>
	<4BF4593E.8030101@freescale.com>	<1274309050.1931.21.camel@pasglop>	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
	<20100520011820.GT25892@yookeroo>
In-Reply-To: <20100520011820.GT25892@yookeroo>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2010 08:18 PM, David Gibson wrote:
> On Wed, May 19, 2010 at 07:03:17PM -0500, Timur Tabi wrote:
>> On Wed, May 19, 2010 at 5:44 PM, Benjamin Herrenschmidt
>>> The padding in the kernel built is intended to
>>> make space for DT changes done by the zImage wrapper.
>>
>> Well, okay.  I think it would be nice if we expanded that to handle
>> general usage.

Don't we have dynamic expansion in the zImage wrapper?

>>> Maybe we could add to libfdt a way to provide a realloc() callback to it
>>> when it hits the max size, and uboot can then move things around (or
>>> fail).
>>
>> The problem is that the code which allocates a block for the fdt is
>> completely distinct from the code that manipulates the fdt.  We'd need
>> to put in either some kind of funky callback mechanism, or insist that
>> every fdt exist in a block of memory allocated by some specific method
>> (e.g. lmb).
>>
>> I'm stuck between a rock and a hard place, it seems.  No one is
>> willing to compromise on any of my ideas.  It's hard to convince our
>> BSP developers that they should be pushing more code upstream when I
>> get so much resistance for a such a mundane change.
>
> Couldn't you use the configurable padding, but put the stuff to do it
> into u-boot.  i.e. repad the dtb at u-boot build time, rather than
> u-boot runtime.

Currently generating a dtb is not done as part of the u-boot build 
process -- and apparently some people are using the Linux makefile 
target to do it.

I think the right thing is to do whatever we need to do in u-boot to get 
dynamic expansion fully working (it already does it in some 
circumstances, just not always, or necessarily safely).  Static padding 
is too fragile.

-Scott
