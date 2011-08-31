Return-Path: <greg@kroah.com>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40323B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Sep 2011 08:37:17 +1000 (EST)
Date: Wed, 31 Aug 2011 15:35:06 -0700
From: Greg KH <greg@kroah.com>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 01/14] dwc/otg: Add Register definitions
Message-ID: <20110831223506.GA27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<ff45c2ef4d21fa8ae27b36b2862962bf792e2b6b.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ff45c2ef4d21fa8ae27b36b2862962bf792e2b6b.1314704557.git.pratyush.anand@st.com>
Cc: viresh.kumar@st.com, vipulkumar.samar@st.com, bhupesh.sharma@st.com,
	tmarri@apm.com, linux-usb@vger.kernel.org, vipin.kumar@st.com,
	shiraz.hashim@st.com, Amit.VIRDI@st.com, rajeev-dlh.kumar@st.com,
	mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2011 at 05:27:48PM +0530, Pratyush Anand wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> Add Synopsys Design Ware core register definitions.
> 
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> ---
>  drivers/usb/dwc/regs.h | 1324 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 1324 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/dwc/regs.h
> 
> diff --git a/drivers/usb/dwc/regs.h b/drivers/usb/dwc/regs.h
> new file mode 100644
> index 0000000..f29e945
> --- /dev/null
> +++ b/drivers/usb/dwc/regs.h
> @@ -0,0 +1,1324 @@
> +/*
> + * DesignWare HS OTG controller driver
> + * Copyright (C) 2006 Synopsys, Inc.
> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
> + *
> + * This program is free software: you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.

You can stop the boiler-plate text here, because:

> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License version 2 for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see http://www.gnu.org/licenses
> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
> + * Suite 500, Boston, MA 02110-1335 USA.

Unless you wish to track the office location of the FSF for the next 20+
years, remove this, and the previous paragraph please.

> + *
> + * Based on Synopsys driver version 2.60a
> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
> + *
> + * Revamped register difinitions by Tirumala R Marri(tmarri@apm.com)
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DIRECT,
> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

This paragraph is not needed, right?

> + *
> + */
> +
> +#ifndef __DWC_OTG_REGS_H__
> +#define __DWC_OTG_REGS_H__
> +
> +#include <linux/types.h>
> +#include <linux/usb/dwc_otg.h>
> +/*Bit fields in the Device EP Transfer Size Register is 11 bits */

What is this comment for?

Did you drop a space?  And forget an extra line?

> +#undef DWC_LIMITED_XFER_SIZE
> +/*
> + * This file contains the Macro defintions for accessing the DWC_otg core
> + * registers.
> + *
> + * The application interfaces with the HS OTG core by reading from and
> + * writing to the Control and Status Register (CSR) space through the
> + * AHB Slave interface. These registers are 32 bits wide, and the
> + * addresses are 32-bit-block aligned.
> + * CSRs are classified as follows:
> + * - Core Global Registers
> + * - Device Mode Registers
> + * - Device Global Registers
> + * - Device Endpoint Specific Registers
> + * - Host Mode Registers
> + * - Host Global Registers
> + * - Host Port CSRs
> + * - Host Channel Specific Registers
> + *
> + * Only the Core Global registers can be accessed in both Device and
> + * Host modes. When the HS OTG core is operating in one mode, either
> + * Device or Host, the application must not access registers from the
> + * other mode. When the core switches from one mode to another, the
> + * registers in the new mode of operation must be reprogrammed as they
> + * would be after a power-on reset.
> + */
> +
> +/*
> + * DWC_otg Core registers.  The core_global_regs structure defines the
> + * size and relative field offsets for the Core Global registers.
> + */
> +#define	DWC_GOTGCTL		0x000
> +#define	DWC_GOTGINT		0x004
> +#define	DWC_GAHBCFG		0x008
> +#define	DWC_GUSBCFG		0x00C
> +#define	DWC_GRSTCTL		0x010
> +#define	DWC_GINTSTS		0x014
> +#define	DWC_GINTMSK		0x018
> +#define	DWC_GRXSTSR		0x01C
> +#define	DWC_GRXSTSP		0x020
> +#define	DWC_GRXFSIZ		0x024
> +#define	DWC_GNPTXFSIZ		0x028
> +#define	DWC_GNPTXSTS		0x02C
> +#define	DWC_GI2CCTL		0x030
> +#define	DWC_VDCTL		0x034
> +#define	DWC_GGPIO		0x038
> +#define	DWC_GUID		0x03C
> +#define	DWC_GSNPSID		0x040
> +#define	DWC_GHWCFG1		0x044
> +#define	DWC_GHWCFG2		0x048
> +#define	DWC_GHWCFG3		0x04c
> +#define	DWC_GHWCFG4		0x050
> +#define	DWC_HPTXFSIZ		0x100
> +#define	DWC_DPTX_FSIZ_DIPTXF(x)	(0x104 + x * 4)	/* 15 <= x > 1 */

Drop the tab after #define please, as you don't have it anywhere else.


thanks,

greg k-h
