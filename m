Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 723EF67A73
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 13:13:14 +1000 (EST)
In-Reply-To: <17491.64254.653743.367039@cargo.ozlabs.ibm.com>
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<20060429151936.GM5518@pb15.lixom.net>
	<17491.64254.653743.367039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: please pull powerpc.git 'merge' branch
Date: Sun, 30 Apr 2006 05:12:57 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, torvalds@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Previously we've said implementation instead of specification
>> ("PPC_FEATURE_POWER5_PLUS" etc). That's better than saying base
>> architecture version, since there are parts of the arch that might or
>> might not be implemented (i.e. optional features, etc).
>
> We now have the AT_PLATFORM string, which we didn't have when we added
> the POWER5_PLUS etc. features.  That specifies which particular
> implementation we are on quite precisely.  We don't want to have a bit
> for every single implementation or we'll run out of bits.
>
> The ARCH_2_05 bit means all the non-optional bits of the 2.05
> architecture.  If there are optional features in the architecture, we
> have separate bits for them.  For example, we don't have separate
> bits for POWER4 and for 970; instead we have a HAS_ALTIVEC bit, and
> for 970 we set both POWER4 and HAS_ALTIVEC.  So the POWER4 bit is
> really a "2.00 architecture version" bit.

Except that the 970 at least is actually version 2.01.  Sounds
like names are better than bare numbers -- you showed yourself that
numbers like this are confusing, but you also say that a cpu name
really means an arch version (which isn't so bad -- there generally
is only one "main" CPU per arch version anyway, and people generally
know what is compatible to what).

So please rename ARCH_2_05 to the name of the first CPU that implements
architecture 2.05?


Segher
