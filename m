Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 94213DDF06
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 06:06:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Fri, 8 Jun 2007 22:06:55 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<65a522813f1b95748a3acc0c05e0285c@kernel.crashing.org>
	<34656f27cfbc4a091e08526b42969ec1@kernel.crashing.org>
In-Reply-To: <34656f27cfbc4a091e08526b42969ec1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706082206.55380.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 June 2007, Segher Boessenkool wrote:
> > That wasn't my question though?
>=20
> Oh wait. =A0You're saying for_each_compatible_node() does
> a put() on all nodes it traverses, but no get()? =A0Ouch!

No, just read the code, it does exactly the right thing.

If you do

for_each_compatible_node(node, NULL, "foo") {
	do_something(node);
}

then the reference count is held just as long as the do_something()
function is run, and if you do

for_each_compatible_node(node, NULL, "foo")
	if (conditional_func(node))
		break;

then the node variable will have the reference count.

	Arnd <><
