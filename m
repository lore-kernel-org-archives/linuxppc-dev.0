Return-Path: <SRS0+4a536cd6c556040094b6+800+infradead.org+dwmw2@pentafluge.srs.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 15:54:04 +0000
Message-Id: <1130860444.21212.52.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-10-31 at 15:23 +1100, Paul Mackerras wrote:
> It is now possible to build kernels for powermac, pSeries, iSeries and
> maple with ARCH=powerpc, and for powermac, both 32-bit and 64-bit
> build and run. 

Hm. Not entirely in line with my experience. Can you share the configs
you used?

Using http://david/woodhou.se/powerpc-merge-32.config it doesn't
actually boot on my powerbook. I'll try it on the Pegasos later or
tomorrow, where I have a serial console; it dies very early.

Aside from disabling CONFIG_NVRAM because call_rtas() isn't implemented
anywhere, I also needed to do this to make that config build:

--- linux-2.6.14/arch/powerpc/kernel/setup-common.c.orig	2005-11-01 10:14:32.000000000 +0000
+++ linux-2.6.14/arch/powerpc/kernel/setup-common.c	2005-11-01 10:15:03.000000000 +0000
@@ -203,11 +203,11 @@ static int show_cpuinfo(struct seq_file 
 #ifdef CONFIG_TAU_AVERAGE
 		/* more straightforward, but potentially misleading */
 		seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
-			   cpu_temp(i));
+			   cpu_temp(cpu_id));
 #else
 		/* show the actual temp sensor range */
 		u32 temp;
-		temp = cpu_temp_both(i);
+		temp = cpu_temp_both(cpu_id);
 		seq_printf(m, "temperature \t: %u-%u C (uncalibrated)\n",
 			   temp & 0xff, temp >> 16);
 #endif


-- 
dwmw2
