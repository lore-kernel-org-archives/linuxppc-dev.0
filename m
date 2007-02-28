Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <293fa602618ce81ba7f80be15684aa4b@kernel.crashing.org>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
	<20070227023243.GC1861@localhost.localdomain>
	<0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
	<20070227034541.GD1861@localhost.localdomain>
	<e974c705d1088b60aa021856b8fb95a6@kernel.crashing.org>
	<20070228004040.GC11775@localhost.localdomain>
	<293fa602618ce81ba7f80be15684aa4b@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 07:40:56 +0100
Message-Id: <1172644856.11949.88.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> PCI isn't required to have a device tree at all, with the
> flat tree.

Yes but if there is a device-node, it's expected somewhat to have proper
interrupt informations (though on PCI they are easy to derive if you
have a correct map in the parent).

Now, we do indeed have some "fallback" code that attempts to find PCI
interrupts using "alternate" methods including reading the
PCI_INTERRUPT_LINE config space entry when the standard parsing fails.
We had to do that to deal with broken firmwares on the field including
old SLOF versions.

> If _either_ doesn't allow sharing, i.e., almost all of
> the time.

Most if not all PCI drivers do allow sharing. It's VERY common to share
PCI interrupts on x86.

> SoC interrupts shared?  Not very likely...
> Sure in principle anything can happen.

SoC generally no. But external interrupts connected to random things on
embedded boards being shared, yes. Heh, look at ARM to see the kind of
crackpot you find on the field (especially in PDAs), it's scary.

Ben.
