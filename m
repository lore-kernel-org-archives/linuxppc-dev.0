Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3406AB7D50
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 14:21:39 +1100 (EST)
Message-ID: <53147.84.105.60.153.1268450481.squirrel@gate.crashing.org>
In-Reply-To: <20100312223647.GM11655@yookeroo>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<20100312223647.GM11655@yookeroo>
Date: Sat, 13 Mar 2010 04:21:21 +0100 (CET)
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	=?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>,
	linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The historical background here is that in the original OF spec, driver
> matching was done on node name, and only then on compatible.
> Essentially the node name was treated as an implicit first entry in
> the compatible list.  The the generic names convention came along, and
> instead name became a human readable generic type for the device
> ("ethernet", "i2c", etc..).

Even with the generic names recommended practice, matching is _still_
done on "name" first, and only then "compatible".  It isn't expected
that anything will try to match one the generic names, so for "new style"
nodes that in effect means matching on "compatible" only, but it is
important for compatibility.

> That convention has been widely used since long before flat trees
> existed, but for some reason it was never really used for cpu nodes;
> they remained as "PowerPC,XXXX" or whatever.

The PowerPC binding was not updated for generic names.

> Because the varying
> names of cpu nodes was sometimes awkward to deal with in bootloaders,
> we decided it would be sensible to apply the generic names convention
> here too, so "cpu@X".  But then, the previous node name, which was
> treated as being prepended to compatible, should now explicitly be put
> into compatible.

Yes.


Segher
