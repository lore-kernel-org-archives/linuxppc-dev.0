Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3E1B1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:27:42 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 11:27:40 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 45AB519D803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:18:43 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3GHRJJk29753442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 10:27:19 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3GHRajM010855
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:27:37 -0600
Date: Tue, 14 Apr 2015 11:03:18 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150414180318.GA16873@us.ibm.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150414125822.GA32761@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, tom.huynh@freescale.com,
 ak@linux.intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
 namhyung@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@redhat.com>, Pekka Enberg <penberg@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ingo Molnar [mingo@kernel.org] wrote:

Meant to Cc Tom Huynh as they had a related patchset a few months
ago.

| 
| * Michael Ellerman <mpe@ellerman.id.au> wrote:
| 
| > On Tue, 2015-04-14 at 10:55 +0200, Ingo Molnar wrote:
| > > * Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:
| > > 
| > > > This is another attempt to resurrect Andi Kleen's patchset so users
| > > > can specify perf events by their event names rather than raw codes.
| > > > 
| > > > This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
| > > > (I fixed minor and not so minor conflicts).
| > > 
| > > So this series shows some progress, but instead of this limited 
| > > checkout ability I'd still prefer it if 'perf download' downloaded 
| > > the latest perf code itself and built it - it shouldn't be limited 
| > > to just a small subset of the perf source code!
| > 
| > Ingo, can you please stop blocking this? It's getting ridiculous.
| > 
| > We've been waiting over 8 months for this to go in.
| 
| We just merged a patch series that was first sent in 2013. Some things 
| take time to get right.

I used to rebuild git years ago to work around bugs in rebase, but rarely
need to rebuild these days, because it is stable.  I am guessing it is the
same for most users of perf.

IOW, perf download/upgrade can be extended to fetch and build, but
dont' understand why that is _required_ to _use_ the JSON files.

- perf having an ability to parse JSON files
- perf downloading JSON files
- perf downloading latest source code
- perf downloading dependent RPMS/packages to build (which
  seem to be tied to distros)

all seem like independent steps to me. If current design can be
tweaked to not constrain future choices, we should definitely do
that.

If not, can we make incremental progress on this?

If necessary, we could add an option to 'perf upgrade' to fetch only
the JSON files?  Or by default, 'perf upgrade' can assume --all
and download everything it can download.

In the future we can add --json-files, --sources etc and still
ahve --all fetch everything it can.

Sukadev
