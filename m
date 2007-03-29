Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175208237.3122.78.camel@pmac.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 30 Mar 2007 09:23:28 +1000
Message-Id: <1175210608.5624.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-29 at 23:43 +0100, David Woodhouse wrote:
> The old 2.6.16 kernel handled memory statically and it was shown in the
> device tree. The current kernel deals with the hypervisor and hotplugs
> the memory, so we should just ignore anything that's reported in the
> device-tree. This enables the current kernel to be booted from 2.6.16
> without evil hacks in head_64.S to override the device-tree.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

How can this work ? Memory is parsed from early_init_devtree() which is
called before the platform probe() routines which is the one that sets
FW_FEATURE_PS3_LV1... 

It's really annoying that they didn't get their device-tree right in the
first place. They should put the RMO in there and nothing else I
suppose.

Ben.
