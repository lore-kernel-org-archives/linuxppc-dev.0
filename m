Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE14BDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 08:08:43 +1000 (EST)
Date: Mon, 14 May 2007 15:08:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] pcmcia: ppc64 needs 64-bit ioaddr_t
Message-Id: <20070514150802.b9120e9f.akpm@linux-foundation.org>
In-Reply-To: <20070512143105.GA12890@lixom.net>
References: <20070512143105.GA12890@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org, paulus@samba.org,
	linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 12 May 2007 09:31:05 -0500
olof@lixom.net (Olof Johansson) wrote:

> ppc64 really needs ioaddr_t to be 64-bit, since I/O addresses really
> are MMIO addresses, and remapped to a high range.
> 
> While the type is exported to userspace, there hasn't been any platforms
> with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> any existing users.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Index: 2.6.21/include/pcmcia/cs_types.h
> ===================================================================
> --- 2.6.21.orig/include/pcmcia/cs_types.h
> +++ 2.6.21/include/pcmcia/cs_types.h
> @@ -21,12 +21,17 @@
>  #include <sys/types.h>
>  #endif
>  
> +#if defined(__powerpc64__)
> +/* I/O addresses are really MMIO addresses on PPC, and can thus be 64 bits */
> +typedef unsigned long ioaddr_t;
> +#else
>  #if defined(__arm__) || defined(__mips__)
>  /* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
>  typedef u_int   ioaddr_t;
>  #else
>  typedef u_short	ioaddr_t;
>  #endif
> +#endif
>  typedef unsigned long kio_addr_t;
>  
>  typedef u_short	socket_t;

Well that's some pretty sad code you've found there.  The kernel surely has
some appropriate type to use here without us having to invent a new one. 
But I suspect if we were to rationalise things in there it will get messy.

I think your patch can be cast more neatly if we use #elif:

--- a/include/pcmcia/cs_types.h~pcmcia-ppc64-needs-64-bit-ioaddr_t
+++ a/include/pcmcia/cs_types.h
@@ -21,12 +21,16 @@
 #include <sys/types.h>
 #endif
 
-#if defined(__arm__) || defined(__mips__)
+#if defined(__powerpc64__)
+/* I/O addresses are really MMIO addresses on PPC, and can thus be 64 bits */
+typedef unsigned long ioaddr_t;
+#elif defined(__arm__) || defined(__mips__)
 /* This (ioaddr_t) is exposed to userspace & hence cannot be changed. */
 typedef u_int   ioaddr_t;
 #else
 typedef u_short	ioaddr_t;
 #endif
+
 typedef unsigned long kio_addr_t;
 
 typedef u_short	socket_t;
_

Also, I wonder if `unsigned long' is the correct type to use here.  32-bit
userspace will treat it as 32-bit and 64-bit userspace will treat it as
64-bit.

Would it be better to use uint64_t here?
