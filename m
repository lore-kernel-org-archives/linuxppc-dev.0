Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth04.prod.mesa1.secureserver.net
	(smtpauth04.prod.mesa1.secureserver.net [64.202.165.95])
	by ozlabs.org (Postfix) with SMTP id 7538FDDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Dec 2007 11:52:17 +1100 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org>
Subject: 83xx, ELDK 2.6.23, IP-Config: No network devices
Date: Sun, 30 Dec 2007 16:51:44 -0800
Message-ID: <000001c84b47$50b0e2b0$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.1.1198890002.24584.linuxppc-embedded@ozlabs.org>
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
	
Attempting to get MPC8360 board booted into Linux using a NFS root fs.

I can see the kernel boots up, and registers both the MDIO driver and the
ucc_geth: driver, and with additional debug they encounter no errors.

However, for some reason the probe function never gets called for the MDIO
or the UCC driver. So as a result <assuming> the IP layer never gets a
network device. I am using a National DP83865 PHY device connected directly
to the 83xx QE. I don't see any direct definition for this PHY device, but
it doesn't even look like it queries the ID.

So two questions:

1) Is there some basic kernel feature I am missing? I have enabled the GIGE
UEC GETH driver in the kernel.  Perhaps a PHY LIB? Isn't generic MII
supported by default?

2) Is there something in the startup board files, that I need to add to
register my PHY like an of_put_node()? Again I have pretty much copied the
MPC8360E MDS board and it is starting, and defining the par_io port already,
except that my PHY ID <on the iC2 bus, is using dev ID 0x01>. However, I
don't see the probe function being called, so I don't think this is a
concern yet.

Anyway, how do I get the UEC_driver to see my phy device so I can get the
NFS to boot?

-Russ
