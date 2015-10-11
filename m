Return-Path: <lkp@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.ozlabs.org (Postfix) with ESMTP id ACFC01A0617
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 01:20:10 +1100 (AEDT)
Date: Sun, 11 Oct 2015 22:19:17 +0800
From: Fengguang Wu <lkp@intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Paul Mackerras <paulus@samba.org>, kbuild-all@01.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Matthew Wilcox <willy@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: testing email patches
Message-ID: <20151011141917.GB17528@wfg-t540p.sh.intel.com>
References: <201510030421.d9fvrbXU%fengguang.wu@intel.com>
 <1444102746.16909.4.camel@ellerman.id.au>
 <20151007135602.GA17377@wfg-t540p.sh.intel.com>
 <1444263119.31685.4.camel@ellerman.id.au>
 <20151008010603.GA24198@wfg-t540p.sh.intel.com>
 <20151008011609.GA25163@wfg-t540p.sh.intel.com>
 <20151008074616.GA16089@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151008074616.GA16089@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Thu, Oct 08, 2015 at 12:46:16AM -0700, Christoph Hellwig wrote:
> Hi Fengguang,
> 
> I think this proactive testing does a little more harm than good in
> it's current form.  While offering testing for patches that aren't in
> git trees and or by people that don't even have a git tree that the
> build bots known about does seem useful, blindly doing it for every
> patch against something that most likely isn't the right base seems
> counter intertuitive.  We'll probaby need some annotation in the O/n
> mail that asks for a test and sets a base tree to actually make it
> useful.  With those few tweaks it should be really useful!
> 
> Maybe we should have a discussion about this at kernel summit?

Yes that may be a good topic for gathering feedbacks and ideas for
improving this useful but messy testing feature.

The best option could be to define a way to annotate the base tree's
branch/commit of a patchset and possibly automate the annotation in
the git/quilt email clients. Currently git does generate

        index c933675..a2aa0cd

for each diff files, however I find it far from enough -- there are
~50000 files in the kernel tree, knowing hash numbers for the typical
1-100 files a patchset may touch is pretty helpless in narrowing down
the search space of possible base trees.

It may also be useful to specify whether or not a patchset needs such
kind of testing. That'd be an easier task -- the robot can detect some
magic words in the email and take action accordingly. And it can auto
skip testing in some cases -- for example, Peter Zijlstra offered a
good point to skip testing patches without "Signed-off-by:" in a "Re:"
email. The patches already tested as git tree commits in the 500+ git
trees the 0day robot monitors will be auto skipped, too.

Also we could test against both mainline and linux-next -- an
excellent suggestion from Dan Carpenter, which is just implemented,
thanks!

Not knowing the exact base tree leads to inherent messiness, and the
possible solutions/workarounds are

1) annotations to tell the base tree (best option)
2) annotations & heuristics to skip tests
3) guess the suitable tree the maintainer would apply patches to
4) test on mainline & linux-next to filter out unstable build errors

(3) is kind of dirty work and enlightenments from subsystem
maintainers are highly welcome -- typically the suggestions can be
offered when you find a bug report to be unsuitable.

As for now I'm trying to teach 0day robot to apply patches to the
matching subsystem's "for-next" branch based on information in the
MAINTAINERS file. 

Thanks,
Fengguang

> On Thu, Oct 08, 2015 at 09:16:09AM +0800, Fengguang Wu wrote:
> > And of course linux-kernel. More lists could be added in future.
> > 
> > Thanks,
> > Fengguang
> ---end quoted text---
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
