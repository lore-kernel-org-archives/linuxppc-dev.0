Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id BB3C267A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 08:24:28 +1100 (EST)
Date: Wed, 23 Feb 2005 14:24:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050223142426.B13087@cox.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05022310396240c8ac@mail.gmail.com>;
	from shawnxjin@gmail.com on Wed, Feb 23, 2005 at 10:39:34AM -0800
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 10:39:34AM -0800, Shawn Jin wrote:
> Hi,
> 
> This adds UBoot support on Ebony board and also sets emac's PHY mode
> explicitly during initialization as Eugene Surovegin provided.

<snip>

> +	if (!strncmp(__res.bi_enetaddr, "\0xFF\0xFF\0xFF\0xFF\0xFF\0xFF", 6))
> +	  	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
> +	else
> +		memcpy(emacdata->mac_addr, EBONY_NA0_ADDR(vpd_base), 6);

Can you use the ocotea/luan approach and create an openbios stub
in arch/ppc/boot to create the bi_enetaddr infos? The PIBS stub
in arch/ppc/boot does this so we can have one path in the platform
file that parses the bootinfos.

-Matt
