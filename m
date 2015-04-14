Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 697981A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 18:55:49 +1000 (AEST)
Received: by widjs5 with SMTP id js5so83086957wid.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 01:55:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 14 Apr 2015 10:55:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON event
 files.)
Message-ID: <20150414085541.GA30202@gmail.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, ak@linux.intel.com,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org,
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


* Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote:

> This is another attempt to resurrect Andi Kleen's patchset so users
> can specify perf events by their event names rather than raw codes.
> 
> This is a rebase of Andi Kleen's patchset from Jul 30, 2014[1] to 4.0.
> (I fixed minor and not so minor conflicts).

So this series shows some progress, but instead of this limited 
checkout ability I'd still prefer it if 'perf download' downloaded the 
latest perf code itself and built it - it shouldn't be limited to just 
a small subset of the perf source code!

There's a few Git tricks we can use to make this palatable on most 
systems.

To save disk space and network bandwith this could be done using Git's 
'shallow clone' feature:

   git clone --depth 1 --bare

The initial checkout finishes in 1.5 minutes here, a continent away 
from korg. The resulting repository size is just 143MB.

The code could also check whether the user has already a ~/linux.git 
repository around, and use --reference ~/linux.git in that case. In 
such a case the cloning takes just 2 seconds.

To get the source code we could use Git's 'sparse checkout' feature:

   git config core.sparsecheckout true
   echo tools/ > .git/info/sparse-checkout
   git checkout tools/

Note that a sparse checkout build will need a few relatively simple 
other files as well, for the few files not in tools/ that the perf 
build needs - mostly include files.

I've attached below a working test script that will create a buildable 
tools/perf/ repository into ~/.perf/git/ of the latest tip/perf/core 
tree from kernel.org.

With ~/linux.git primed it takes under 10 seconds to execute. perf 
builds fine in the directory. The whole directory together with the 
Git repo is 53 MB - that could be shrunk some more if needed.

If there's no local Linux repository to fall back on to then the 
initial step takes 1.5 minutes (depending on network bandwidth) and 
another 140MB for the Git objects. It's a lot faster after that.

That way 'perf download' could also be renamed to 'perf upgrade'.

Building perf ought to be possible even on fairly limited development 
systems and our auto-detection and library install suggestions are 
pretty good.

And note that once we have that there's no reason to move the event 
descriptions into a separate file - it can be part of the perf binary 
itself.

> This patchset includes the perf-download tool that was dropped and 
> sets the default download location to the 
> (tools/perf/pmu-events/arch/... directory in Linus's tree.

So the way I think this would work best is for 'perf upgrade' to have 
different levels, similar to what the kernel has:

  perf upgrade devel               # pick files up from Arnaldo's korg tree
  perf upgrade next                # pick files up from tip.git on korg
  perf upgrade rc                  # pick files up from linus's Git tree
  perf upgrade stable              # pick files up the latest -stable version

'perf upgrade' would default to the most conservative, -stable 
variant, but of course users could pick whichever variant they prefer.

There's some limitations (such as if the build fails - but we want to 
fix such cases anyway), but note the fundamental power of this 
approach: 'perf upgrade' could turn any developer who has a perf 
binary into a perf tester and even into a contributor.

There's no need to even know Git or other development details - the 
latest code could be picked up and built.

'perf upgrade distro' could be offered as a way to downgrade to 
whatever previous (distro) perf version the user was using.

Likewise, later on this approach could be generalized into 
tools/build/ to enable self-hosting for other tools in tools/ as well, 
if they so desire.

Thanks,

	Ingo

============================>
#!/bin/bash
#
# Simple script that fetches the 'perf' utility from Linus's tree, builds and
# installs it, by creating a shallow clone and a sparse checkout for Linux's
# tools/ directory and related dependencies:
#

DIR=~/.perf/git

rm -rf $DIR
mkdir -p $DIR || { echo 'error: No write permissions in the current directory?'; exit -1; }
cd $DIR

#REPO=git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
#BRANCH=HEAD
REPO=git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
BRANCH=perf/core

REFERENCE="."
[ -d ~/linux/.git     ] && REFERENCE=~/linux/
[ -d ~/linux.git/.git ] && REFERENCE=~/linux.git/
[ -d ~/tip/.git       ] && REFERENCE=~/tip/
[ -d ~/tip.git/.git   ] && REFERENCE=~/tip.git/

git clone --reference $REFERENCE --depth 1 --bare $REPO --branch $BRANCH .git
git config --local core.bare false

git config --local core.sparseCheckout true
git remote remove origin
git remote add -f origin $REPO -t $BRANCH

(
  echo '/tools/*'
  echo '/lib/*'
  echo '/include/*'
  echo '/arch/x86/lib/*'
  echo '/arch/x86/include/*'
  echo 'Makefile'
  echo '/scripts/*'

) > .git/info/sparse-checkout

git checkout $BRANCH

make -C tools/perf/ install
