Message-ID: <410933A0.8090008@mvista.com>
Date: Thu, 29 Jul 2004 10:28:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dieu Morales <dieumorales@yahoo.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Michael Morales <michael.morales@lmco.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
Subject: Re: GT64260_eth (Ethernet) Driver
References: <20040729031902.69389.qmail@web60408.mail.yahoo.com>
In-Reply-To: <20040729031902.69389.qmail@web60408.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dieu Morales wrote:

>All,
>I have had some success with making the gt64260_eth.c
>driver from the 2.4.26 dev tree work with the 2.6.7
>kernel.  I am able to see the ARP request and response
>messages via a network analyzer. However, the response
>messages appear not to generate an interrupt and I
>eventually timeout when mounting an NFS file system.
>My hardware maps a multi purpose pin from the
>Discovery 64260 to a cascaded pair of i8259's for all
>Ethernet and serial interrupts.  It is mapped to IRQ
>15 using INT E which is initialized by my ppcboot
>bootloader using the pciWriteConfigRegByte function.
>Also, I receive interrupts fine for the keyboard and
>mouse, so I feel all is OK with the i8259 driver
>etc... I do not have a 64260 dev manual so I am
>unclear if there is any special software
>initialization needed for my configuration that must
>take place in gt64260_eth.c or ev64260_setup.c or if I
>am simply overlook something .   A few areas of
>interest were:
>
>In gt64260_eth.c
>
>/*
> * enable relevant interrupts on GT
>*/
>gt_write(GT64260_ENET_E0IMR + gap, 0xb0ff010d);
>
>In ev64260_setup.c.
>
>/* Set MPSC Multiplex RMII */
>/* NOTE: ethernet driver modifies bit 0 and 1 */
>gt_write(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
>0x00001102);
>
>Any insight is always appreciated.
>
>

You have some very bizarre hardware.  Did your hardware guys *really*
put a pair of 8259's between the intr cltr on the hostbridge and the
processor???

Anyway, I perused the manual just in case but I don't see any way that
you can route enet/mpsc/sdma interrupts out MPP/GPP pins.  I could be wrong.

So, if you can actually convince the 64260 to route enet/mpsc/sdma intr
out that pin, you'll have to request the proper irq in your driver.
 From your description, it sounds like 15.  And, yes, you will have to
configure things in the 64260 to set up the routing and edge/level
sensitivity.

You will need a manual.  There's almost no hope without out one.  That
probably means signing an NDA with Marvell.

Let me know if you get it to work.  I'll be impressed, not to mention
surprised...

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
