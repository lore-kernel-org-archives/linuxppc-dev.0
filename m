Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEE5F2C0100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 10:44:43 +1000 (EST)
Message-ID: <1376959471.31636.395.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Stephen N Chivers <schivers@csc.com.au>
Date: Mon, 19 Aug 2013 19:44:31 -0500
In-Reply-To: <OFE77F59FB.5CB18F2A-ONCA257BCB.007040E3-CA257BCB.00733D8F@csc.com>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
 <1375985244.4514.21.camel@snotra.buserror.net>
 <OF23301F36.A839CDA8-ONCA257BC5.0073F671-CA257BC5.00789A7F@csc.com>
 <1376345070.20487.41.camel@snotra.buserror.net>
 <OFE77F59FB.5CB18F2A-ONCA257BCB.007040E3-CA257BCB.00733D8F@csc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Chris Proctor <cproctor@csc.com.au>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 07:58 +1100, Stephen N Chivers wrote:
> The serial console setup in 'legacy_serial' does not support reg-shift
> or reg-offset properties and so a preferred_console is not added by it.
> The DTS file for the board does specify the register shift so that
> 'of_serial' will correctly setup the UARTS. But that is too late, the
> preferred console will be tty0 as the .config derived from 
> ppc6xx_defconfig
> has CONF_VT_CONSOLE set. In the test kernels I have built 'con_init' in
> the VT support is always called before serial8250_console_init.

Are you setting console=ttyS0,<baud> on the kernel command line?

> I did try modifying legacy_serial to correctly support the tsi-bridge
> UARTS and add the preferred console but encountered even more problems
> in 8250_core when registering the serial console (to the point of
> having a silently panic'ing kernel).
> 
> So I think for the moment, the board will need its own default config.

Which config symbol is relevant here?

-Scott
