Return-Path: <dgibson@ozlabs.org>
Date: Fri, 3 Aug 2007 15:22:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Siva Prasad <sprasad@bivio.net>
Subject: Re: Open Firmware - dts file
Message-ID: <20070803052208.GB2392@localhost.localdomain>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D79AE206@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D79AE206@corpexc01.corp.networkrobots.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 02, 2007 at 12:21:21PM -0700, Siva Prasad wrote:
> Hi,
> 
> I am trying to understand ..
> 
> 1) How a given dts file is embedded into the zImage (how about vmlinux?)

The arch/powerpc/boot/wrapper script builds the dts into a device tree
blob using dtc (the Device Tree Compiler), it then folds the binary
device tree into a special section in the zImage.

> 2) Where does it get stored for later access during booting?

The zImage, possibly after adjusting the device tree based on
information from the firmware, passes the address of the tree to the
kernel as it invokes it.  The kernel adds the device tree address (as
well as any further ranges specified in the device tree blob) to its
internal list of reserved addresses so it won't clobber it with other
allocations.

> 3) How a specific dts file out of the available in /boot/dts directory
> is chosen?

Depending on the Kconfig, different Makefile targets will be
selected.  Those targets then invoke the wrapper script with different
options, including different dts files into the zImage.

> I am a newbie to this open firmware thing and looking for the right
> pointer to get started.

Ok.. do understand that on systems with a full open firmware
implementation a dts won't generally be used at all.  Instead the
kernel will read the device tree information from open firmware itself
and convert it directly into a device tree blob (which will later be
unpacked into the run-time device tree structure).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
