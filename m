Return-Path: <balbi@ti.com>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailhost.ti.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8522B70E6
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 17:22:43 +1100 (EST)
Date: Thu, 21 Oct 2010 09:10:42 +0300
From: Felipe Balbi <balbi@ti.com>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH V5 1/9] Add Synopsys DesignWare HS USB OTG Control and
	Status Register (CSR).
Message-ID: <20101021061042.GN3958@legolas.emea.dhcp.ti.com>
References: <12876217721253-git-send-email-fchen@apm.com>
	<1287621773567-git-send-email-fchen@apm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1287621773567-git-send-email-fchen@apm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Mark Miesfeld <mmiesfeld@apm.com>, "gregkh@suse.de" <gregkh@suse.de>
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Oct 20, 2010 at 07:42:44PM -0500, Fushen Chen wrote:
>Control and Status Register (CSR) are classified as follows:
> - Core Global Registers
> - Device Mode Registers
> - Device Global Registers
> - Device Endpoint Specific Registers
> - Host Mode Registers
> - Host Global Registers
> - Host Port CSRs
> - Host Channel Specific Registers
>
>Signed-off-by: Fushen Chen <fchen@apm.com>
>Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
>---
> drivers/usb/dwc_otg/dwc_otg_regs.h | 3269 ++++++++++++++++++++++++++++++++++++
> 1 files changed, 3269 insertions(+), 0 deletions(-)
> create mode 100644 drivers/usb/dwc_otg/dwc_otg_regs.h
>
>diff --git a/drivers/usb/dwc_otg/dwc_otg_regs.h b/drivers/usb/dwc_otg/dwc_otg_regs.h
>new file mode 100644
>index 0000000..fdc40f9
>--- /dev/null
>+++ b/drivers/usb/dwc_otg/dwc_otg_regs.h
>@@ -0,0 +1,3269 @@
>+/*
>+ * DesignWare HS OTG controller driver
>+ * Copyright (C) 2006 Synopsys, Inc.
>+ * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
>+ *
>+ * This program is free software: you can redistribute it and/or
>+ * modify it under the terms of the GNU General Public License
>+ * version 2 as published by the Free Software Foundation.
>+ *
>+ * This program is distributed in the hope that it will be useful
>+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>+ * GNU General Public License version 2 for more details.
>+ *
>+ * You should have received a copy of the GNU General Public License
>+ * along with this program; if not, see http://www.gnu.org/licenses
>+ * or write to the Free Software Foundation, Inc., 51 Franklin Street,
>+ * Suite 500, Boston, MA 02110-1335 USA.
>+ *
>+ * Based on Synopsys driver version 2.60a
>+ * Modified by Mark Miesfeld <mmiesfeld@apm.com>
>+ *
>+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
>+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO THE
>+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
>+ * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY DIRECT,
>+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
>+ * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
>+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
>+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT
>+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>+ *
>+ */
>+
>+#ifndef __DWC_OTG_REGS_H__
>+#define __DWC_OTG_REGS_H__
>+
>+#include <linux/types.h>
>+
>+/*
>+ * This file contains the data structures for accessing the DWC_otg core
>+ * registers.
>+ *
>+ * The application interfaces with the HS OTG core by reading from and
>+ * writing to the Control and Status Register (CSR) space through the
>+ * AHB Slave interface. These registers are 32 bits wide, and the
>+ * addresses are 32-bit-block aligned.
>+ * CSRs are classified as follows:
>+ * - Core Global Registers
>+ * - Device Mode Registers
>+ * - Device Global Registers
>+ * - Device Endpoint Specific Registers
>+ * - Host Mode Registers
>+ * - Host Global Registers
>+ * - Host Port CSRs
>+ * - Host Channel Specific Registers
>+ *
>+ * Only the Core Global registers can be accessed in both Device and
>+ * Host modes. When the HS OTG core is operating in one mode, either
>+ * Device or Host, the application must not access registers from the
>+ * other mode. When the core switches from one mode to another, the
>+ * registers in the new mode of operation must be reprogrammed as they
>+ * would be after a power-on reset.
>+ */
>+
>+/*
>+ * DWC_otg Core registers.  The core_global_regs structure defines the
>+ * size and relative field offsets for the Core Global registers.
>+ */
>+struct core_global_regs {
>+       /* OTG Control and Status Register.             Offset: 000h */
>+       u32 gotgctl;

generally we use defines for the register space:

#define DWC_OTG_CTL		0x0000
#define DWC_OTG_INT		0x0004

and so on.

>+#if defined(CONFIG_DWC_OTG_REG_LE)
>+/*
>+ * This union represents the bit fields of the Core OTG Controland Status
>+ * Register (GOTGCTL).  Set the bits using the bit fields then write the d32
>+ * value to the register.
>+ */
>+union gotgctl_data {                           /* CONFIG_DWC_OTG_REG_LE */
>+       u32 d32;
>+       struct {
>+               unsigned reserved31_21:11;
>+               unsigned currmod:1;
>+               unsigned bsesvld:1;
>+               unsigned asesvld:1;
>+               unsigned reserved17:1;
>+               unsigned conidsts:1;
>+               unsigned reserved1_12:4;
>+               unsigned devhnpen:1;
>+               unsigned hstsethnpen:1;
>+               unsigned hnpreq:1;
>+               unsigned hstnegscs:1;
>+               unsigned reserved07_02:6;
>+               unsigned sesreq:1;
>+               unsigned sesreqscs:1;
>+       } b;
>+};

these would be defines too:

#define DWC_OTG_CTL_SESREQSCS	(1 << 0)
#define DWC_OTG_CTL_SESEQ	(1 << 1)

and so on.

-- 
balbi
