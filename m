Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAC4DB6F9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 07:43:36 +1000 (EST)
Subject: Re: Kernel cannot see PCI device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Prashant Bhole <prashantsmailcenter@gmail.com>
In-Reply-To: <BANLkTi=J5EFvs3nHDQXNQfyd0EejWJvzcQ@mail.gmail.com>
References: <BANLkTimm98Xxx8y9qM8DUSR4rTDPSFpgHw@mail.gmail.com>
	<BANLkTi=tvyOPoN3f3v_C+NuVOwr+YKaRJA@mail.gmail.com>
	<BANLkTim22Lm=TG9vP+XH25k04ncX=kqy8g@mail.gmail.com>
	<BANLkTinNSXCQJ=WJm6CkfttOgpVz1XOCBQ@mail.gmail.com>
	<BANLkTimoyzERHjw_kQ5SAbNWudWJoX7yMA@mail.gmail.com>
	<1305846751.7481.55.camel@pasglop>
	<BANLkTi=bs31L=C+XWGeXG49xuFVzt+omgA@mail.gmail.com>
	<BANLkTi=J5EFvs3nHDQXNQfyd0EejWJvzcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 May 2011 07:43:08 +1000
Message-ID: <1306273388.7481.240.camel@pasglop>
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Stefan Roese <sr@denx.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Tirumala Marri <tmarri@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-24 at 10:25 +0530, Prashant Bhole wrote:

> Fixed the problem by soft resetting the PCIe port in the function
> ppc460ex_pciex_port_init_hw().
> Is it a right thing to do?
> Following is the patch for kernel 2.6.38.4:
> --------------------------------------------------------------------------------------
> --- linux-2.6.38.4/arch/powerpc/sysdev/ppc4xx_pci.c.orig	2011-05-24
> 10:02:38.000000000 +0530
> +++ linux-2.6.38.4/arch/powerpc/sysdev/ppc4xx_pci.c	2011-05-24
> 10:07:17.000000000 +0530
> @@ -876,6 +876,20 @@
>  	u32 val;
>  	u32 utlset1;
> 
> +	switch (port->index)
> +	{
> +		case 0:
> +			mtdcri(SDR0, PESDR0_460EX_PHY_CTL_RST, 0x0);
> +			mdelay(10);
> +			break;
> +		case 1:
> +			mtdcri(SDR0, PESDR1_460EX_PHY_CTL_RST, 0x0);
> +			mdelay(10);
> +			break;
> +		default:
> +			break;
> +	}
> +
>  	if (port->endpoint)
>  		val = PTYPE_LEGACY_ENDPOINT << 20;
>  	else
> --------------------------------------------------------------------------------------

Well, it's odd that you'd have to do that, maybe something the
bootloader is doing ?

I personally don't mind but I'd like Stefan and/or Tirumala opinion on
this.

Cheers,
Ben.
