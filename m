Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4FAEDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 21:27:30 +1000 (EST)
Subject: Re: Set up device tree for PCI bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Hommel, Thomas (GE Indust, GE Fanuc)" <Thomas.Hommel@gefanuc.com>
In-Reply-To: <62DDBB9E5E23CC4A929EE46F9427CEAF3682BB@BUDMLVEM04.e2k.ad.ge.com>
References: <62DDBB9E5E23CC4A929EE46F9427CEAF3682BB@BUDMLVEM04.e2k.ad.ge.com>
Content-Type: text/plain
Date: Fri, 12 Oct 2007 21:27:14 +1000
Message-Id: <1192188434.8476.112.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-12 at 12:48 +0200, Hommel, Thomas (GE Indust, GE Fanuc)
wrote:
> Hi all,
> I'm wondering how to set up a proper device tree for a PCI bus. The bus
> has a tree-like structure with several bridges and can be extended
> dynamically (by adding PMC/XMC modules).

  .../...

> A problem is that the modules in the Expansion/PMC slot can contain more
> bridges and therefore the bus numbering isn't fixed. For example, if the
> PMC adds one more bus, #5 becomes #6 and #6 becomes #7.
> Can I assign fixed resources for all the bridge parts of the system?

ppc32 should cope with renumbering... though ppc64 will probably not.

What you can do perhaps is to assign wide bus ranges to your slots. For
example, slot 0 would provide bus 0x10...0x1f, slot 1 bus 0x20 to 0x2f
etc... You would thus only put the switch busses in the device-tree.

There is still a potential issue if you connect enough sub busses to
blow that range of 16 away but that's unlikely.

Such a solution would work for the time being. In the long run, I do
intend to make the kernel more flexible overall with bus renumbering vs.
OF tree.
