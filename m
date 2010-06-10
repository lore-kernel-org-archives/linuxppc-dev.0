Return-Path: <richardcochran@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 89E871007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 16:28:27 +1000 (EST)
Received: by fxm5 with SMTP id 5so1973970fxm.15
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jun 2010 23:28:24 -0700 (PDT)
Date: Thu, 10 Jun 2010 08:29:08 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Anton Vorontsov <avorontsov@mvista.com>
Subject: Re: [PATCH] gianfar: Revive the driver for eTSEC devices (disable
	timestamping)
Message-ID: <20100610062907.GA3390@riccoc20.at.omicron.at>
References: <20100609193219.GA8629@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100609193219.GA8629@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Manfred Rudigier <Manfred.Rudigier@omicron.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 11:32:19PM +0400, Anton Vorontsov wrote:
> Since commit cc772ab7cdcaa24d1fae332d92a1602788644f7a ("gianfar: Add
> hardware RX timestamping support"), the driver no longer works on
> at least MPC8313ERDB and MPC8568EMDS boards (and possibly much more
> boards as well).

What do you mean by, "no longer works?" The driver works fine for us,
even without TMR_CTRL[TE] set. We tested the driver on two MPC8313ERDB
REV C boards, one P2020DS, and one P2020RDB.

> That's how MPC8313 Reference Manual describes RCTRL_TS_ENABLE bit:
> 
>   Timestamp incoming packets as padding bytes. PAL field is set
>   to 8 if the PAL field is programmed to less than 8. Must be set
>   to zero if TMR_CTRL[TE]=0.
> 
> I see that the commit above sets this bit, but it doesn't handle
> TMR_CTRL. Manfred probably had this bit set by the firmware for
> his boards. But obviously this isn't true for all boards in the
> wild.

No, we did not set TMR_CTRL[TE].

For the Rx timestamps, we simply enabled them unconditionally. The
effect of not setting TMR_CTRL[TE] was that the timestamps were
invalid, but that should not matter if user space has not configured
the PTP clock. We left the TMR_CTRL[TE] bit for the PTP clock driver
(recently submitted and discussed on netdev). Actually, I copy the PTP
clock driver to the target via 'scp' during development, and I never
had any trouble.

> Also, I recall that Freescale BSPs were explicitly disabling the
> timestamping because of a performance drop.

The BSPs that we have, for the MPC8313ERDB and the P2020RBD both
include a (hacky) PTP timestmaping driver. Can you be more specific
about where and when Freescale is disabling timestamping?

> For now, the best way to deal with this is just disable the
> timestamping, and later we can discuss proper device tree bindings
> and implement enabling this feature via some property.

Okay, but now we want to identify what exactly works and what not. As
mentioned, we tested this driver on four different boards and did not
see any problems.

Thanks,
Richard
