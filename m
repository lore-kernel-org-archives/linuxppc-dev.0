Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807151925p3abed71td0add06f7e3a1a80@mail.gmail.com>
Date: Tue, 15 Jul 2008 22:25:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linux-ppc list" <Linuxppc-dev@ozlabs.org>
Subject: mpc5200 and fsl_soc.c
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

Now that the i2c code in fsl_soc.c has migrated, I tried building my
mpc5200 system without including fsl_soc.c and everything built
without problem. Is there anything else in this file necessary for a
mpc5200 build? Some option I don't have turned on in my build?

I've noticed that several of the functions in this file aren't
properly ifdef'd. For example I think the gianfar driver is getting
built into mpc5200 kernels. Dropping the whole file from mpc5200
builds avoids the need to sort out the ifdef's.

diff --git a/arch/powerpc/platforms/52xx/Kconfig
b/arch/powerpc/platforms/52xx/Kconfig
index e91a0d2..76a3411 100644
--- a/arch/powerpc/platforms/52xx/Kconfig
+++ b/arch/powerpc/platforms/52xx/Kconfig
@@ -1,7 +1,6 @@
 config PPC_MPC52xx
        bool "52xx-based boards"
        depends on PPC_MULTIPLATFORM && PPC32
-       select FSL_SOC
        select PPC_CLOCK


-- 
Jon Smirl
jonsmirl@gmail.com
