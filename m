Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0135.outbound.protection.outlook.com [65.55.169.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A13CA1A024B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 10:24:58 +1000 (AEST)
Date: Thu, 28 May 2015 19:24:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [2/4,v3] powerpc/fsl-booke: Add T1024 QDS board support
Message-ID: <20150529002436.GA4248@home.buserror.net>
References: <1428566865-35732-2-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1428566865-35732-2-git-send-email-Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 09, 2015 at 04:07:43PM +0800, Shengzhou Liu wrote:
> +			flash@2 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "eon,en25s64";   /* 8MB */
> +				reg = <2>;
> +				spi-max-frequency = <10000000>;
> +			};

AFAICT the vendor is phyton, not eon.

> +					eeprom@50 {
> +						compatible = "at24,24c512";
> +						reg = <0x50>;
> +					};
> +
> +					eeprom@51 {
> +						compatible = "at24,24c02";
> +						reg = <0x51>;
> +					};
> +
> +					eeprom@57 {
> +						compatible = "at24,24c02";
> +						reg = <0x57>;
> +					};

The vendor is atmel, not at24.

I'll fix when applying, but please be careful with compatible strings
next time.  Also, please document compatible strings and vendor prefixes
when checkpatch complains, unless it's a situation where checkpatch isn't
recognizing a pattern compatible (e.g.  "fsl,<soc>-whatever" or
"fsl,whatever-<version>").

This patch also had too long lines in the commit message (and really, you
don't need to describe the board in such detail).  I'll remove that
section of the changelog when applying.

-Scott
