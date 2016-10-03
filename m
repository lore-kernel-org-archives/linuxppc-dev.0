Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snvP94qGCzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 07:52:13 +1100 (AEDT)
Date: Mon, 3 Oct 2016 17:52:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 06/19] perf, tools: Support alias descriptions
Message-ID: <20161003205202.GA7143@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1473978296-20712-7-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160927174100.GO5588@kernel.org>
 <20160927181116.GA18012@us.ibm.com>
 <20160928135747.GB7467@kernel.org>
 <20160928182916.GA17343@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160928182916.GA17343@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 28, 2016 at 11:29:16AM -0700, Sukadev Bhattiprolu escreveu:
> Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > Em Tue, Sep 27, 2016 at 11:11:16AM -0700, Sukadev Bhattiprolu escreveu:
> > > Arnaldo Carvalho de Melo [acme@kernel.org] wrote:
> > > > Em Thu, Sep 15, 2016 at 03:24:43PM -0700, Sukadev Bhattiprolu escreveu:
> > > > > From: Andi Kleen <ak@linux.intel.com>
> > > > > Add support to print alias descriptions in perf list, which
> > > > > are taken from the generated event files.
> > > > > 
> > > > > The sorting code is changed to put the events with descriptions
> > > > > at the end. The descriptions are printed as possibly multiple word
> > > > > wrapped lines.
> > > > 
> > > > So, now I'm trying to reproduce the results below, but I couldn't find a
> > > > tarball with those .json files for me to use, can you provide me with
> > > > one?
> > > 
> > > The data files are in my github, in the json-code+data-v21 branch
> > > starting with 23bb101. They are individual commits rather than a
> > > tarball though.
> > 
> > Ok, I'll pick one for powerpc and another for x86_64 so that I can test
> > it and Jiri's x-compile support.
> 
> Please pull all files if possible, specially on x86, _before_ building the

Nah, will leave this for a second step, i.e. you guys can send a pull
req after I finish the initial testing.

