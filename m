Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB68C67CEB
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:26:53 +1100 (EST)
Subject: Re: [PATCH 1/4] maple: match "pcie" name for CPC945
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20061211223812.GD6573@localdomain>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<38E12654-EED6-4335-9DC6-293FE70A797C@kernel.crashing.org>
	<20061211223812.GD6573@localdomain>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:26:46 +1100
Message-Id: <1165962406.11914.87.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-12-11 at 16:38 -0600, Nathan Lynch wrote:
> Segher Boessenkool wrote:
> > >Some firmwares have "pcie" for the "name" property of the CPC945 PCI
> > >Express host bridge.  Check for "pcie" in addition to "pci" so we
> > >don't miss it.
> > 
> > You shouldn't use "name" but "device_type" and "compatible".
> 
> Like this?
> 
> (Hmm, does the u3-agp on maple have "pci" for device_type?)

I hope so...

There are plenty bits of code in the kernel that _assume_ that
device_type is PCI for PHB's and P2P bridges, wether they are PCI, PCI-X
or PCIe. prom_parse.c is one, but there is more.

Ben.
