Message-ID: <20040729031902.69389.qmail@web60408.mail.yahoo.com>
Date: Wed, 28 Jul 2004 20:19:02 -0700 (PDT)
From: Dieu Morales <dieumorales@yahoo.com>
Subject: Re: GT64260_eth (Ethernet) Driver
To: "Mark A. Greer" <mgreer@mvista.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Morales <michael.morales@lmco.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Dieu Morales <dieumorales@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Brian Waite <waite@skycomputers.com>
In-Reply-To: <40DCD5C8.3080307@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,
I have had some success with making the gt64260_eth.c
driver from the 2.4.26 dev tree work with the 2.6.7
kernel.  I am able to see the ARP request and response
messages via a network analyzer. However, the response
messages appear not to generate an interrupt and I
eventually timeout when mounting an NFS file system.
My hardware maps a multi purpose pin from the
Discovery 64260 to a cascaded pair of i8259's for all
Ethernet and serial interrupts.  It is mapped to IRQ
15 using INT E which is initialized by my ppcboot
bootloader using the pciWriteConfigRegByte function.
Also, I receive interrupts fine for the keyboard and
mouse, so I feel all is OK with the i8259 driver
etc... I do not have a 64260 dev manual so I am
unclear if there is any special software
initialization needed for my configuration that must
take place in gt64260_eth.c or ev64260_setup.c or if I
am simply overlook something .   A few areas of
interest were:

In gt64260_eth.c

/*
 * enable relevant interrupts on GT
*/
gt_write(GT64260_ENET_E0IMR + gap, 0xb0ff010d);

In ev64260_setup.c.

/* Set MPSC Multiplex RMII */
/* NOTE: ethernet driver modifies bit 0 and 1 */
gt_write(GT64260_MPP_SERIAL_PORTS_MULTIPLEX,
0x00001102);

Any insight is always appreciated.

Thanks,
Michael Morales


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
