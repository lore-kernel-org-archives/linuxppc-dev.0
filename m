Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC8BD685C0
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Oct 2005 23:59:56 +1000 (EST)
Date: Fri, 28 Oct 2005 06:52:24 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20051028085224.GA17520@logos.cnet>
References: <20051026133648.GA10373@logos.cnet>
	<20051026220205.GH26475@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051026220205.GH26475@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Makefile check for older binutils broken?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 26, 2005 at 03:02:05PM -0700, Tom Rini wrote:
> On Wed, Oct 26, 2005 at 11:36:48AM -0200, Marcelo Tosatti wrote:
> > 
> > Hi,
> > 
> > While trying to compile 2.6.14-rc4 on my Pegasos (running Debian unstable):
> > 
> > make[2]: Entering directory `/home/marcelo/8xx/linux-2.6.14-rc4'
> > *** 2.6 kernels no longer build correctly with old versions of binutils.
> > *** Please upgrade your binutils to 2.12.1 or newer
> > make[2]: *** [checkbin] Error 1
> 
> What's your CONFIG_SHELL set to?

bash

> 
> [snip]
> > marcelo@pegasos:~$ /bin/echo dssall | as -many -o /tmp/output.as >/dev/null 2>&1
> > marcelo@pegasos:~$ echo $?
> 
> What about if you run the whole test on shell (if ...), does it work there? 
> What shell are you running?

Yep, that does the trick. Is it good now?


--- arch/ppc/Makefile.orig	2005-10-26 13:04:43.000000000 -0500
+++ arch/ppc/Makefile	2005-10-28 08:43:22.153202928 -0500
@@ -132,12 +132,12 @@
 			false; \
 		fi ; \
 	fi
-	@if ! [[ "/bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1" ]]; then \
+	@(if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then\
 		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
 		echo 'correctly with old versions of binutils.' ; \
 		echo '*** Please upgrade your binutils to 2.12.1 or newer' ; \
 		false ; \
-	fi
+	fi)
 
 CLEAN_FILES += $(TOUT)
 
