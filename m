Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 0BA1367A6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 10:48:22 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 57so784894wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 15:48:20 -0800 (PST)
Message-ID: <528646bc05021515486bd9f926@mail.gmail.com>
Date: Tue, 15 Feb 2005 16:48:19 -0700
From: Grant Likely <glikely@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Lite5200 full duplex support
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using Sylvain's http://bkbits.246tnt.com:14690/linux-2.5-mpc52xx
bk tree on a lite5200 evb.  I noticed that the FEC driver is hard
coded to only support half duplex 10/100 auto-negotiation.  Is that
intentional?  Are there any known problems with running full duplex?

I modified the code to allow full duplex and I haven't observed any
problems yet.  (w/ nfsroot and compiling apps on the target natively)

Cheers,
g.

BTW, here's what I changed:
drivers/net/fec_mpc52xx/fec_phy.c line 294 (phy_info_lxt971)
from:
        { mk_mii_write(MII_REG_ANAR, 0x0A1), NULL }, /* 10/100, HD */
to:
        { mk_mii_write(MII_REG_ANAR, 0x1E1), NULL }, /* 10/100, HD */
