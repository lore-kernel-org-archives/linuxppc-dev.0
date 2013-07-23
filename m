Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 616902C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 10:33:44 +1000 (EST)
Date: Mon, 22 Jul 2013 19:33:31 -0500
From: Scott Wood <scottwood@freescale.com>
To: York Sun <yorksun@freescale.com>
Subject: Re: [RFC] power/mpc85xx: Add delay after enabling I2C master
Message-ID: <20130723003330.GA14649@home.buserror.net>
References: <1368480428-23926-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1368480428-23926-1-git-send-email-yorksun@freescale.com>
Cc: albrecht.dress@arcor.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 02:27:08PM -0700, York Sun wrote:
> Erratum A-006037 indicates I2C controller executes the write to I2CCR only
> after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
> during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
> 0), then the controller could end in bad state, and hang the future access
> to I2C register.
> 
> The mpc_i2c_fixup() function tries to recover the bus from a stalled state
> where the 9th clock pulse wasn't generated. However, this workaround
> disables and enables I2C controller without meeting waiting requirement of
> this erratum.
> 
> This erratum applies to some 85xx SoCs. It is safe to apply to all of them
> for mpc_i2c_fixup().
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> 
> ---
> I'd like to get rid of the #ifdef if mpc5121 is OK with the longer delay.

Are mpc5121 and mpc85xx the only things that use this?

Are you sure the delay always works out to be longer?  What is the
relationship between fsl_get_sys_freq() and i2c->real_clk?

In any case, you should send this patch to the i2c maintainer and list.

-Scott
