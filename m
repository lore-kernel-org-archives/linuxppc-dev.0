Return-Path: <pari@gdatech.com>
Received: from kings.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id D410367A6F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 13:33:20 +1000 (EST)
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id 0FA1161C0AA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 20:05:39 -0700 (PDT)
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay
	0.1.0.2229 $Rev$) id r544200539D-00-1
	for linuxppc-embedded@ozlabs.org; Mon, 04 Apr 2005 20:05:39 -0700
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id DE45761C0D0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 20:05:38 -0700 (PDT)
Received: from sierra.gdatech.com (localhost.localdomain [127.0.0.1])
	by gdatech.com (8.11.6/8.11.6) with SMTP id j35395t06994
	for <linuxppc-embedded@ozlabs.org>; Mon, 4 Apr 2005 20:09:05 -0700
From: "Pari Subramaniam" <pari@gdatech.com>
To: "'linux-ppc-embedded'" <linuxppc-embedded@ozlabs.org>
Date: Mon, 4 Apr 2005 20:14:50 -0700
Message-ID: <00e401c5398d$a0ea5190$acc8a8c0@PARI>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <b383dfd14d6dcc895297851a2424f319@freescale.com>
Subject: PPC linux v2.6.11 network configuration hangs
Reply-To: pari@gdatech.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

We have 8540 based board running PPC port ver-2.4.30-pre1. when I tried =
to
upgrade to ver-2.6.11, the network interface loops (enabled TSEC alone)
indefinitely in the gfar_probe() at the following while loop:


        /* Stop the DMA engine now, in case it was running before */
        /* (The firmware could have used it, and left it running). */
        /* To do this, we write Graceful Receive Stop and Graceful */
        /* Transmit Stop, and then wait until the corresponding bits */
        /* in IEVENT indicate the stops have completed. */

        tempval =3D gfar_read(&priv->regs->dmactrl);
        tempval &=3D ~(DMACTRL_GRS | DMACTRL_GTS);
        gfar_write(&priv->regs->dmactrl, tempval);

        tempval =3D gfar_read(&priv->regs->dmactrl);
        tempval |=3D (DMACTRL_GRS | DMACTRL_GTS);
        gfar_write(&priv->regs->dmactrl, tempval);
/*---------------------------------stays in this loop for
ever--------------------------------*/
        while (!(gfar_read(&priv->regs->ievent) & (IEVENT_GRSC | =
IEVENT_GTSC)))
                cpu_relax();
/*-----------------------------------------------------------------------=
-------
--------------*/

MPC8540 based system running boot loader U-Boot version-1.1.2. The TSEC =
port is
tested from the boot loader. The same behavior observed in all the =
boards.

I appreciate any help in this regard.

Thanks in advance

regards
-pari =20
