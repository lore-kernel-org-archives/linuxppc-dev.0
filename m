Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 921071A076A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
In-Reply-To: <1370258286-27905-1-git-send-email-gsi@denx.de>
To: Gerhard Sittig <gsi@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-usb@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gerhard Sittig <gsi@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [v1,1/1] mpc512x: silence a USB Kconfig dependency warning
Message-Id: <20150819231416.5D66E14078B@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-06 at 11:18:06 UTC, Gerhard Sittig wrote:
> the PPC_MPC512x config automatically selected USB_EHCI_BIG_ENDIAN_*
> switches, which made Kconfig warn about "unmet direct dependencies":
> 
>   scripts/kconfig/conf --silentoldconfig Kconfig
>   warning: (PPC_MPC512x && 440EPX) selects USB_EHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
>   warning: (PPC_MPC512x && PPC_PS3 && PPC_CELLEB && 440EPX) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
>   warning: (PPC_MPC512x && 440EPX) selects USB_EHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
>   warning: (PPC_MPC512x && PPC_PS3 && PPC_CELLEB && 440EPX) selects USB_EHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB && USB_EHCI_HCD)
> 
> make the selected entries additionally depend on USB_EHCI_HCD which
> silences the warning
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/acf6cec8365bfe1e6435

cheers
