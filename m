Return-Path: <pratyush.anand@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9CCFB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 21:31:33 +1000 (EST)
Received: by yxi19 with SMTP id 19so1044089yxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Sep 2011 04:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110831223506.GA27818@kroah.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
	<ff45c2ef4d21fa8ae27b36b2862962bf792e2b6b.1314704557.git.pratyush.anand@st.com>
	<20110831223506.GA27818@kroah.com>
Date: Fri, 2 Sep 2011 17:01:27 +0530
Message-ID: <CAHM4w1mG8swd_iZjr4jPt0Cc3CrcVe5OikH9epoK_Ap=78JhEg@mail.gmail.com>
Subject: Re: [PATCH 01/14] dwc/otg: Add Register definitions
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	linux-usb@vger.kernel.org, vipin.kumar@st.com,
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

On Thu, Sep 1, 2011 at 4:05 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Aug 30, 2011 at 05:27:48PM +0530, Pratyush Anand wrote:
>> From: Tirumala Marri <tmarri@apm.com>
>>
>> Add Synopsys Design Ware core register definitions.
>>
>> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
>> Signed-off-by: Fushen Chen <fchen@apm.com>
>> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> ---
>> =A0drivers/usb/dwc/regs.h | 1324 +++++++++++++++++++++++++++++++++++++++=
+++++++++
>> =A01 files changed, 1324 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/usb/dwc/regs.h
>>
>> diff --git a/drivers/usb/dwc/regs.h b/drivers/usb/dwc/regs.h
>> new file mode 100644
>> index 0000000..f29e945
>> --- /dev/null
>> +++ b/drivers/usb/dwc/regs.h
>> @@ -0,0 +1,1324 @@
>> +/*
>> + * DesignWare HS OTG controller driver
>> + * Copyright (C) 2006 Synopsys, Inc.
>> + * Portions Copyright (C) 2010 Applied Micro Circuits Corporation.
>> + *
>> + * This program is free software: you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>
> You can stop the boiler-plate text here, because:

:)  Ok

>
>> + *
>> + * This program is distributed in the hope that it will be useful
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License version 2 for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see http://www.gnu.org/licenses
>> + * or write to the Free Software Foundation, Inc., 51 Franklin Street,
>> + * Suite 500, Boston, MA 02110-1335 USA.
>
> Unless you wish to track the office location of the FSF for the next 20+
> years, remove this, and the previous paragraph please.
>

:) ok

>> + *
>> + * Based on Synopsys driver version 2.60a
>> + * Modified by Mark Miesfeld <mmiesfeld@apm.com>
>> + *
>> + * Revamped register difinitions by Tirumala R Marri(tmarri@apm.com)
>> + *
>> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS =
"AS IS"
>> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING BUT NOT LIMITED TO =
THE
>> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR P=
URPOSE
>> + * ARE DISCLAIMED. IN NO EVENT SHALL SYNOPSYS, INC. BE LIABLE FOR ANY D=
IRECT,
>> + * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES
>> + * (INCLUDING BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SE=
RVICES;
>> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAU=
SED AND
>> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR=
 TORT
>> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE US=
E OF
>> + * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>
> This paragraph is not needed, right?

will remove.

>
>> + *
>> + */
>> +
>> +#ifndef __DWC_OTG_REGS_H__
>> +#define __DWC_OTG_REGS_H__
>> +
>> +#include <linux/types.h>
>> +#include <linux/usb/dwc_otg.h>
>> +/*Bit fields in the Device EP Transfer Size Register is 11 bits */
>
> What is this comment for?
>
> Did you drop a space? =A0And forget an extra line?

will correct.

