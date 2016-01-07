Return-Path: <computersforpeace@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B119E1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 07:38:43 +1100 (AEDT)
Received: by mail-pa0-x234.google.com with SMTP id uo6so248892419pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jan 2016 12:38:43 -0800 (PST)
Date: Thu, 7 Jan 2016 12:38:39 -0800
From: Brian Norris <computersforpeace@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Michal Marek <mmarek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] misc: cxl: fix build for GCC 4.6.x
Message-ID: <20160107203839.GA42481@google.com>
References: <20160107185406.GA65420@google.com>
 <1452195444.4028.21.camel@perches.com> <568EC026.2020207@suse.com>
 <1452196651.4028.31.camel@perches.com>
 <20160107201826.GA120952@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160107201826.GA120952@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC 4.6.3 does not support -Wno-unused-const-variable. Instead, use the
kbuild infrastructure that checks if this options exists.

Also drop -Werror, since it's harmful, if forced on the user. New GCC's,
or higher warning verbosities (e.g., W=1) can easily kill the build
where they shouldn't.

Suggested-by: Michal Marek <mmarek@suse.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---

On Thu, Jan 07, 2016 at 12:18:26PM -0800, Brian Norris wrote:
> On Thu, Jan 07, 2016 at 11:57:31AM -0800, Joe Perches wrote:
> > On Thu, 2016-01-07 at 20:44 +0100, Michal Marek wrote:
> > > We have cc-disable-warning for this.
> > 
> > Thanks Michal.
> 
> Cool, thanks! I'll send a patch to use that instead.

 drivers/misc/cxl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 6982f603fadc..0163d4d1fd1e 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Werror -Wno-unused-const-variable
+ccflags-y := $(call cc-disable-warning, unused-const-variable)
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-- 
2.6.0.rc2.230.g3dd15c0
