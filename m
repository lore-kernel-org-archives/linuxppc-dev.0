Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17724.15919.790114.628418@cargo.ozlabs.ibm.com>
Date: Mon, 23 Oct 2006 13:59:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] qe_ic: Do a sync when masking interrupts.
In-Reply-To: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
References: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> This patch causes a sync do be done after masking a QE interrupt, to
> ensure that the masking has completed before interrupts are enabled.
> This allows the masking of the cascade IRQ to be removed without causing
> spurious interrupts.

Hmmm.  In general a sync having completed doesn't mean that previous
MMIO stores have actually got to the device.  Reading from a device
register generally does ensure that previous writes have actually got
to the device though - could you do that instead?  I'm concerned that
adding the sync is not a robust fix and is possibly only working due
to fortuitous timing.

Paul.
