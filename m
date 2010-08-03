Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7580B6F0E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 09:40:05 +1000 (EST)
Message-ID: <55638.84.105.60.153.1280878799.squirrel@gate.crashing.org>
In-Reply-To: <20100803231114.GP29316@kryten>
References: <20100803060834.GK29316@kryten>
	<1C2B156C-E6C9-47CC-B5BF-6AA603581EC3@kernel.crashing.org>
	<20100803231114.GP29316@kryten>
Date: Wed, 4 Aug 2010 01:39:59 +0200 (CEST)
Subject: Re: [PATCH 1/3] powerpc: Optimise 64bit csum_partial
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Anton Blanchard" <anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Hi Segher,
>
>> Not really.  Do you know how many 16/32-bit words you can add before a
>> 64-bit register can overflow? :-)
>
> Thats a very good point. I thought about using 32bit adds when writing
> the copy and checksum routine, but came to the conclusion that it wouldn't
> go
> any faster than one using addes.

Well, you now have one 64-bit word in two cycles, using one load and
an adde.

You can do 64-bits with two loads and two integer insns instead, or
one load and three integer insns.  It depends on your pipeline structure
what is best, I don't remember what POWER6/7 have exactly, but I bet
you do :-)

If you don't have to deal with the carry, you don't have to care about
the latency of your insns either, since you can just software pipeline it.

> The checksum only routine was the same
> loop
> without the stores.

The stores are just to copy, right?  So two loads/two stores/two integer
(per 64-bit), which probably works out to two cycles; or one load/
one store/ three integer, which is one or one and a half cycle.


Segher
