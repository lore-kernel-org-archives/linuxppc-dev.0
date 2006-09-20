Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62B5567B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:23:24 +1000 (EST)
In-Reply-To: <1158721828.3043.13.camel@vader.jdub.homelinux.org>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<1158721828.3043.13.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6FD3E5E-94EF-4E12-A0FB-8700F0DF8151@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Wed, 20 Sep 2006 22:23:09 +0200
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It was pointed out on IRC that the "address" property is defined in  
> the
> OF spec for specifying virtual address mappings.  This is exactly what
> we need in that it allows the zImage wrapper to use the fw defined  
> UART
> mapping, but the kernel still gets the real physical address later on.
> And other things that don't use zImage wrappers, like u-boot, can  
> simply
> ignore the "address" property defined within the UART node.

The "address" property has several problems.  An obvious one is that the
name is too generic.  A nastier one is that once you start making new  
MMU
mappings, you have to keep *all* old mappings, or blow away the mapping
for this "address" as well (you don't know the size of the mapping).   
And
a third problem is that it can only encode 32-bit virtual addresses.

Now, if it's only used for the very-early-debug UART console on machines
that cannot accesses physical addresses directly, in things like a boot-
wrapper that cannot be bothered to set up a MMU mapping themselves (and
there might be good reasons not to), and only when there is no client
interface (i.e., it uses the flat tree only); then it might be a  
reasonable
approach.  All alternatives I can think of have their own nasty  
problems.

So please comment the nastiness with a big "HACK HACK HACK" comment and
make sure it only ever gets used on systems where nothing better is
available, and all should be fine.


Segher
