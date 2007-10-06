Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id CA8A4DDE9B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 06:06:52 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so702519uge
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Oct 2007 13:06:51 -0700 (PDT)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<20071004140126.99c0fab0.sfr@canb.auug.org.au>
	<17D08E8E-6ADC-4D61-8859-8329EDD4DC6D@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sat, 06 Oct 2007 22:06:40 +0200
In-Reply-To: <17D08E8E-6ADC-4D61-8859-8329EDD4DC6D@kernel.crashing.org> (Kumar
	Gala's message of "Fri\, 5 Oct 2007 09\:11\:12 -0500")
Message-ID: <87ejg8vwhb.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

 Kumar> On Oct 3, 2007, at 11:01 PM, Stephen Rothwell wrote:

 >> On Wed, 03 Oct 2007 17:43:50 +0200 Peter Korsgaard
 >> <jacmet@sunsite.dk> wrote:
 >>> 
 >>> @@ -1220,14 +1220,17 @@ int __init fsl_spi_init(struct
 >>> spi_board_info *board_infos,
 >>> {
 >>> struct device_node *np;
 >>> unsigned int i;
 >>> -	const u32 *sysclk;
 >>> +	const u32 *qe_sysclk = 0, *soc_sysclk = 0;
 >> 
 >> Please use NULL when referring to pointers.

 Kumar> Peter, any chance of getting a respin.  I'd like this to go
 Kumar> into 2.6.24.

Certainly. Sorry for the delay, I have been offline for 2 days
building my house ..
---
fsl_spi_init: Support non-QE processors

On non-QE processors (mpc831x/mpc834x) the SPI clock is the SoC clock.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/sysdev/fsl_soc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index be5e0bd..3ace747 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1222,8 +1222,12 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 	unsigned int i;
 	const u32 *sysclk;
 
+	/* SPI controller is either clocked from QE or SoC clock */
 	np = of_find_node_by_type(NULL, "qe");
 	if (!np)
+		np = of_find_node_by_type(NULL, "soc");
+
+	if (!np)
 		return -ENODEV;
 
 	sysclk = of_get_property(np, "bus-frequency", NULL);
-- 
1.5.3.2

-- 
Bye, Peter Korsgaard
