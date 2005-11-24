Return-Path: <SRS0+1a4aa88343b650159535+823+infradead.org+dwmw2@baythorne.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132634960.26560.133.camel@gaston>
References: <1132634960.26560.133.camel@gaston>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 17:08:56 +0000
Message-Id: <1132852136.11921.85.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: serial port discovery
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-11-22 at 15:49 +1100, Benjamin Herrenschmidt wrote:
> This moves the discovery of legacy serial ports to a separate file,
> makes it common to ppc32 and ppc64, and reworks it to use the new OF
> address translators to get to the ports early. This new version can also
> detect some PCI serial cards using legacy chips and will probably match
> those discovered port with the default console choice.

This makes it deal with the fact that the Pegasos firmware reports that
its clock frequency is zero...

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 28ad50e..7a685ca 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -43,7 +43,10 @@ static int __init add_legacy_port(struct
 
 	/* get clock freq. if present */
 	clk = (u32 *)get_property(np, "clock-frequency", NULL);
-	clock = clk ? *clk : BASE_BAUD * 16;
+	if (clk && *clk)
+		clock = *clk;
+	else
+		clock = BASE_BAUD * 16;
 
 	/* get default speed if present */
 	spd = (u32 *)get_property(np, "current-speed", NULL);

-- 
dwmw2
