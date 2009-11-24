Return-Path: <davem@davemloft.net>
Date: Tue, 24 Nov 2009 09:37:32 -0800 (PST)
Message-Id: <20091124.093732.203692950.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 11/11] of: unify phandle name in struct device_node
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091124081957.6216.74456.stgit@angua>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081957.6216.74456.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 01:20:05 -0700

> In struct device_node, the phandle is named 'linux_phandle' for PowerPC
> and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
> difference, it is just an artifact of the code diverging over a couple
> of years.  This patch renames .node to .linux_phandle for SPARC.

I know it's just a name, but there is no reason to put "linux" in the
member name.  It's the real device phandle value from OpenFirmware not
something invented by Linux's OF layer.

PowerPC uses this for something different, it records the information
here using the special "linux,phandle" and "ibm,phandle" properties.

See unflatten_dt_node() in arch/powerpc/kernel/prom.c before your
changes.
