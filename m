Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53CA268747
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 08:02:32 +1100 (EST)
Date: Mon, 14 Nov 2005 13:53:13 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <20051114155313.GA29411@logos.cnet>
References: <20051114152024.GA29314@logos.cnet>
	<5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [Edson.Seabra@cyclades.com: Re: BDI and 85xx]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 14, 2005 at 02:45:46PM -0600, Kumar Gala wrote:
> It doesn't look very good since nothing appears to be attached :)

Doh my bad. Attached it is.



--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8xx_gdb.diff"

--- /opt/montavista/pro/devkit/lsp/linux-2.6.14/Makefile	2005-10-27 17:02:08.000000000 -0700
+++ Makefile	2005-11-10 11:32:10.000000000 -0800
@@ -524,7 +524,7 @@
 endif
 
 ifdef CONFIG_DEBUG_INFO
-CFLAGS		+= -g
+CFLAGS		+= -g -ggdb
 endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
--- /opt/montavista/pro/devkit/lsp/linux-2.6.14/include/asm-ppc/reg.h	2005-10-27 17:02:08.000000000 -0700
+++ include/asm-ppc/reg.h	2005-11-10 11:32:10.000000000 -0800
@@ -49,8 +49,12 @@
 #endif
 
 #ifndef MSR_KERNEL
+#ifdef CONFIG_BDI_SWITCH
+#define MSR_KERNEL	(MSR_DE|MSR_ME|MSR_RI|MSR_IR|MSR_DR)
+#else
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
 #endif
+#endif
 
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 

--SUOF0GtieIMvvwua--
