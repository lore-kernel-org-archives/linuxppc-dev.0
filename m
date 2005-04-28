Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 9DD2E67A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 04:50:29 +1000 (EST)
Message-ID: <42713071.9010803@timesys.com>
Date: Thu, 28 Apr 2005 14:50:25 -0400
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: Chiradeep Vittal <chiradeep@matissenetworks.com>
References: <F237EFC9919B064C8BF5A44CDA5DA0C212F681@matisse01.matissenetworks.com>
In-Reply-To: <F237EFC9919B064C8BF5A44CDA5DA0C212F681@matisse01.matissenetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chiradeep Vittal wrote:

>It turns out to be a compiler issue.
>We're using gcc 3.4.3 with optimization level -Os. The following program will generate the illegal instruction with -Os but not with -O2
>	int main (int argc, char** argv)
>	{	
>	  int seq[] = {0, 1, 2};
>	  return 0;
>	}
>The reason is that the compiler generates code with the stswi instruction which is not supported by the e500. Here's our compiler configuration:
>Configured with: /home/steve/perforce/sw/opt/crosstool/build/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/gcc-3.4.3/configure --target=powerpc-8540-linux-gnu --host=i686-host_pc-linux-gnu --prefix=/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2 --with-cpu=8540 --enable-cxx-flags=-mcpu=8540 --with-headers=/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu/include --with-local-prefix=/home/steve/perforce/sw/opt/cross-compile/powerpc-8540-linux-gnu/gcc-3.4.3-glibc-2.3.2/powerpc-8540-linux-gnu --disable-nls --enable-threads=posix --enable-symvers=gnu --enable-__cxa_atexit --enable-languages=c,c++ --enable-shared --enable-c99 --enable-long-long
>
>Any recommendations?
>  
>
Here's the patch we use to get GCC to stop generating the invalid 
intructions.

Greg Weeks


--- gcc-orig/gcc/config/rs6000/rs6000.h    2003-12-08 20:57:45.000000000 
-0500
+++ gcc-new/gcc/config/rs6000/rs6000.h    2004-09-15 14:23:36.680978222 
-0400
@@ -550,10 +550,10 @@
 #define TARGET_LONG_DOUBLE_128 (rs6000_long_double_type_size == 128)
 #define TARGET_ALTIVEC_ABI rs6000_altivec_abi
 #define TARGET_ALTIVEC_VRSAVE rs6000_altivec_vrsave
+#define TARGET_E500 (rs6000_cpu == PROCESSOR_PPC8540)
 
 #define TARGET_SPE_ABI 0
 #define TARGET_SPE 0
-#define TARGET_E500 0
 #define TARGET_ISEL 0
 #define TARGET_FPRS 1
 
