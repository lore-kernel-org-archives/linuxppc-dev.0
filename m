Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 319091A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 09:04:05 +1000 (AEST)
Date: Sun, 27 Sep 2015 09:03:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Torsten Duwe <duwe@lst.de>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: -mprofile-kernel vs. notrace in ppc64(le) Linux kernels
Message-ID: <20150927090348.3c725ab4@kryten>
In-Reply-To: <20150926145243.GA14958@gate.crashing.org>
References: <20150926143008.GA14606@lst.de>
 <20150926145243.GA14958@gate.crashing.org>
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

Hi,

> On Sat, Sep 26, 2015 at 04:30:08PM +0200, Torsten Duwe wrote:
> > As I mentioned earlier this year, it's a bad idea to call _mcount
> > from MMU helper functions (e.g. hash_page...), when the
> > profiling/tracing/ live-patching/whatever framewok might in turn
> > cause another such fault. Jikos suggested to use fine-grained
> > control of these functions with the "notrace" keyword in the Linux
> > kernel. It is mapped to GCC's (4.8, FWIW)
> > __attribute__((no_instrument_function)), which, to my surprise,
> > works for -p and -pg nicely, but does not affect -mprofile-kernel
> > at all!
> 
> That is surprising; please file a GCC bug.

This sounds like the issue below, fixed by Pat.

Anton
--

commit ccebc2aad32917f3371ae6d5774f689c86ace0b2
Author: pthaugen <pthaugen@138bc75d-0d04-0410-961f-82ee72b054a4>
Date:   Wed Jan 15 23:48:12 2014 +0000

    	* config/rs6000/rs6000.c (rs6000_output_function_prologue): Check if
    	current procedure should be profiled.
    
    
    
    git-svn-id: svn+ssh://gcc.gnu.org/svn/gcc/trunk@206650 138bc75d-0d04-0410-961f-82ee72b054a4

diff --git a/gcc/ChangeLog b/gcc/ChangeLog
index 2781bd0..0788036 100644
--- a/gcc/ChangeLog
+++ b/gcc/ChangeLog
@@ -1,3 +1,8 @@
+2014-01-15  Pat Haugen  <pthaugen@us.ibm.com>
+
+	* config/rs6000/rs6000.c (rs6000_output_function_prologue): Check if
+	current procedure should be profiled.
+
 2014-01-15  Andrew Pinski  <apinski@cavium.com>
 
 	* config/aarch64/aarch64.c (aarch64_register_move_cost): Correct cost
diff --git a/gcc/config/rs6000/rs6000.c b/gcc/config/rs6000/rs6000.c
index 289b52c..a479219 100644
--- a/gcc/config/rs6000/rs6000.c
+++ b/gcc/config/rs6000/rs6000.c
@@ -23198,7 +23198,7 @@ rs6000_output_function_prologue (FILE *file,
   /* Output -mprofile-kernel code.  This needs to be done here instead of
      in output_function_profile since it must go after the ELFv2 ABI
      local entry point.  */
-  if (TARGET_PROFILE_KERNEL)
+  if (TARGET_PROFILE_KERNEL && crtl->profile)
     {
       gcc_assert (DEFAULT_ABI == ABI_AIX || DEFAULT_ABI == ABI_ELFv2);
       gcc_assert (!TARGET_32BIT);
