Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20091124.093732.203692950.davem@davemloft.net>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081957.6216.74456.stgit@angua>
	<20091124.093732.203692950.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Nov 2009 08:06:55 +1100
Message-ID: <1259096815.16367.133.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 09:37 -0800, David Miller wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Tue, 24 Nov 2009 01:20:05 -0700
> 
> > In struct device_node, the phandle is named 'linux_phandle' for PowerPC
> > and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
> > difference, it is just an artifact of the code diverging over a couple
> > of years.  This patch renames .node to .linux_phandle for SPARC.
> 
> I know it's just a name, but there is no reason to put "linux" in the
> member name.  It's the real device phandle value from OpenFirmware not
> something invented by Linux's OF layer.
> 
> PowerPC uses this for something different, it records the information
> here using the special "linux,phandle" and "ibm,phandle" properties.
> 
> See unflatten_dt_node() in arch/powerpc/kernel/prom.c before your
> changes.

Right, this comes from a subtle problem with our firmwares on pSeries.

We have a phandle from OF. But some devices, especially virtual devices,
also have an "ibm,phandle" which may or may not be the same afaik.

In addition, when the hypervisor hotplugs some devices, it sends us some
new device-tree bits to add. Those don't have a phandle in the formal
sense afaik, but -do- have an ibm,phandle property.

I think we can always just use ibm,phandle instead of the OF one when
the former is present, they should be non overlapping, but of course,
any chance in that area will require plenty of testing on some of those
machines.

Cheers,
Ben.
