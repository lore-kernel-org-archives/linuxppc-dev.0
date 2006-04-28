Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17489.64606.75404.314368@cargo.ozlabs.ibm.com>
Date: Fri, 28 Apr 2006 21:28:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim
In-Reply-To: <1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<248CD1B3-A33B-47F5-AFE8-F7C9DDCD1D0B@kernel.crashing.org>
	<20060425185314.GC1132@gate.ebshome.net>
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> If we have a u-boot shim there are some questions that need answering:
> * where should the .dts live (hate duplicating the file both in u- 
> boot and kernel source tree)
> * how does build system find .dts
> * a Kconfig option to enable shim
> * assume done as a boot wrapper of sorts

What I think would be useful is a stand-alone tool that would take a
kernel and a dts and construct an image that is bootable on a given
board by its existing firmware.  That means there would either need to
be a version of the tool for each firmware, or alternatively a set of
command-line options to tell it what sort of firmware you have.

This wouldn't have to be done at kernel build time; it could be
potentially be done much later.  Hopefully then the board vendors
could take on the job of generating the dts.  In fact for some boards
the board-support package could be just the dts.

This tool would need to insert a suitable shim, which might actually
need to contain code to pull stuff out of a firmware-specific
structure such as a bd_t, and stuff it into the dts.  That should be
doable provided there is a convention about labels in the dts for
things such as memory size, ethernet mac address, etc.

Clearly it is neater if the firmware can supply the device-tree blob
directly, and just boot a raw kernel.  However, there will always be
situations where we don't get to choose the firmware, so I think we
need this tool.

Paul.
