Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 932FC685DC
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Oct 2005 04:51:34 +1000 (EST)
Received: from logos.cnet (localhost [127.0.0.1])
	by hera.kernel.org (8.13.1/8.13.1) with ESMTP id j9QIea56016416
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Oct 2005 11:40:36 -0700
Date: Wed, 26 Oct 2005 11:36:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <20051026133648.GA10373@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Makefile check for older binutils broken?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

While trying to compile 2.6.14-rc4 on my Pegasos (running Debian unstable):

make[2]: Entering directory `/home/marcelo/8xx/linux-2.6.14-rc4'
*** 2.6 kernels no longer build correctly with old versions of binutils.
*** Please upgrade your binutils to 2.12.1 or newer
make[2]: *** [checkbin] Error 1

Even though Debian uses a recent version of binutils:

GNU assembler 2.16.1 Debian GNU/Linux
Copyright 2005 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
This assembler was configured for a target of `powerpc-linux-gnu'.

The return value of the verification command is 0:

marcelo@pegasos:~$ /bin/echo dssall | as -many -o /tmp/output.as >/dev/null 2>&1
marcelo@pegasos:~$ echo $?
0

So somehow the verification inside the Makefile fails (maybe a make or shell 
bug? not sure).

Anyway, surrounding the verification command around an eval expression
does the trick correcting the situation. Is it any good? 

I'm not sure what to expect from older binutils versions as I don't have
any around at the moment for testing.

diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 0432a25..cdd9250 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -126,7 +126,7 @@ checkbin:
 			false; \
 		fi ; \
 	fi
-	@if ! /bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1 ; then \
+	@if ! [[ "/bin/echo dssall | $(AS) -many -o $(TOUT) >/dev/null 2>&1" ]] ; then \
 		echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build ' ; \
 		echo 'correctly with old versions of binutils.' ; \
 		echo '*** Please upgrade your binutils to 2.12.1 or newer' ; \
