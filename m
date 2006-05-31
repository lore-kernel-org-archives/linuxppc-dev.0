Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FDE367B19
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 03:12:49 +1000 (EST)
Message-ID: <447DC91D.8010508@zytor.com>
Date: Wed, 31 May 2006 09:49:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Nathan Pilatzke <nathanpilatzke@gmail.com>
Subject: Re: >=2.6.17-rc4-mm1 kernel compilation problem (relocation truncated
	to fit)
References: <447DAAE4.7010503@gmail.com>
In-Reply-To: <447DAAE4.7010503@gmail.com>
Content-Type: multipart/mixed; boundary="------------040109050202010709050600"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040109050202010709050600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nathan Pilatzke wrote:
> I am getting compilation errors for 2.6.17-rc5-mm1 all the way back to
> 2.6.17-rc4-mm1.  Kernel 2.6.17-rc3-mm1 compiles better for me (I get the
> undefined reference to __udivdi3 error that has been reported
> previously).  Here are the errors that I get for 2.6.17-rc5-mm1:
> 

Could you try the following patch?

	-hpa

--------------040109050202010709050600
Content-Type: text/plain;
 name="ppc32.so.address"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32.so.address"

diff --git a/usr/klibc/arch/ppc/MCONFIG b/usr/klibc/arch/ppc/MCONFIG
index 8b51e65..e101453 100644
--- a/usr/klibc/arch/ppc/MCONFIG
+++ b/usr/klibc/arch/ppc/MCONFIG
@@ -13,9 +13,9 @@ KLIBCBITSIZE  = 32
 # Extra linkflags when building the shared version of the library
 # This address needs to be reachable using normal inter-module
 # calls, and work on the memory models for this architecture
-# 256-16 MB - normal binaries start at 256 MB, and jumps are limited
+# 256-8 MB - normal binaries start at 256 MB, and jumps are limited
 # to +/- 16 MB
-KLIBCSHAREDFLAGS     = -Ttext 0x0f000200
+KLIBCSHAREDFLAGS     = -Ttext 0x0f800200
 
 # The kernel so far has both asm-ppc* and asm-powerpc.
 KLIBCARCHINCFLAGS = -I$(KLIBCKERNELOBJ)arch/$(KLIBCARCH)/include

--------------040109050202010709050600--
