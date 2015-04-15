Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8893D1A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 19:26:06 +1000 (AEST)
Received: by wiun10 with SMTP id n10so52492997wiu.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 02:26:02 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 15 Apr 2015 11:25:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 'perf upgrade' (was: Re: [PATCH v9 00/11] Add support for JSON
 event files.)
Message-ID: <20150415092557.GA14942@gmail.com>
References: <1428993665-2133-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150414085541.GA30202@gmail.com>
 <1429010508.27414.1.camel@ellerman.id.au>
 <20150414125822.GA32761@gmail.com>
 <1429052004.10000.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429052004.10000.1.camel@ellerman.id.au>
Cc: Arnaldo Carvalho de Melo <acme@infradead.org>, ak@linux.intel.com,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, namhyung@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 Pekka Enberg <penberg@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> > We just merged a patch series that was first sent in 2013. Some 
> > things take time to get right.
> 
> The first attempt to get symbolic event name support into perf was 
> sent in 2010, that's FIVE years ago [1].

kgdb took even longer, I think it was first proposed before 2000, over 
10 years before it got merged?

fs/overlayfs/ took similarly long I think, the first (Unionfs) patches 
I remember were from around 2003 - 11 years before the functionality 
was merged?

> And what complicated feature are we asking for? The ability to map a 
> human readable name to a hex code, it has the complexity of a first 
> year programming assignment.

No, what you are asking for, and which I NAK-ed, is:

 - to add a very limited 'update perf' capability which only updates a
   single issue that you care about, with no ability to do more.
   The 'perf upgrade' prototype I sent can update all or part of perf. 
   (The latest version is attached further below.)

 - to break the 'single binary' property of perf that many people rely on

 - to add JSON parsing overhead to every invocation of perf instead of
   pre-parsing the event tables at build time and putting them into 
   a nice data structure.

 - to blindly follow some poorly constructed vendor format with no 
   high level structure, that IMHO didn't work very well when OProfile 
   was written, and misrepresenting it as 'symbolic event names'.

   Take a look at:

     https://download.01.org/perfmon/HSW/Haswell_core_V17.json

   and weep. How is one supposed to see the higher level structure of
   the events with a format like that?

 - to add an ABI to support those vendor files

And those are IMHO five good technical reasons to disagree with your 
approach.

My suggestion to resolve the technical objections and lift the NAK 
would be:

 - to add the tables to the source code, in a more human readable 
   format and (optionally) structure the event names better into a 
   higher level hierarchy, than the humungous linear dumps with no 
   explanations that you propose - while still supporting the 'raw' 
   vendor event names you want to use, for those people who are used 
   to them.

 - to pre-parse the event descriptions at build time - beyond the 
   speedup this also keeps the 'single binary' property of perf.

 - to upgrade perf as a whole unit: this helps not just your usecase
   but many other usecases as well.

   For those who only want to update event tables: with
   'perf upgrade stable' basically only new event tables (backported 
   to -stable) would be picked up, plus regression fixes: it pretty 
   much does what your proposed 'perf download' solution does, except 
   it's much more capable.

Saying 'no' and suggesting better solutions is my job as a maintainer.

Thanks,

	Ingo

======={ perf-upgrade.sh }===========>

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
[ -d ~/git/linux      ] && REFERENCE=~/git/linux/

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
