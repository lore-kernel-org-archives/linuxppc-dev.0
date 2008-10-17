Return-Path: <dgibson@ozlabs.org>
Date: Fri, 17 Oct 2008 12:26:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: device tree variations
Message-ID: <20081017012604.GA22213@yookeroo.seuss>
References: <48F7E1E6.4040701@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48F7E1E6.4040701@consentry.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 16, 2008 at 05:52:54PM -0700, Mike Ditto wrote:
> I'm building a kernel that can run on a handful of hardware
> configurations, all using OF-unaware U-Boot.  I know how to make a
> static device tree (dts file) that works on one of these hardware
> variations, and how to add nodes and modify properties in the platform
> init code.  But I don't see a nice way to deal with nodes that should be
> present on only some hardware configurations.
> 
> I could have the dts file contain only the common elements, and add all
> the variable elements in the startup code.  But that means the bulk of
> the device tree will be expressed as relatively ugly C source instead of
> the much more readable and maintainable dts notation.  I would much
> rather have the dts file contain the union of all platforms and have the
> platform init code delete the nodes that are not applicable, but I don't
> see an API to do those deletions.
> 
> I suppose I could instead compile N different dts files and have the
> platform init code pick the appropriate dtb blob to pass to
> fdt_init().

Deleting the irrelevant parts or picking a device tree to pass to
fdt_init() are both reasonable solutions.  libfdt which is included in
the bootwrapper has functions for removing unwanted nodes: either
fdt_nop_node() or fdt_del_node() will suffice.  There isn't currently
a dt_ops hook to call though to those functions though.  You could
either add one, or (knowing that your platform always has a flat dt)
bypass the dt_ops hooks and call libfdt directly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