> perf binary. If you are going to pull only one, you need to make sure that
> the file you pull matches the CPU model on the system you are testing.(see

Right, right, that was the plan, and I actually did it now, got the
mapfile.csv, left only the entry for my test machine:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 61
model name	: Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz

Which is 3D, i.e.:

[acme@jouet linux]$ cat tools/perf/pmu-events/arch/x86/mapfile.csv 
Family-model,Version,Filename,EventType
GenuineIntel-6-3D,V16,Broadwell,core
[acme@jouet linux]$ 

And copied the files in the directory this maps to:

[acme@jouet linux]$ ls -la tools/perf/pmu-events/arch/x86/Broadwell/
total 352
drwxrwxr-x. 2 acme acme   4096 Oct  3 17:23 .
drwxrwxr-x. 3 acme acme   4096 Oct  3 17:23 ..
-rw-r--r--. 1 acme acme 127294 Oct  3 17:20 Cache.json
-rw-r--r--. 1 acme acme  10100 Oct  3 17:21 Floating-point.json
-rw-r--r--. 1 acme acme  16319 Oct  3 17:21 Frontend.json
-rw-r--r--. 1 acme acme 106375 Oct  3 17:21 Memory.json
-rw-r--r--. 1 acme acme   2080 Oct  3 17:22 Other.json
-rw-r--r--. 1 acme acme  64972 Oct  3 17:22 Pipeline.json
-rw-r--r--. 1 acme acme  15356 Oct  3 17:23 Virtual-Memory.json
[acme@jouet linux]$ 

Then try to build it as usual, i.e. using O=:

  make O=/tmp/build/perf -C tools/perf install-bin

And it fails, not building the $(OUTPUT)pmu-events/pmu-events.c
somehow...

Ok, I decide to fall back to building it in the same directory as the
sources:

[acme@jouet linux]$ cd tools/perf
[acme@jouet perf]$ make

It gets a bit better, but fails as well:

[acme@jouet perf]$ make
  BUILD:   Doing 'make -j4' parallel build
  CC       pmu-events/pmu-events.o
pmu-events/pmu-events.c:4430:11: error: ‘pme_Filename’ undeclared here
(not in a function)
  .table = pme_Filename
           ^~~~~~~~~~~~
mv: cannot stat 'pmu-events/.pmu-events.o.tmp': No such file or
directory
/home/acme/git/linux/tools/build/Makefile.build:88: recipe for target
'pmu-events/pmu-events.o' failed
make[2]: *** [pmu-events/pmu-events.o] Error 1
Makefile.perf:467: recipe for target 'pmu-events/pmu-events-in.o' failed
make[1]: *** [pmu-events/pmu-events-in.o] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:68: recipe for target 'all' failed
make: *** [all] Error 2
[acme@jouet perf]$ 

It finally builds if I ditch the header in

https://raw.githubusercontent.com/sukadev/linux/json-code%2Bdata-v21/tools/perf/pmu-events/arch/x86/mapfile.csv

[acme@jouet perf]$ cat pmu-events/arch/x86/mapfile.csv 
Family-model,Version,Filename,EventType
GenuineIntel-6-3D,V16,Broadwell,core
[acme@jouet perf]$ vim pmu-events/arch/x86/mapfile.csv 
[acme@jouet perf]$ cat pmu-events/arch/x86/mapfile.csv 
GenuineIntel-6-3D,V16,Broadwell,core
[acme@jouet perf]$ make
  BUILD:   Doing 'make -j4' parallel build
  GEN      pmu-events/pmu-events.c
Warning: tools/include/uapi/linux/bpf.h differs from kernel
  CC       pmu-events/pmu-events.o
  LD       pmu-events/pmu-events-in.o
  AR       libperf.a
  LINK     libperf-gtk.so
  LINK     perf
[acme@jouet perf]$

And then it seems to work, at least for 'perf list', still need to check
if reading events with the generic name so far used + the new one looks
sane, will be done after this:

[acme@jouet perf]$ perf list | grep arith
  arith.fpu_div_active                              
  fp_arith_inst_retired.128b_packed_double          
  fp_arith_inst_retired.128b_packed_single          
  fp_arith_inst_retired.256b_packed_double          
  fp_arith_inst_retired.256b_packed_single          
  fp_arith_inst_retired.double                      
  fp_arith_inst_retired.packed                      
  fp_arith_inst_retired.scalar                      
  fp_arith_inst_retired.scalar_double               
  fp_arith_inst_retired.scalar_single               
  fp_arith_inst_retired.single                      
[acme@jouet perf]$

Now trying to fix the O= part to continue processing...

- Arnaldo

> below). For Power, you need to test on Power8.
> > 
> > Refresh my mind, what is the plan on these files? Are we just going to
> > provide pointers to where to get them from vendors, ship it in the
> > kernel, auto-download them as part of the build process?
> 
> They are supposed to be committed into the linux kernel tree as shown
> in the json-code+data-v21 tree and they will be picked up _during build_
> of the perf binary. (We are just not mailing those data files as patches
> since they are large and there is very little value in reviewing them).
> 
> When building perf on on say x86, event tables for all the different
> x86 CPU models will be included in the perf binary. When perf is then
> executed on an x86 box, it will detect the CPU model of that box and
> use the set of events corresponding to that model.
> 
> If the CPU model does not match the models "known" to the perf binary,
> then the symbolic names will not work on that system, but there should
> be no other change in behavior.
> 
> Patch 15/19 tries to explain the process.
> 
> > 
> > At least examples that allows to build and have a new 'perf test' entry
> > to check them automatically seems to be in order, no?
> 
> Well, the hope was that build/usage will be transparent! but we did not
> test in the cross-compile environment. Will think about a test case.
> Please let me know if we can update the README in Patch 15/19 in any
> way.
> 
> > 
> > - Arnaldo
> > 
> > > 	>       https://github.com/sukadev/linux.git
> > > 	>
> > > 	>       Branch                  Description
> > > 	>       ------------------------------------------------------
> > > 	>       json-code-v21           Source Code only
> > > 	>       json-code+data-v21      Both code and data(for build/test/pull)
> > > 	> 
> > > 
> > > Sukadev
