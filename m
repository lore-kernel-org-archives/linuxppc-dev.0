Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8DBFD67B74
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 06:57:48 +1000 (EST)
Date: Wed, 20 Sep 2006 13:58:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Message-ID: <20060920205833.GA24809@mag.az.mvista.com>
References: <17680.30367.157642.674242@cargo.ozlabs.ibm.com>
	<20060920012042.GA28489@mag.az.mvista.com>
	<20060920012843.GA29635@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060920012843.GA29635@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 06:28:43PM -0700, Mark A. Greer wrote:
> On Tue, Sep 19, 2006 at 06:20:42PM -0700, Mark A. Greer wrote:
> > Paul,
> > 
> > Regarding our earlier conversation about ft_translate_addr and
> ...
> 
> BTW, the only changes to your patch would be removing translate_addr from
> dt_ops in ops.h and removing the "dt_ops.translate_addr = NULL;" line
> in of.c.

FWIW, here is a patch to do this:

diff -u b/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
--- b/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -270,7 +270,6 @@
 	dt_ops.finddevice = of_finddevice;
 	dt_ops.getprop = of_getprop;
 	dt_ops.setprop = of_setprop;
-	dt_ops.translate_addr = NULL;
 
 	console_ops.open = of_console_open;
 	console_ops.write = of_console_write;
diff -u b/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
--- b/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -34,8 +34,6 @@
 			const int buflen);
 	int	(*setprop)(const void *node, const char *name,
 			const void *buf, const int buflen);
-	u64	(*translate_addr)(const char *path, const u32 *in_addr,
-			const u32 addr_len);
 	unsigned long (*ft_addr)(void);
 };
 extern struct dt_ops dt_ops;
