Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36C38DDF46
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 02:38:44 +1000 (EST)
Message-ID: <4632270D.6010907@freescale.com>
Date: Fri, 27 Apr 2007 11:38:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] bootwrapper: cuboot-83xx: Exclude upper 1MB from heap.
References: <20070426171931.GA13647@ld0162-tx32.am.freescale.net>
	<22D52AA1-3719-4532-B1CD-D45BB6834843@kernel.crashing.org>
In-Reply-To: <22D52AA1-3719-4532-B1CD-D45BB6834843@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 26, 2007, at 12:19 PM, Scott Wood wrote:
> 
>> The uppermost part of memory is where u-boot puts the stack, so don't
>> include that in the heap.  It's not currently causing problems, as the
>> current code allocates from the bottom of the heap, but this will keep
>> things from potentially breaking if a future implementation were to
>> allocate from the top.
> 
> 
> Why does it matter where u-boot puts it stack?  Once control is  handed 
> over I'd expect it not to matter.

The bootwrapper uses the stack provided by u-boot (unless the platform 
requests otherwise).

-Scott
