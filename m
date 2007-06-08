Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C27EDDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 06:16:57 +1000 (EST)
In-Reply-To: <200706082206.55380.arnd@arndb.de>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
	<34656f27cfbc4a091e08526b42969ec1@kernel.crashing.org>
	<200706082206.55380.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2b3134aaf411c43fabdb6bba233f91a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 22:16:48 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If you do
>
> for_each_compatible_node(node, NULL, "foo") {
> 	do_something(node);
> }
>
> then the reference count is held just as long as the do_something()
> function is run,

Yeah.  so (like we discussed on irc) the of_node_get() in
the code under discussion should really be done inside the
axon_msi_setup_one() function.

> and if you do
>
> for_each_compatible_node(node, NULL, "foo")
> 	if (conditional_func(node))
> 		break;
>
> then the node variable will have the reference count.

Yes.  This is bad form though, "for_each" means for
_each_, open coding the loop would be clearer IMHO.


Segher
