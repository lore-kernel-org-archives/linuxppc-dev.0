Return-Path: <richardcochran@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fMSH59BvzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 00:30:48 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id w8-v6so5637236ply.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 07:30:48 -0700 (PDT)
Date: Mon, 30 Jul 2018 07:30:43 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Message-ID: <20180730143043.qu66ttzwyjbw6si7@localhost>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730100154.27906-3-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2018 at 06:01:54PM +0800, Yangbo Lu wrote:
> The ptp_qoriq driver initialized the 1588 timer with the
> configurations provided by the properties of device tree
> node. For example,
> 
>   fsl,tclk-period = <5>;
>   fsl,tmr-prsc    = <2>;
>   fsl,tmr-add     = <0xaaaaaaab>;
>   fsl,tmr-fiper1  = <999999995>;
>   fsl,tmr-fiper2  = <99990>;
>   fsl,max-adj     = <499999999>;
> 
> These things actually were runtime configurations which
> were not proper to be put into dts.

That is debatable.  While I agree that the dts isn't ideal for these,
still it is the lesser of two or more evils.

> This patch is to convert
> to use module parameters for 1588 timer initialization, and
> to support initial register values calculation.

It is hard for me to understand how using module parameters improves
the situation.

> If the parameters are not provided, the driver will calculate
> register values with a set of default parameters. With this
> patch, those dts properties are no longer needed for new
> platform to support 1588 timer, and many QorIQ DPAA platforms
> (some P series and T series platforms of PowerPC, and some
> LS series platforms of ARM64) could use this driver for their
> fman ptp timer with default module parameters. However, this
> patch didn't remove the dts method. Because there were still
> many old platforms using the dts method. We need to clean up
> their dts files, verify module parameters on them, and convert
> them to the new method gradually in case of breaking any
> function.

In addition, like it or not, because the dts is an ABI, you must
continue support of the dts values as a legacy option.

Thanks,
Richard
