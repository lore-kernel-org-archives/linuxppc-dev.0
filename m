Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 232082C011D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 04:27:35 +1000 (EST)
Date: Mon, 12 Aug 2013 11:27:33 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 02/31] serial: mpc512x: cleanup clock API use
Message-ID: <20130812182733.GA20233@kroah.com>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-3-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375821851-31609-3-git-send-email-gsi@denx.de>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>,
 Detlev Zundel <dzu@denx.de>, Wolfram Sang <wsa@the-dreams.de>,
 David Woodhouse <dwmw2@infradead.org>, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 10:43:42PM +0200, Gerhard Sittig wrote:
> cleanup the clock API use of the UART driver which is shared among the
> MPC512x and the MPC5200 platforms
> - get, prepare, and enable the MCLK during port allocation; disable,
>   unprepare and put the MCLK upon port release; hold a reference to the
>   clock over the period of use; check for and propagate enable errors
> - fix a buffer overflow for clock names with two digit PSC index numbers
> - stick with the PPC_CLOCK 'psc%d_mclk' name for clock lookup, only
>   switch to a fixed string later after device tree based clock lookup
>   will have become available
> 
> to achieve support for MPC512x which is neutral to MPC5200, the
> modification was done as follows
> - introduce "clock alloc" and "clock release" routines in addition to
>   the previous "clock enable/disable" routine in the psc_ops struct
> - make the clock allocation a part of the port request (resource
>   allocation), and make clock release a part of the port release, such
>   that essential resources get allocated early
> - just enable/disable the clock from within the .clock() callback
>   without any allocation or preparation as the former implementation
>   did, since this routine is called from within the startup and shutdown
>   callbacks
> - all of the above remains a NOP for the MPC5200 platform (no callbacks
>   are provided on that platform)
> - implementation note: the clock gets enabled upon allocation already
>   just in case the clock is not only required for bitrate generation but
>   for register access as well
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
