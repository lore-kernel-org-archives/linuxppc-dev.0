Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 873072C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 13:52:47 +1100 (EST)
Date: Wed, 4 Dec 2013 16:55:21 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as well
Message-ID: <20131205005521.GA21377@kroah.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-11-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385851897-23475-11-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 30, 2013 at 11:51:30PM +0100, Gerhard Sittig wrote:
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

That's fine, my ACK still stands.

thanks,

greg k-h
