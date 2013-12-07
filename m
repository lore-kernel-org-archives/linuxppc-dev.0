Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D89322C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:51:32 +1100 (EST)
Date: Sat, 7 Dec 2013 10:51:28 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as well
Message-ID: <20131207105128.68d1f2ba@crub>
In-Reply-To: <1385851897-23475-11-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-11-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:30 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> prepare and enable the FIFO clock upon PSC FIFO initialization,
> check for and propagage errors when enabling the PSC FIFO clock,
> disable and unprepare the FIFO clock upon PSC FIFO uninitialization
> 
> devm_{get,put}_clk() doesn't apply here, as the SoC provides a
> single FIFO component which is shared among several PSC components,
> thus the FIFO isn't associated with a device (while the PSCs are)
> 
> provide a fallback clock lookup approach in case the OF based clock
> lookup for the PSC FIFO fails, this allows for successful operation in
> the presence of an outdated device tree which lacks clock specs
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the addition since v4 is the clk_get_sys() call for the 'ipg'
> clock item (backwards compat for device trees w/o clock specs)
> 
> ---
>  drivers/tty/serial/mpc52xx_uart.c |   50 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 6 deletions(-)

applied to next. Thanks!

Anatolij
