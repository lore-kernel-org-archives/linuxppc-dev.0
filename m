Date: Thu, 14 Feb 2002 17:47:37 +0100
From: Marius Groeger <mag@sysgo.de>
Message-Id: <200202141647.g1EGlbw11727@dagobert.svc.sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: serial ports on 8245
In-Reply-To: <a05101404b891963659eb@[10.8.16.89]>
References: <a05101404b891963659eb@[10.8.16.89]>
Reply-To: mag@sysgo.de
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In linux.ppc.embedded, you wrote:
>
> >mpc10x_bridge_init() is always called before $(PLATFORM)_map_io()
>
> No -- it's the other way around. Mapping IO is very early.

Sorry, you're right.

Regarding the serial driver initialization: the serial driver actually
provides a way to initialize the serial ports at run-time:

---------------------------------------------------------------
/*
 * This is for use by architectures that know their serial console
 * attributes only at run time. Not to be invoked after rs_init().
 */
int __init early_serial_setup(struct serial_struct *req) {...}
---------------------------------------------------------------

This could be used to register the duarts with a dynamically calculated
(ioremap()'ed) iomem_base, which probably only leaves ppc_md.progress() to
deal with.

--
Regards,
Marius.

--
Marius Groeger        SYSGO Real-Time Solutions GmbH    www.sysgo.de
Software Engineering  Embedded and Real-Time Software   www.osek.de
mgroeger @ sysgo de   Germany                           www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
