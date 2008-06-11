Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806111405nc5b45fg33b5107927f8d5f1@mail.gmail.com>
Date: Wed, 11 Jun 2008 17:05:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linuxppc-dev list" <Linuxppc-dev@ozlabs.org>
Subject: mpc52xx_psc.h
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why was the fifo struct separated from the psc struct for the 5200?

I see comments like this now:
        /* On the 5200, fifo regs are immediately adjacent to the psc regs */
        mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);

Couldn't the fifo struct be a member at the end of the psc struct?

/* Structure of the hardware registers */
struct mpc52xx_psc {
	u8		mode;		/* PSC + 0x00 */
	u8		reserved0[3];
......
	u8		irmdr;		/* PSC + 0x50 */
	u8		reserved16[3];
	u8		irfdr;		/* PSC + 0x54 */
	u8		reserved17[3];
	struct mpc52xx_psc_fifo fifo; /* like this? */
};


-- 
Jon Smirl
jonsmirl@gmail.com
