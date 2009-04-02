Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B7D7DDDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 15:08:06 +1100 (EST)
Date: Thu, 2 Apr 2009 00:08:03 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Problem with module_init?
Message-ID: <20090402000803.087600da@lappy.seanm.ca>
In-Reply-To: <1238624683.17330.138.camel@pasglop>
References: <20090331143742.083c6cb0@lappy.seanm.ca>
	<20090331231153.256d1bf4@lappy.seanm.ca>
	<20090401112756.GA14171@yoda.jdub.homelinux.org>
	<1238624683.17330.138.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 02 Apr 2009 09:24:43 +1100
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> I suspect I just screwed up the definition of PAGE_KERNEL_EXEC or
> something like that.

Yup, that is exactly what you did ;) You left out _PAGE_HWEXEC. The
following patch fixes the problem for me.

Cheers,
   Sean

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index d9740e8..a84f248 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -167,7 +167,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 #endif
 
 /* Make modules code happy. We don't set RO yet */
-#define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+// #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
+#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_KERNEL_RW | _PAGE_EXEC | _PAGE_HWEXEC)
 
 /* Advertise special mapping type for AGP */
 #define PAGE_AGP		(PAGE_KERNEL_NC)
