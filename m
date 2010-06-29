Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id AB6BAB7092
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 09:13:06 +1000 (EST)
To: Fushen Chen <fchen@apm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 4/9] Add Synopsys DesignWare HS USB OTG Controller driver.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1277846824673-git-send-email-fchen@apm.com>
References: <12778468223309-git-send-email-fchen@apm.com>
	<12778468233898-git-send-email-fchen@apm.com>
	<12778468231438-git-send-email-fchen@apm.com>
	<1277846824673-git-send-email-fchen@apm.com>
Date: Wed, 30 Jun 2010 01:13:02 +0200
Message-Id: <20100629231302.7E6E314EBF8@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Fushen Chen,

In message <1277846824673-git-send-email-fchen@apm.com> you wrote:
> Implements DWC OTG USB Host Controller Driver (HCD) and interface to
> USB Host controller Driver framework.
> 
> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> ---
>  drivers/usb/otg/dwc_otg_hcd.c | 2397 +++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/otg/dwc_otg_hcd.h |  421 ++++++++
>  2 files changed, 2818 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/usb/otg/dwc_otg_hcd.c
>  create mode 100644 drivers/usb/otg/dwc_otg_hcd.h


Why are you posting this old driver version without trying to sync
against our tree which includes a number of fixes - you should know
about these.

...
> +		do {
> +			hcchar.d32 = dwc_read_reg32(&hc_regs->hcchar);
> +			if (++count > 10000) {
> +				printk(KERN_ERR "%s: Unable to clear halt on "
> +						"channel %d\n",	__func__, i);
> +				break;
> +			}
> +		} while (hcchar.b.chen);
> +	}

For example, here you are missing

	commit 018b43db153da063182c87be2eaad037cba2d879
	Author: Stefan Roese <sr@denx.de>
	Date:   Thu Sep 24 17:15:06 2009 +0200

	    USB: Fix timeout problem with polling loops in DWC USB-OTG driver


In [PATCH 6/9] Add Synopsys DesignWare HS USB OTG Controller driver
you are missing

	commit 538fe70d696bc5e694ab08e9627a99a0b11358ec
	Author: Stefan Roese <sr@denx.de>
	Date:   Wed Sep 23 08:50:29 2009 +0200

	    USB: Fix problem with reconnection in DWC USB-OTG driver

etc.


Please update your code and resubmit.



Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The biggest difference between time and space is that you can't reuse
time.                                                 - Merrick Furst
