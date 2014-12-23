Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89FAE1A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 19:08:18 +1100 (AEDT)
Message-ID: <1419322085.5581.182.camel@freescale.com>
Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Tue, 23 Dec 2014 02:08:05 -0600
In-Reply-To: <DM2PR0301MB08642FFDB6207DE205731547E2570@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
 <1416966592.15957.172.camel@freescale.com>
 <DM2PR0301MB08641FB289DBA17AD59FBEA0E26A0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1418940078.5581.143.camel@freescale.com>
 <DM2PR0301MB0864AA31CD1A7438F476020FE26B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1419030955.5581.154.camel@freescale.com>
 <DM2PR0301MB086427C10254A0A749CD1326E2560@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <5497D466.9090804@Freescale.com> <1419237176.5581.159.camel@freescale.com>
 <5497E645.7010500@Freescale.com> <1419241330.5581.162.camel@freescale.com>
 <5497FBAB.4010206@Freescale.com> <1419283551.5581.172.camel@freescale.com>
 <DM2PR0301MB08642FFDB6207DE205731547E2570@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>, Liberman
 Igal-B31950 <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 01:35 -0600, Xie Shaohui-B21989 wrote:
> +- bus-frequency
> +		Usage: optional
> +		Value type: <u32>
> +		Definition: Specifies external MDIO bus clock speed which is
> +		different from MDIO standard 2.5MHz. Should be defined for SoCs
> +		on which the standard one cannot work.
> 
> What should I rephrase it? Replace the last sentence with "Should be defined
> For SoCs on which a lower frequency than the standard is required."?

Neither of these work with Emil's scenario of a system that allows a
faster-than-standard speed.

How about: "Definition: Specifies the external MDIO bus clock speed to
be used, if different from the standard 2.5 MHz.  This may be due to the
standard speed being unsupported (e.g. due to a hardware problem), or to
advertise that all relevant components in the system support a faster
speed."

> How about the value used in example?
> Should 2.5MHz be used or a lower one?

If you don't have a realistic example to use, don't put it in the
example at all.  2.5MHz is the worst example to use because that's the
default and there'd be no reason to use the property at all.

-Scott
