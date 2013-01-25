Return-Path: <R.Patil@mei-india.com>
Received: from antispam.messung.com (outbond.messung.com [210.212.173.45])
 by ozlabs.org (Postfix) with ESMTP id 1F2782C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2013 15:41:18 +1100 (EST)
In-Reply-To: <OF36C99B74.048D73FE-ON65257AF5.004A3F3C-65257AF5.004A3F44@LocalDomain>
Subject: [Solved] SD Card over SPI, not working for MPC8313 
From: R.Patil@mei-india.com
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <OF2D2359FD.04E03771-ON65257AFE.0019BF2A-65257AFE.0019BF30@LocalDomain>
Date: Fri, 25 Jan 2013 10:11:13 +0530
Content-Type: text/plain;
	charset=ISO-8859-1
MIME-Version: 1.0
References: <OF36C99B74.048D73FE-ON65257AF5.004A3F3C-65257AF5.004A3F44@LocalDomain>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello All,

The problem has been resolved.

After some debugging, we observed that problem was in initialisation of 'fs=
l=5Fspi' driver. The 'fsl=5Fspi' driver extracts platform data from device =
tree. This platform data contains gpio number for chip-select control (cs=
=5Fcontrol). Since, MPC8313E platform doesn't support 'gpiolib', 'fsl=5Fspi=
' was unable to extract gpio number for chip-select control. This was forci=
ng it to work without chip-select line. So we did (dirty) work around to in=
itialise 'cs=5Fcontrol' field explicitly (in function 'of=5Ffsl=5Fspi=5Fget=
=5Fchipselects' defined in spi=5Ffsl=5Fspi.c) with our customised handler w=
hich toggles gpio controlling chip-select. This did the job and SD card is =
working fine now.

Still we have some questions just for understanding purpose. We alternately=
 tried to initialise spi platform data by old method i.e specifying it in '=
mpc831x=5Frdb.c' as it is done in 'mpc832x=5Frdb.c' but that didn't work. S=
o our first question is, does it work for MPC8323ERDB? And one more questio=
n is, does 'MPC8313ERDB' platform support 'gpiolib' driver available in mai=
nline kernel?
The answers might help us to clean our code and also to improve our underst=
anding.

Thanks and Regards,
Rahul Patil
=20
-----R Patil/SW HW Dev/Pune EL2/R N D/Messung wrote: -----

To: linuxppc-dev@lists.ozlabs.org
From: R Patil/SW HW Dev/Pune EL2/R N D/Messung
Date: 01/16/2013 07:00PM
Subject: SD Card over SPI, not working for MPC8313=20

 Hello,

We are working on board based on Freescale MPC8313ERDB. We have ported linu=
x 3.0.46 kernel on it. We have to use SD card over SPI. We are trying to us=
e 'mmc=5Fspi' driver for the same. We are able to detect SD card insertion =
by the interrupt (gpio interrupt is used to detect card insertion). But we =
are not able to initialise the card. Is the 'mmc=5Fspi' support for MPC8313=
ERDB broken?=20

If no, what could be the reason we are getting timeout error by function 'm=
mc=5Fspi=5Fresponse=5Fget()'? =20

If anybody could just give a hint to solve or debug the problem. =20

Thanks and Regards,
Rahul Patil



Email Disclaimer:
  ---------------------------

This e-mail and any files transmitted with it are for the sole use of the i=
ntended recipient(s) and may contain confidential and  privileged informati=
on. Computer viruses can be transmitted via email.The recipient should chec=
k this email and any  attachments for the presence of viruses. The company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.
