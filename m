Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Mar 2013 19:56:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/11] Add platform_has_feature()
Message-ID: <20130314085616.GD9841@iris.ozlabs.ibm.com>
References: <513AB2E3.6090209@linux.vnet.ibm.com>
 <513AB457.9000409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <513AB457.9000409@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 08, 2013 at 10:02:31PM -0600, Nathan Fontenot wrote:
> The firmware_has_feature() function makes it easy to check for supported
> features of the hardware. There is not corresponding function to check for
> features supported by the client architecture.

Actually, firmware_has_feature checks for supported features of the
hypervisor, or in a sense the platform, rather than hardware.

> This patch adds a platform_has_feature() function to check features selected
> by firmware and reported via the device tree 'ibm,architecture-vec5'
> property. As part of this the #defines used for the architecture vector are
> moved to prom.h and re-defined such that the vector 5 options have the vector
> index and the feature bits encoded into them. This allows for callers of
> platform_has_feature() to pass in a single pre-defined value.

One other comment below...

>  /* PCIe/MSI support.  Without MSI full PCIe is not supported */
>  #ifdef CONFIG_PCI_MSI
> -#define OV5_MSI			0x01	/* PCIe/MSI support */
> +#define OV5_MSI			0x0201	/* PCIe/MSI support */
>  #else
> -#define OV5_MSI			0x00
> +#define OV5_MSI			0x0200
>  #endif /* CONFIG_PCI_MSI */

The #ifdef was done this way in order to control what ended up in the
option vector we pass to the platform firmware.  For checking what the
platform supports, wouldn't we want OV5_MSI to be 0x0201 always?
Similarly for OV5_CMO, OV5_XCMO, etc.?

Paul.
