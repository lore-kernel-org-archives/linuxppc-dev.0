Message-ID: <395A8A30.5D99549A@m2tech.co.nz>
Date: Thu, 29 Jun 2000 11:28:48 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: Wentao Xu <xuwentao@yahoo.com>
CC: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: why open("dev/console",O_RDWR,0) get stuck
References: <20000627095430.17482.qmail@web2105.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wentao Xu wrote:

> I have the code from Monta Vista on my prietary board,
> I find
> it get stuck in the open("dev/console",..) in fucntion
> init()
> in init/main.c, just before to start the shell from
> ramdisk.
> So I put a printk("ppc405_uic_enable\n") in function
> ppc405_uic_enable()
> and a printk("ppc405_uic_disable_and_ack\n") in
> function ppc405_uic_disable_and_ack().
> both functions are in file
> arch\ppc\kernel\ppc4xx_pic.c.
>
> At last I found a output of infinite train of
> ppc405_uic_enable
> ppc405_uic_disable_and_ack
> ppc405_uic_enable
> ppc405_uic_disable_and_ack
> ppc405_uic_enable
> ppc405_uic_disable_and_ack
> ppc405_uic_enable
> ppc405_uic_disable_and_ack
> ........,
>
>

this is occuring because you have not set the polarity/level of the interrupt
pin correctly.. you must set the DCRs, UICPR (defines the polarity of the
interrupt), and UICTR (which defines whether the pin is level or edge
triggered, this is for external interrupts)...

-----------
example: to set an external irq pin to positve, edge triggered:-

unsigned long uicpr, uictr;

uicpr = mfdcr(DCRN_UICPR);
uicpr |= 1 << (31 - IRQ_NO);
mtdcr(DCRN_UICPR, uicpr);
uictr = mfdcr(DCRN_UICTR);
uictr |= 1 << (31 - IRQ_NO);
mtdcr(DCRN_UICTR, uictr);
----------

whats happening is the interrupt is going off constantly, as the pins default
to negative, level triggering... see ibm stb guide chapter 6 for more info..

cheers,

ben

--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
