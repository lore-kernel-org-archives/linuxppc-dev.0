Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9627F679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 04:24:52 +1100 (EST)
Message-Id: <200612051724.kB5HOijY005107@penguin.ncube.com>
To: Thomas Denzinger <t.denzinger@lesametric.de>
Subject: Re: AW: Re: Updating plb_temac to version 3.00.a on XILINX ml403
	board
In-reply-to: <14180968.30361165332648093.JavaMail.servlet@kundenserver> 
References: <14180968.30361165332648093.JavaMail.servlet@kundenserver>
Date: Tue, 05 Dec 2006 09:24:44 -0800
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Thank you Michael and also Ming for your help!

>I modified my design according Michael's files and compiled
>everything. But with my 2.4.20 MontaVista-Kernel and the XILINX
>BSP-software 'No PHY detected. Assuming a PHY at address 0.'
>errormessage is printed out and because of that a wrong speed (10Mbits)
>is set.
>I have to find out now why the PHY is not detected. I assume that only
>the GMII interface is used for that. Am I right?

I'm using MontaVista's 2.6.10 variant so I have no experience with
2.4.20, however the the Xilinx provided 2.6 code did not correctly talk
to the phy on the ml403 so at boot time it would try to negotiate the
speed and drop it to 100, then 10Mbit as you noted.  Fortunately the
Marvell phy on the ml403 negotiates fine on its own so I was able to
comment that code out.  Since in our real design we have a Broadcom
switch hooked up to the temacs' we don't actually care about dealing
with the phy.

This applies to the 2.6 Xilinx code, there may be some similarity in the
2.4 code.  The file .../drivers/net/xilinx_temac/adapter.c contains a
routine called set_mac_speed() which does much of its work #ifdefed to
XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT.  I moved the whole routine out
of the way and replaced it with hard-coded "lp->cur_speed = 1000;".
Your milage will obviously differ since you're running with 2.4 but this
may give you a hint as to where to start looking.

-michael
