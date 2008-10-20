Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-125.bluehost.com (outbound-mail-125.bluehost.com
	[67.222.38.25]) by ozlabs.org (Postfix) with SMTP id 276DADDE01
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:17:55 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] pci: Workaround invalid P2P bridge bus numbers
Date: Mon, 20 Oct 2008 16:17:49 -0700
References: <20081020230717.2FD16DDDDB@ozlabs.org>
In-Reply-To: <20081020230717.2FD16DDDDB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810201617.49733.jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, AymanE@tanisys.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, October 20, 2008 4:06 pm Benjamin Herrenschmidt wrote:
> Some firmware fail to properly configure P2P bridges, leaving them
> with invalid bus numbers. In some cases, this happens on some embedded
> 4xx boards as the result of the kernel allocating different bus space
> than the firmware does to host bridges while not setting
> pcibios_assign_all_busses() for various reasons. In other cases, it can
> just be bogus firmware.
>
> This adds some sanity checking to the PCI probing code. If a bridge is
> found whose primary bus number doesn't match the bus it's sitting on,
> or whose secondary bus number not strictly above it's primary bus
> number, then the bridge bus numbers are deconfigured in the first pass
> of pci_scan_bridge() to be re-assigned in the second pass.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Ayman, can you double check that this variant of the patch still
> fixes your problem ? Thanks !

Sure, seems straightforward enough, I'll wait for Ayman's "Tested-by" before 
pushing.

Thanks,
Jesse
