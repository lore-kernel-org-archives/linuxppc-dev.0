Return-Path: <olof@lixom.net>
Date: Wed, 29 Aug 2007 17:52:10 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@ozlabs.org
Subject: Re: [PATCH] Move serial_dev_init to device_initcall()
Message-ID: <20070829225210.GA5891@lixom.net>
References: <20070823002637.GA24332@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070823002637.GA24332@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 07:26:37PM -0500, Olof Johansson wrote:
> With the I/O space rewrite by BenH, the legacy_serial serial_dev_init()
> initcall is now called before I/O space is setup, but it's dependent on
> it being available.
> 
> Since there's no way to make dependencies between initcalls, we'll just
> have to move it to device_initcall(). Yes, it's suboptimal but I'm not
> aware of any better solution at this time.

Paul, could we get this into 2.6.23? It's a regression from before.

Andy Fleming reported no problems on the MMIO-based UART board he tested
with, and Milton said the patch didn't break qemu/prep that has PIO UART
(he hasn't yet tested to see if it's really required there though).


-Olof
