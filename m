Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C287E1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:26:22 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Brian Norris <computersforpeace@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Michal Marek <mmarek@suse.com>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
Date: Thu, 07 Jan 2016 21:25:51 +0100
Message-ID: <10821353.mAlCTdTQBC@wuerfel>
In-Reply-To: <20160107185406.GA65420@google.com>
References: <20160107185406.GA65420@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 07 January 2016 10:54:06 Brian Norris wrote:
> 
> I'm using a GCC 4.6.3 compiler for some compile tests, and I noticed
> that commit 2cd55c68c0a4 ("cxl: Fix build failure due to -Wunused-variable
> behaviour change") breaks my builds, because the
> -Wno-unused-const-variable doesn't exist on GCC 4.6.3.
> 
>   drivers/misc/cxl/base.c: At top level:
>   cc1: error: unrecognized command line option "-Wno-unused-const-variable" [-Werror]
> 
> Any thoughts on how to best fix this? I'd like not to have to scrounge
> up a new cross compiler just for build tests.
> 

This should do:

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 6982f603fadc..add2cc17ed91 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Werror -Wno-unused-const-variable
+ccflags-y := -Werror $(call cc-disable-warning,unused-const-variable)
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o


Alternatively, remove the -Werror. We occasionally get people that add this
flag to a Makefile, but it tends to cause more trouble whenever a new
gcc version arrives.

	Arnd
