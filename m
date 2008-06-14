Return-Path: <witcher@mindspring.com>
Received: from elasmtp-dupuy.atl.sa.earthlink.net
	(elasmtp-dupuy.atl.sa.earthlink.net [209.86.89.62])
	by ozlabs.org (Postfix) with ESMTP id E215CDDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 10:52:20 +1000 (EST)
Received: from [209.86.224.29] (helo=mswamui-cedar.atl.sa.earthlink.net)
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <witcher@mindspring.com>) id 1K7K0A-0004SN-Ny
	for linuxppc-dev@ozlabs.org; Fri, 13 Jun 2008 20:52:18 -0400
Message-ID: <19479935.1213404738653.JavaMail.root@mswamui-cedar.atl.sa.earthlink.net>
Date: Fri, 13 Jun 2008 20:52:18 -0400 (GMT-04:00)
From: Eric Witcher <witcher@mindspring.com>
To: linuxppc-dev@ozlabs.org
Subject: Question regarding mpic_assign_isu() in storcenter.c
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Eric Witcher <witcher@mindspring.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Can anyone explain why the comment preceding mpic_assign_isu() on line 145 says that the I2C registers are at 0x11020 yet the code on line 146 shows 0x11000?

The MPC8245 user manual shows the external interrupt 0 registers at 0x10200 (paddr=40000) and the I2C registers at 0x11020.


<from storcenter.c> <2.6.25.6>

/*
 112 * Interrupt setup and service.  Interrrupts on the turbostation come
 113 * from the four PCI slots plus onboard 8241 devices: I2C, DUART.
 114 */
 115static void __init storcenter_init_IRQ(void)
 116{
 117        struct mpic *mpic;
 118        struct device_node *dnp;
 119        const void *prop;
 120        int size;
 121        phys_addr_t paddr;
 122
 123        dnp = of_find_node_by_type(NULL, "open-pic");
 124        if (dnp == NULL)
 125                return;
 126
 127        prop = of_get_property(dnp, "reg", &size);
 128        if (prop == NULL) {
 129                of_node_put(dnp);
 130                return;
 131        }
 132
 133        paddr = (phys_addr_t)of_translate_address(dnp, prop);
 134        mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
 135                        16, 32, " OpenPIC  ");
 136
 137        of_node_put(dnp);
 138
 139        BUG_ON(mpic == NULL);
 140
 141        /*
 142         * 16 Serial Interrupts followed by 16 Internal Interrupts.
 143         * I2C is the second internal, so it is at 17, 0x11020.
 144         */
 145        mpic_assign_isu(mpic, 0, paddr + 0x10200);
 146        mpic_assign_isu(mpic, 1, paddr + 0x11000);
 147
 148        mpic_init(mpic);
 149}
