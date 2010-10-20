Return-Path: <shawnxjin@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 36BEBB70AF
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 18:03:49 +1100 (EST)
Received: by eya25 with SMTP id 25so512668eya.15
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 00:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBCFC5D.3010403@windriver.com>
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
	<4CBC080A.7030005@windriver.com>
	<20101018114214.2e72a616@udp111988uds.am.freescale.net>
	<4CBCFC5D.3010403@windriver.com>
Date: Wed, 20 Oct 2010 00:03:47 -0700
Message-ID: <AANLkTinN-xOecVynPYxmLoT9HJKFs0iPo3pLXF05Tudv@mail.gmail.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
From: Shawn Jin <shawnxjin@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> On MPC8xx you want drivers/net/fs_enet/mii-fec.c. =A0This is just the
>> MDIO driver; it doesn't handle any particular PHY. =A0I don't know if
>> there is a driver specifically for AM79C874, though the generic PHY
>> support may be good enough.
>
> Maybe.
>
> I can found one related patch for supporting PHY AM79C874 on 2.6.15,
> ------
> http://lists.ozlabs.org/pipermail/linuxppc-embedded/2005-November/021043.=
html
>
> But I don't see that on the latest kernel, and also I don't know the hist=
ory
> completely for that. Maybe its already merged into one generic PHY driver=
 but
> I'm not sure.

Thank Scott & Tiejun for valuable information.

The problem for me is that the PHY failed to be probed. The related
error messages are shown below. I even tried the patch Tiejun pointed
out. But that doesn't help. The phy ID read from the bus was all Fs.

FEC MII Bus: probed
mdio_bus fa200e00: error probing PHY at address 0

I don't know if AM79C874 requires any special handling. But from the
comment in mdiobb_cmd() there seems to be something special.
        /*
         * Send a 32 bit preamble ('1's) with an extra '1' bit for good
         * measure.  The IEEE spec says this is a PHY optional
         * requirement.  The AMD 79C874 requires one after power up and
         * one after a MII communications error.  This means that we are
         * doing more preambles than we need, but it is safer and will be
         * much more robust.
         */

If there is any network action in u-boot, e.g., tftp or ping, the PHY
can be successfully probed after that. Any hints what went wrong with
the PHY?

Thanks,
-Shawn.
