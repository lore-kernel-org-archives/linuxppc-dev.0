Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B093B7DFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 08:49:46 +1100 (EST)
Subject: Re: Problem with PCI bus rescan on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
In-Reply-To: <4B996375.3010103@embedded-sol.com>
References: <4B8E6FA3.70503@embedded-sol.com>
	<20100310225100.GB27324@ldl.fc.hp.com>	<4B989F9B.8060708@embedded-sol.com>
	<1268339578.22204.708.camel@pasglop>
	<4B996375.3010103@embedded-sol.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Mar 2010 08:49:34 +1100
Message-ID: <1268344174.22204.714.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-03-11 at 23:41 +0200, Felix Radensky wrote:
> I'm fine with creating a minimal hotplug driver. The device I'm
> dealing with
> partially implements Compact PCI hotplug. It generates ENUM#
> interrupt, but
> Hotswap Control register layout does not completely follow the
> standard.
> 
> Should I use drivers/pci/hotplug/cpci_hotplug_core.c as a base, or do 
> you have
> something more simple in mind ?

I don't have anything special in mind, but you may need to look at how
the pseries hotplug driver does to get those fixups and resource
management things done. That driver is mostly a horrible mess, though I
did clean quite a bit of it up recently...

The main thing of interest to you is pcibios_add_pci_devices() which
is called to probe below an existing bridge. It's currently in
arch/powerpc/platforms/pseries/pci_dlpar.c but we could move it or some
of it to our common code if needed. You also may safely ignore the eeh_*
bits on ppc32

Cheers,
Ben.
