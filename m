Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth01.prod.mesa1.secureserver.net
	(smtpauth01.prod.mesa1.secureserver.net [64.202.165.181])
	by ozlabs.org (Postfix) with SMTP id 4F1B8DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Dec 2007 19:03:57 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.715.1198212922.17691.linuxppc-embedded@ozlabs.org>
Subject: MPC83xx - 2.6.23, UCC_GETH and NFS Boot
Date: Fri, 21 Dec 2007 00:03:30 -0800
Message-ID: <001801c843a7$fa2afda0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.715.1198212922.17691.linuxppc-embedded@ozlabs.org>
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I am attempting to get a new board booted up using NFS root file system.
HW: Board based lightly on the MPC8360E_MDS

I have the kernel 2.6.23-dirty configured to use the Freescale QE driver.
I am using U-boot 1.3.0 and am able to use the Ethernet there, so I know it
is up.

I am using the following bootargs from U-boot.

bootargs=console=ttyS0,115200 root=/dev/nfs rw
nfsroot=192.168.5.205:/usr/local/eldk/ppc_6xx
ip=192.168.5.50:192.168.5.205:192.168.5.1::MIB305_50::off

I can see during initial kernel load up that it loads:
"ucc_geth: QE UCC Gigabit Ethernet Controller"

However, later IP-Config claims there is no valid Ethernet device
registered.

Is there something I have to do specify what type of PHY device I am using? 
Perhaps a National DP8365 is not supported yet? Or perhaps the MDIO driver
in linux is not looking at the correct MDIO address?

In U-boot I am using PHY addr 0x01, could this present a problem?


-Russ
