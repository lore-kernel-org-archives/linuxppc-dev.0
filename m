In-Reply-To: <Pine.LNX.4.60.0407131328290.19248@dell.enoriver.com>
References: <Pine.LNX.4.60.0407131328290.19248@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FDAC0433-D4FB-11D8-8CEC-003065F9B7DC@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: fix to enet.c to enable networking when booting from flash
Date: Tue, 13 Jul 2004 14:39:36 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 13, 2004, at 1:34 PM, Robert P. J. Day wrote:

> #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) ||
> defined(CONFIG_EP8xx) || defined(CONFIG_EP852)
>         /* And while we are here, set the configuration to enable
> ethernet.
>         */
>         *((volatile uint *)RPX_CSR_ADDR) &= ~BCSR0_ETHLPBK;
>         *((volatile uint *)RPX_CSR_ADDR) |=
>              (BCSR0_ETHEN | BCSR0_COLTESTDIS | BCSR0_FULLDPLXDIS);
>>        *((volatile uint *)RPX_CSR_ADDR) |=0x00100000;  <-- add this
> //1:ethernet,0:SPI
> #endif

In newer drivers, this would be done in a board specific file.  As you
can tell, this code enables the Ethernet PHY.  I don't understand
why that extra 'add this' is necessary.  That does some PCMCIA signal
routing to IP_B5, which should not have any effect on the Ethernet.

What revision of board is this?  I have RPXLite's that I boot from
flash all of the time without trouble.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
