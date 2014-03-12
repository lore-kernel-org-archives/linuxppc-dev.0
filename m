Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 374232C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 05:45:44 +1100 (EST)
Message-ID: <1394649930.13761.154.camel@snotra.buserror.net>
Subject: Re: [PATCH] T1040RDB: add qe node for T1040RDB dts
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Wed, 12 Mar 2014 13:45:30 -0500
In-Reply-To: <1394612762-36308-1-git-send-email-B45475@freescale.com>
References: <1394612762-36308-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 16:26 +0800, Zhao Qiang wrote:
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/boot/dts/t1040rdb.dts | 43 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Presumably this is on top of this patch:
http://patchwork.ozlabs.org/patch/314138/

...since there's no existing t1040 device tree support.  Always mention
when your patch is on top of a patch that hasn't yet been merged and
isn't in the same patch set.

At least some of this stuff seems like it should be in t1040si-post.dts
(or a file included by it), rather than the board dts.

> +		tdma: ucc@2000 {
> +			compatible = "fsl,ucc-tdm";
> +			rx-clock-name = "clk3";
> +			tx-clock-name = "clk4";
> +			fsl,rx-sync-clock = "rsync_pin";
> +			fsl,tx-sync-clock = "tsync_pin";
> +			fsl,tx-timeslot = <0xfffffffe>;
> +			fsl,rx-timeslot = <0xfffffffe>;
> +			fsl,tdm-framer-type = "e1";
> +			fsl,tdm-mode = "normal";
> +			fsl,tdm-id = <0>;
> +			fsl,siram-entry-id = <0>;
> +		};
> +
> +		serial: ucc@2200 {
> +			device_type = "serial";
> +			compatible = "ucc_uart";
> +			port-number = <1>;
> +			rx-clock-name = "brg2";
> +			tx-clock-name = "brg2";
> +		};

Missing reg.

-Scott
