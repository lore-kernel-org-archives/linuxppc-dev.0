Subject: Re: MTD Driver (denx Linux 2.4.4)
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Flavio Pereira <fpereira@azisa.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1E354700654661418593A0D6B5A9D410089481@mail.azisa.co.za>
References: <1E354700654661418593A0D6B5A9D410089481@mail.azisa.co.za>
Date: 31 Oct 2002 10:25:01 -0600
Message-Id: <1036081502.1013.1299.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2002-10-31 at 08:37, Flavio Pereira wrote:
>
> I'm having difficulty in getting the MTD driver working. I'm using a
> non-CFI complaint Sharp chip so I have defined CONFIG_MTD_SHARP. However
> I cannot locate anywhere in the code where the kernel will call
> sharp_probe_init. In any case I forced init_mtd (mtdcore.c) to call
> sharp_probe_init and it seems to load the driver okay as I see the
> following on my serial console
>
> JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
> JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis
> Communications AB.
> MTD Sharp chip driver <ds@lineo.com>
> MTD Sharp chip driver <ds@lineo.com>
>
> Now my question is, do I need to force this driver to load or am I
> missing some compile flag? How do I go about partitioning the flash, ie
> how does this driver link to a flash map?

Those "MTD" lines above, does that mean your driver is being initialized
twice?

Linux uses ELF tricks for initialization: addresses of all the functions
marked __init are put into their own ELF section, and common code
somewhere (I forget where) just loops over this section, calling each
init function in turn. So you should *not* add an explicit call to your
init routine.

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
