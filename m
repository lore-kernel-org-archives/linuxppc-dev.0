Return-Path: <tmarri@apm.com>
Received: from exprod5og115.obsmtp.com (exprod5og115.obsmtp.com [64.18.0.246])
 by ozlabs.org (Postfix) with SMTP id D52EFB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2011 05:14:26 +1100 (EST)
Received: by iakl21 with SMTP id l21so3550975iak.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 11:14:24 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <F6C4814A9B336243ABC3D1FB44E08AE801D2B2FEF4@US01WXMBX1.internal.synopsys.com>
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE801D2B2FEF4@US01WXMBX1.internal.synopsys.com>
MIME-Version: 1.0
Date: Fri, 14 Oct 2011 11:14:22 -0700
Message-ID: <9fa903c8656e99d5ad8844f4c8390634@mail.gmail.com>
Subject: RE: [PATCH v14 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core Interface
 Layer (CIL)
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<> +void dwc_otg_enable_global_interrupts(struct core_if *core_if)
<> +{
<> +	u32 ahbcfg = 0;
<> +
<> +	ahbcfg |= DWC_AHBCFG_GLBL_INT_MASK;
<> +	dwc_reg_modify(core_if->core_global_regs, DWC_GAHBCFG, 0,
<> +		     ahbcfg);
<
<What is the point of initializing the variable to 0, and then
<immediately
<ORing it with a value? Why not just:
<
<	u32 ahbcfg = DWC_AHBCFG_GLBL_INT_MASK;
<
<	dwc_reg_modify(core_if->core_global_regs, DWC_GAHBCFG,
<		     ahbcfg, 0);
<
<or even simpler:
<
<	dwc_reg_modify(core_if->core_global_regs, DWC_GAHBCFG,
<		       DWC_AHBCFG_GLBL_INT_MASK, 0);
<
<? Same for other places in this file.

[Tirumala Marri] I can definitely change this at some places.
This had to do because there was suggestion modify the API to accept
The offset. It happened to be some of the accesses doesn't have offsets.
<
<> +/**
<> + * Tests if the current hardware is using a full speed phy.
<> + */
<> +static inline int full_speed_phy(struct core_if *core_if)
<> +{
<> +	if ((DWC_HWCFG2_FS_PHY_TYPE_RD(core_if->hwcfg2) == 2 &&
<> +	     DWC_HWCFG2_FS_PHY_TYPE_RD(core_if->hwcfg2) == 1 &&
<
<Surely this is a typo? You are checking the same variable for containing
<two different values at the same time. From looking at similar code in
<the dwc_otg_core_init() function, I think you meant to write:

[Tirumala Marri] Will correct
