Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 25 Nov 2002 16:12:40 -0700
From: Matt Porter <porter@cox.net>
To: "Montgomery, Tim" <timm@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC RTC on I2C
Message-ID: <20021125161239.A20831@home.com>
References: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9102D41F595D311ACA7009027DE2C84033FFE27@c3po.heurikon.com>; from timm@artesyncp.com on Mon, Nov 25, 2002 at 04:13:17PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 25, 2002 at 04:13:17PM -0600, Montgomery, Tim wrote:
>
> Hey all,
>
> I'm working on getting i2c support working on a module that has its
> RTC on i2c.
>
> I've got my i2c client written, but i2c-core and friends don't load
> until very late in the game; setting ppc_md.get/set (at least in
> platform_init) is not very useful.
>
> Any thoughts on a graceful way to implement kernel RTC support using
> an i2c-based RTC (w/o bypassing the kernel's i2c layer)?

Hi Tim,

I always thought that one would implement some low-level ppc-specific
i2c master access functions.  These would be available via a few
ppc_mds and one could have a generic i2c 'adapter' to call the
functions.  For RTC access, one would then have a i2c RTC implementation
using these access functions rather than using the generic PPC RTC
device.  This does bypass the bloated i2c layer, however.  If done
properly, though, one could follow a similar strategy to that of
serial.c and with proper locking allow two paths to the hardware
registers.

One could modify the i2c layer to hook up early access of i2c master
devices.  This would be similar to the early initialization of 550
uarts that is available in that driver.  When the full driver is
initialized then accesses would occur in the normal manner.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
