To: "Li Xiangrong" <lixiangrong@china.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem about mac address 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Nov 2002 20:25:32 +0800."
             <20021125130931.B001542D98@denx.de>
Date: Mon, 25 Nov 2002 14:31:24 +0100
Message-Id: <20021125133129.46071C58BF@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021125130931.B001542D98@denx.de> you wrote:
>
> I am now using the PPCBOOT in my system. I boot my board(mpc860t) by ppcboot and then port the hardhat linux. However, i got a problem with the mac address. I have set the mac address(CONFIG_ETHADDR 00:10:EC:00:23:20) in ppcboot. It's okay in ppcboot, b
> ut when the kernel boots up i find the kernel config the mac of eth0 (08:00:3e:26:15:59).That means the parameters of mac have not been transfered to kernel.However, the other paras, such as ip addr., host addr., netmask and such other is the same that
> i configured.I searched the kernel and have not find the place to set that addr. The kernel gets the mac addr. from and only from the SDRAM(enet.c):

PPCBoot passes the MAC address as part of the bd_info structure.  The
Linux  kernel  must  pick it up there. Either you missed to adapt the
kernel header files so that your Linux kernel does not use  the  same
layout of bd_info as used by PPCBoot, or your kernel sources miss the
part that extracts the MAC address from the bd_info struct.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To be sure of hitting the target, shoot first and, whatever you  hit,
call it the target.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
