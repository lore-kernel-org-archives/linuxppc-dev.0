Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57D89DDEBA
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 10:19:46 +1000 (EST)
In-Reply-To: <AB18F3F9-C844-4ECE-8EE3-7B05DDD5669E@kernel.crashing.org>
References: <20070612163016.253915076@arndb.de>
	<18032.40447.579128.989284@cargo.ozlabs.ibm.com>
	<B4E893D5-A61E-4A91-B31C-AF9B7C0B116D@kernel.crashing.org>
	<1181954800.26853.103.camel@localhost.localdomain>
	<AB18F3F9-C844-4ECE-8EE3-7B05DDD5669E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fc4a7b2db4e8906db6b6f6402b6ce6a7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sun, 17 Jun 2007 02:19:36 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, arnd@arndb.de,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I would much
>> prefer the CONFIG_xxx_ONLY_ONE be -generated- by the multiple choice
>> menu if only one choice has been selected.
>>
>> That could be an optional argument to the menu stuff to set that.
>
> That was my intent, that the Kconfig system would help in telling us
> only one choice was selected and we could optimize based on that.  In
> addition, to ensure that at least one choice was selected.  I believe
> Rob Landley came across an issue that exists today with MULTIPLATFORM
> support in that we can attempt to build a kernel w/o any system.

Each of the CPU options is set to either "y" or "", so:


options-$(option1)$(option2)$(option3) := y

ifeq ($(options)-,y)
	$(error blablabla)
endif

CONFIG_POWERPC_ONLY_ONE_CPU := $(options-y)


or some variant on this will do just fine.


Segher
