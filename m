Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 621602C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 05:52:10 +1000 (EST)
Date: Wed, 21 Aug 2013 21:52:04 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 02/31] serial: mpc512x: cleanup clock API use
Message-ID: <20130821215204.4e46d322@crub>
In-Reply-To: <1375821851-31609-3-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-3-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:42 +0200
Gerhard Sittig <gsi@denx.de> wrote:

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
> ---
>  drivers/tty/serial/mpc52xx_uart.c |   98 ++++++++++++++++++++++++++++++-------
>  1 file changed, 81 insertions(+), 17 deletions(-)

applied, thanks!

Anatolij
