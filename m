Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <200211251219.GAA14313@lists.linuxppc.org>
Date: Mon, 25 Nov 2002 20:25:32 +0800
From: "Li Xiangrong" <lixiangrong@china.com>
To: "wd@denx.de" <wd@denx.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem about mac address 
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Mr. Denk,
I am now using the PPCBOOT in my system. I boot my board(mpc860t) by ppcboot and then port the hardhat linux. However, i got a problem with the mac address. I have set the mac address(CONFIG_ETHADDR 00:10:EC:00:23:20) in ppcboot. It's okay in ppcboot, but when the kernel boots up i find the kernel config the mac of eth0 (08:00:3e:26:15:59).That means the parameters of mac have not been transfered to kernel.However, the other paras, such as ip addr., host addr., netmask and such other is the same that i configured.I searched the kernel and have not find the place to set that addr. The kernel gets the mac addr. from and only from the SDRAM(enet.c):

				mcptr = (u_char *)dmi->dmi_addr + 5;
				tdptr = (u_char *)&ep->sen_taddrh;
				for (j=0; j<6; j++)
					*tdptr++ = *mcptr--;

The samethig happened with the fec mac. I read the fec.c and noticed that we use a random mac address tmpaddr[6], but the kernel config the fec mac of (08:00:be:26:15:59). The issue results that i can debug and test only one board in my group. How does this happen and may u give me an advice to solve it?
I really appreciat ur help


Best regards.

Li Xiangrong
lixiangrong@china.com
2002-11-25

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
