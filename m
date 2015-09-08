Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87C771A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 19:24:40 +1000 (AEST)
Message-ID: <1441704279.7601.6.camel@ellerman.id.au>
Subject: Re: powerpc: Add user-return-notifier support
From: Michael Ellerman <mpe@ellerman.id.au>
To: ananth@in.ibm.com
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, Paul
 Mackerras <paulus@samba.org>, ego@linux.vnet.ibm.com, mingo@kernel.org
Date: Tue, 08 Sep 2015 19:24:39 +1000
In-Reply-To: <20150902050958.GC1196@in.ibm.com>
References: <20150825054110.GD3815@in.ibm.com>
 <20150831103517.96D1A1401E7@ozlabs.org> <20150901064113.GA1196@in.ibm.com>
 <1441152192.4966.103.camel@freescale.com>
 <20150902023713.GB1196@in.ibm.com>
 <1441164552.4966.153.camel@freescale.com>
 <20150902050958.GC1196@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-02 at 10:39 +0530, Ananth N Mavinakayanahalli wrote:
> On Tue, Sep 01, 2015 at 10:29:12PM -0500, Scott Wood wrote:
> 
> > Why is this selected by KVM on PPC if KVM on PPC doesn't use it?  What is the 
> > user you're trying to enable?
> 
> I copied Paul and Gautham to get their thoughts on whether it is
> something they could use on Power. At this time, apart from enabling the
> feature, I do not have a specific usecase for it. We can park this patch
> pending a real user on powerpc.

OK, thanks for hashing that out guys. I think parking it is the best solution
for now, we could merge it and disable it somehow, but that would be ugly and
prone to breaking.

Do we want to do something like this?

cheers

diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
index d22a1095e661..3e2cf6161cf4 100644
--- a/Documentation/features/arch-support.txt
+++ b/Documentation/features/arch-support.txt
@@ -8,4 +8,5 @@ The meaning of entries in the tables is:
     | ok |  # feature supported by the architecture
     |TODO|  # feature not yet supported by the architecture
     | .. |  # feature cannot be supported by the hardware
+    |n/a |  # feature is not needed/wanted/meaningful for the architecture
 
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 44cc1ff3f603..669813180dc5 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: | n/a  |    # http://lkml.kernel.org/r/20150825054110.GD3815@in.ibm.com
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
