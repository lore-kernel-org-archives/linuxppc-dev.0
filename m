Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3861C1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:27:42 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 11:27:40 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id BF1B03E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:27:37 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3GHRJFo29753434
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 10:27:19 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3GHRZNh010821
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:27:37 -0600
Date: Wed, 15 Apr 2015 13:50:42 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150415205042.GA11620@us.ibm.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
 <1429052004.10000.1.camel@ellerman.id.au>
 <20150415092557.GA14942@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150415092557.GA14942@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, ak@linux.intel.com,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 mingo@redhat.com, Borislav Petkov <bp@alien8.de>, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

| 
| * Michael Ellerman <mpe@ellerman.id.au> wrote:
| 
| > > We just merged a patch series that was first sent in 2013. Some 
| > > things take time to get right.
| > 
| > The first attempt to get symbolic event name support into perf was 
| > sent in 2010, that's FIVE years ago [1].
| 
| kgdb took even longer, I think it was first proposed before 2000, over 
| 10 years before it got merged?
| 
| fs/overlayfs/ took similarly long I think, the first (Unionfs) patches 
| I remember were from around 2003 - 11 years before the functionality 
| was merged?
| 
| > And what complicated feature are we asking for? The ability to map a 
| > human readable name to a hex code, it has the complexity of a first 
| > year programming assignment.
| 
| No, what you are asking for, and which I NAK-ed, is:
| 
|  - to add a very limited 'update perf' capability which only updates a
|    single issue that you care about, with no ability to do more.

Yes, we are trying to solve one really annoying problem without precluding
the ability to do more (aka leave things better than they are even if we
can't solve everything).

Besides, I thought the discussion was where to host the JSON files.
I was not aware of the requirement to download/rebuild perf or not use
JSON at all (i.e generate data structures during build?).


|    The 'perf upgrade' prototype I sent can update all or part of perf. 
|    (The latest version is attached further below.)
| 
|  - to break the 'single binary' property of perf that many people rely on

Thats the part, I am having trouble with.

If the JSON files are like /etc/perfconfig, we don't need to rebuild the
binary when a config file changes right?

Second, if I build perf on my Power8 box, would the perf binary only include
events on my specific revision of the CPU or all Power8 versions?  Would the
perf binary from Power8 include events from all revisions of Power7 and
Power8?

If we include all possible revisions of the CPU, we would bloat perf.

If not we break the ability/convenience of copying rpms from one system
to the other? And we need to rebuild perf if the CPU on my system is
replaced and there are a couple of new event codes in the new CPU?


| 
|  - to add JSON parsing overhead to every invocation of perf instead of
|    pre-parsing the event tables at build time and putting them into 
|    a nice data structure.
| 
|  - to blindly follow some poorly constructed vendor format with no 
|    high level structure, that IMHO didn't work very well when OProfile 
|    was written, and misrepresenting it as 'symbolic event names'.
| 
|    Take a look at:
| 
|      https://download.01.org/perfmon/HSW/Haswell_core_V17.json
| 
|    and weep.

Evil vendor formats, but to be fair, here is what _we_ have today:

	perf stat -e r10068,r20036,r40060,r40ac sleep 1

	 Performance counter stats for 'sleep 1':

		   554,608      r10068                                                      
		    47,948      r20036                                                      
		   491,084      r40060                                                      
		       249      r40ac                                                       

	       1.001561257 seconds time elapsed

| How is one supposed to see the higher level structure of
|    the events with a format like that?

True, having events like 'cycles', 'branches' makes sense, but there
are so many different flavors of "run cycles" events in just Power8.

    PM_ANY_THRD_RUN_CYC,
    PM_MRK_RUN_CYC,
    PM_RUN_CYC,
    PM_RUN_CYC_SMT2_MODE,
    PM_RUN_CYC_SMT2_SHRD_MODE,
    PM_RUN_CYC_SMT2_SPLIT_MODE,
    PM_RUN_CYC_SMT4_MODE,
    PM_RUN_CYC_SMT8_MODE,
    PM_RUN_CYC_ST_MODE,
    PM_THRD_ALL_RUN_CYC,
    PM_TM_TRANS_RUN_CYC,
    PM_TM_TX_PASS_RUN_CYC,

Are we trying to build a high level structures across architectures?

| 
|  - to add an ABI to support those vendor files
| 
| And those are IMHO five good technical reasons to disagree with your 
| approach.
| 
| My suggestion to resolve the technical objections and lift the NAK 
| would be:
| 
|  - to add the tables to the source code, in a more human readable 
|    format and (optionally) structure the event names better into a 
|    higher level hierarchy, than the humungous linear dumps with no 
|    explanations that you propose - while still supporting the 'raw' 
|    vendor event names you want to use, for those people who are used 
|    to them.
| 

A bit confused.

Have the JSON files in the tree and generate the C structure during
build?

Or, ditch the JSON files and add something like this in say,
tools/perf/arch/powerpc/util/power8-events.h?

static const  struct events power8_events[] = {
    [ 0 ] = {
        .name = "PM_1LPAR_CYC",
        .code = 0x1f05e,
        .brief_desc = " "Number of cycles in single lpar mode. All threads in the core are assigned to the same lpar,",
        .public_desc = "Number of cycles in single lpar mode.,",
      },

If we have the JSON files, would the 'make install' put the JSON files
in ~/.cache/pmu-events or in a standard location?

|  - to pre-parse the event descriptions at build time - beyond the 
|    speedup this also keeps the 'single binary' property of perf.
| 
|  - to upgrade perf as a whole unit: this helps not just your usecase
|    but many other usecases as well.

I will try the perf upgrade below,  but the only clear use case I have
is for the event files. I am a little confused about the use case for
downloading and rebuilding perf. 

Building perf requires more packages than simply running perf. Most
users just run perf without needing to rebuild.

Running perf doesn't require root access but if we want to install
JSON files in standard locations (to get latest event codes for
instance) we will need root access.

Or should ~/.cache/pmu-events/*.json complement the event codes builtin
to the perf binary?

Sukadev
