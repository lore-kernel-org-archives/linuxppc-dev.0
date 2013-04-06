Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B63642C0107
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 19:00:14 +1100 (EST)
Message-ID: <1365235201.31207.9.camel@pasglop>
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for
 graphics adapters on Power
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 06 Apr 2013 10:00:01 +0200
In-Reply-To: <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-04-05 at 14:11 -0600, Bjorn Helgaas wrote:
> 
> I think sparc has the same issue in its own copy of
> of_create_pci_dev().
> 
> Of course, both of_create_pci_dev() implementations are basically
> copies of the generic pci_setup_device() that most arches use.  That's
> the reason why I wish sparc and powerpc had used config space
> accessors that hid the OF mangling internally so they could use the
> generic pci_setup_device() instead of cloning it.

I disagree :-) I want the config space accessors to actually do the
config space access (it might be necessary for some reasons, if anything
for diagnostic). Also one of the reasons we create devices that way
originally iirc, is that on older pre-PCIe setups, we could have cases
of a bridge showing up at function N > 0 without anything at function
0. 

We are also not allowed to mess with bridge BARs on old EADS bridges,
and similar issues where the hypervisor can get upset.

A "filtering" config space code would be a lot messier than just
creating them like we do.

However we could/should probably make the code more common between
powerpc and sparc and maybe move the bulk of it to a generic place more
easily grepped by the PCI folks.

> Of course, they don't, and that's too much work for fixing this issue,
> but if anybody wanted to work on that, I think it would be an
> interesting project.
> 
> But what if you set dev->dev.type in alloc_pci_dev()?  I think if you
> did that, you wouldn't need to export "pci_dev_type," and  it should
> fix this for both powerpc and sparc.

Cheers,
Ben.
