Message-ID: <39AFAD3C.C849E398@snmc.com>
Date: Fri, 01 Sep 2000 08:21:00 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cpm_enet_down and MAC address change.
References: <081f01c013db$364aa100$1952df8d@SOYANG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hyun-Joon,

I have been promising myself that I would re-work the ethernet driver
for use in QSLinux (qslinux.org), but have never gotten around to it.
The driver performs initialization in the init() function, rather than
the first call to open().  Another problem with the driver is that it
will only work with a single enet port.  I wanted to modify it so that
it would work with multiple ports.  A good example of how this can be
found is the HDLC driver (hdlcppp.c) from the QSLinux source.  This is
the source I will use (eventually) to rewrite the enet driver, as it
already has all of the buffer descriptor handling, and the open and
close handling setup correctly.  That driver allows you to open one or
more HDLC channels, and also allows you to close arbitrary channels.

Regards,
Daris

Hyun-Joon Cha wrote:
>
> Hello.
>
> In shell, I can't do down ethernet interface.
> ======================================
> # ifconfig eth0 down
> dev_close: bug eth0 still running
>
> I checked ethernet driver and found that there are empty code for it.
>
> At cpm_enet_close of arch/ppc/8xx_io/enet.c
> ===========================================
> static int
> cpm_enet_close(struct device *dev)
> {
>         /* Don't know what to do yet.
>         */
>
>         return 0;
> }
>
> So, I can't down ethernet interface on Linux for MPC850 and can't change MAC addr at runtime also.
>
> Then how can I make it possible? or do someone make module for ethernet and serial driver for MPC?
>
> Maybe it's a good idea to modularize it and make a configuration header file for parallel IO pins to SCCs and SMCs to port Linux easy.
>
> If anybody know it or have a idea please answer.
>
> Thanks in advance.
> Have a nice day.
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
