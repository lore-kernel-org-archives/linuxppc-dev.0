Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd72d3r2PzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 21:06:33 +1000 (AEST)
Date: Wed, 31 May 2017 21:06:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next] powerpc: use asm-generic/socket.h as much as
 possible
Message-ID: <20170531210632.251822b4@canb.auug.org.au>
In-Reply-To: <878tld49ic.fsf@concordia.ellerman.id.au>
References: <20170531154337.04ebcb75@canb.auug.org.au>
 <878tld49ic.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, 31 May 2017 20:15:55 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > asm-generic/socket.h already has an exception for the differences that
> > powerpc needs, so just include it after defining the differences.
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/powerpc/include/uapi/asm/socket.h | 92 +---------------------------------
> >  1 file changed, 1 insertion(+), 91 deletions(-)
> >
> > Build tested using powerpc allyesconfig, pseries_le_defconfig, 32 bit
> > and 64 bit allnoconfig and ppc44x_defconfig builds.  
> 
> Did you boot it and test that userspace was happy doing sockety things?

No, sorry.

The patch was done by inspection, but it is pretty obvious ... here is
the diff between arch/powerpc/include/uapi/asm/socket.h and
include/uapi/asm-generic/socket.h before the patch:

--- arch/powerpc/include/uapi/asm/socket.h	2017-05-31 20:56:54.940473709 +1000
+++ include/uapi/asm-generic/socket.h	2017-05-31 10:04:16.716445463 +1000
@@ -1,12 +1,5 @@
-#ifndef _ASM_POWERPC_SOCKET_H
-#define _ASM_POWERPC_SOCKET_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
+#ifndef __ASM_GENERIC_SOCKET_H
+#define __ASM_GENERIC_SOCKET_H
 
 #include <asm/sockios.h>
 
@@ -30,12 +23,14 @@
 #define SO_LINGER	13
 #define SO_BSDCOMPAT	14
 #define SO_REUSEPORT	15
-#define SO_RCVLOWAT	16
-#define SO_SNDLOWAT	17
-#define SO_RCVTIMEO	18
-#define SO_SNDTIMEO	19
-#define SO_PASSCRED	20
-#define SO_PEERCRED	21
+#ifndef SO_PASSCRED /* powerpc only differs in these */
+#define SO_PASSCRED	16
+#define SO_PEERCRED	17
+#define SO_RCVLOWAT	18
+#define SO_SNDLOWAT	19
+#define SO_RCVTIMEO	20
+#define SO_SNDTIMEO	21
+#endif
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define SO_SECURITY_AUTHENTICATION		22
@@ -71,7 +66,7 @@
 #define SO_RXQ_OVFL             40
 
 #define SO_WIFI_STATUS		41
-#define SCM_WIFI_STATUS		SO_WIFI_STATUS
+#define SCM_WIFI_STATUS	SO_WIFI_STATUS
 #define SO_PEEK_OFF		42
 
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
@@ -107,4 +102,4 @@
 
 #define SCM_TIMESTAMPING_PKTINFO	58
 
-#endif	/* _ASM_POWERPC_SOCKET_H */
+#endif /* __ASM_GENERIC_SOCKET_H */

-- 
Cheers,
Stephen Rothwell
