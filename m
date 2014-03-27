Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 2EF0D1400B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 14:46:14 +1100 (EST)
Message-ID: <53339F03.7010004@tabi.org>
Date: Wed, 26 Mar 2014 22:46:11 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
Subject: Re: [PATCH 2/2] video/fsl: Fix the sleep function for FSL DIU module
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
 <1395855704-19908-2-git-send-email-Jason.Jin@freescale.com>
 <53332168.5050805@tabi.org>
 <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
In-Reply-To: <e3e45edb388c482eb53474e18575f227@BLUPR03MB373.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jason.Jin@freescale.com wrote:
> [Jason Jin-R64188] It's not hackish, we can provide the pixel clock register in the DIU node, I did not provide the dts update as this is only tested on T1040 platform. For other platforms such as p1022 and 8610, we still can use the pixel clock setting function in the platform.
>
> The dts node update for T1040 is:
> display:display@180000 {
>          compatible = "fsl,t1040-diu", "fsl,diu";
> -       reg = <0x180000 1000>;
> +       reg = <0x180000 1000 0xfc028 4>;
>          interrupts = <74 2 0 0>;
> };

This is hackish because you're specifying a single register that you 
want to preserve in the DTS file, instead of a platform function which 
is where it's supposed to be.

I will think about this some more.  I think you are trying too hard to 
avoid a platform file, which is why some of this code is hackish to me.