>
>> +#undef DWC_LIMITED_XFER_SIZE
>> +/*
>> + * This file contains the Macro defintions for accessing the DWC_otg co=
re
>> + * registers.
>> + *
>> + * The application interfaces with the HS OTG core by reading from and
>> + * writing to the Control and Status Register (CSR) space through the
>> + * AHB Slave interface. These registers are 32 bits wide, and the
>> + * addresses are 32-bit-block aligned.
>> + * CSRs are classified as follows:
>> + * - Core Global Registers
>> + * - Device Mode Registers
>> + * - Device Global Registers
>> + * - Device Endpoint Specific Registers
>> + * - Host Mode Registers
>> + * - Host Global Registers
>> + * - Host Port CSRs
>> + * - Host Channel Specific Registers
>> + *
>> + * Only the Core Global registers can be accessed in both Device and
>> + * Host modes. When the HS OTG core is operating in one mode, either
>> + * Device or Host, the application must not access registers from the
>> + * other mode. When the core switches from one mode to another, the
>> + * registers in the new mode of operation must be reprogrammed as they
>> + * would be after a power-on reset.
>> + */
>> +
>> +/*
>> + * DWC_otg Core registers. =A0The core_global_regs structure defines th=
e
>> + * size and relative field offsets for the Core Global registers.
>> + */
>> +#define =A0 =A0 =A0DWC_GOTGCTL =A0 =A0 =A0 =A0 =A0 =A0 0x000
>> +#define =A0 =A0 =A0DWC_GOTGINT =A0 =A0 =A0 =A0 =A0 =A0 0x004
>> +#define =A0 =A0 =A0DWC_GAHBCFG =A0 =A0 =A0 =A0 =A0 =A0 0x008
>> +#define =A0 =A0 =A0DWC_GUSBCFG =A0 =A0 =A0 =A0 =A0 =A0 0x00C
>> +#define =A0 =A0 =A0DWC_GRSTCTL =A0 =A0 =A0 =A0 =A0 =A0 0x010
>> +#define =A0 =A0 =A0DWC_GINTSTS =A0 =A0 =A0 =A0 =A0 =A0 0x014
>> +#define =A0 =A0 =A0DWC_GINTMSK =A0 =A0 =A0 =A0 =A0 =A0 0x018
>> +#define =A0 =A0 =A0DWC_GRXSTSR =A0 =A0 =A0 =A0 =A0 =A0 0x01C
>> +#define =A0 =A0 =A0DWC_GRXSTSP =A0 =A0 =A0 =A0 =A0 =A0 0x020
>> +#define =A0 =A0 =A0DWC_GRXFSIZ =A0 =A0 =A0 =A0 =A0 =A0 0x024
>> +#define =A0 =A0 =A0DWC_GNPTXFSIZ =A0 =A0 =A0 =A0 =A0 0x028
>> +#define =A0 =A0 =A0DWC_GNPTXSTS =A0 =A0 =A0 =A0 =A0 =A00x02C
>> +#define =A0 =A0 =A0DWC_GI2CCTL =A0 =A0 =A0 =A0 =A0 =A0 0x030
>> +#define =A0 =A0 =A0DWC_VDCTL =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x034
>> +#define =A0 =A0 =A0DWC_GGPIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x038
>> +#define =A0 =A0 =A0DWC_GUID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03C
>> +#define =A0 =A0 =A0DWC_GSNPSID =A0 =A0 =A0 =A0 =A0 =A0 0x040
>> +#define =A0 =A0 =A0DWC_GHWCFG1 =A0 =A0 =A0 =A0 =A0 =A0 0x044
>> +#define =A0 =A0 =A0DWC_GHWCFG2 =A0 =A0 =A0 =A0 =A0 =A0 0x048
>> +#define =A0 =A0 =A0DWC_GHWCFG3 =A0 =A0 =A0 =A0 =A0 =A0 0x04c
>> +#define =A0 =A0 =A0DWC_GHWCFG4 =A0 =A0 =A0 =A0 =A0 =A0 0x050
>> +#define =A0 =A0 =A0DWC_HPTXFSIZ =A0 =A0 =A0 =A0 =A0 =A00x100
>> +#define =A0 =A0 =A0DWC_DPTX_FSIZ_DIPTXF(x) (0x104 + x * 4) /* 15 <=3D x=
 > 1 */
>
> Drop the tab after #define please, as you don't have it anywhere else.

ok. will correct.

Regards
Pratyush

>
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
