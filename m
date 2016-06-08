Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPmTc0XxWzDqYn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:31:00 +1000 (AEST)
Message-ID: <1465385458.13854.11.camel@ellerman.id.au>
Subject: Re: Kernel 4.7: PAGE_GUARDED and _PAGE_NO_CACHE
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 darren@stevens-zone.net, Michael Ellerman <michaele@au1.ibm.com>, Julian
 Margetson <runaway@candw.ms>, Adrian Cox <adrian@humboldt.co.uk>,
 "R.T.Dickinson" <rtd@a-eon.com>,  "R.T.Dickinson" <rtd2@xtra.co.nz>, Pat
 Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,  "contact@a-eon.com"
 <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>, luigi burdo
 <intermediadc@hotmail.com>, Christian Zigotzky <info@xenosoft.de>
Date: Wed, 08 Jun 2016 21:30:58 +1000
In-Reply-To: <409c2f4c-52bf-8f46-8a29-c6f384c75946@xenosoft.de>
References: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
 <1463990507.3078.16.camel@kernel.crashing.org>
 <cff72fd8-3297-b61b-4ddc-8c491b565f80@xenosoft.de>
 <1464088614.3078.79.camel@kernel.crashing.org>
 <1298e1f6-beb7-5487-72a1-366ebd140c17@xenosoft.de>
 <87d1obqxg9.fsf@skywalker.in.ibm.com>
 <9690f9a4-70c7-8acc-42d0-779bcc93db52@xenosoft.de>
 <66397458-c40a-4e83-c5e5-0ba69fb48986@xenosoft.de>
 <874m99uibc.fsf@skywalker.in.ibm.com>
 <ab51f49d-fc8f-24ce-6763-c641b949971e@xenosoft.de>
 <1465174304.12265.0.camel@ellerman.id.au>
 <50194690-18ac-edfd-42cb-8f1cc96055c9@xenosoft.de>
 <1465354334.14294.4.camel@ellerman.id.au>
 <409c2f4c-52bf-8f46-8a29-c6f384c75946@xenosoft.de>
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

On Wed, 2016-06-08 at 12:58 +0200, Christian Zigotzky wrote:
> On 08 June 2016 at 04:52 AM, Michael Ellerman wrote:
> > On Tue, 2016-06-07 at 22:17 +0200, Christian Zigotzky wrote:
> > > 764041e0f43cc7846f6d8eb246d65b53cc06c764 is the first bad commit
> > > commit 764041e0f43cc7846f6d8eb246d65b53cc06c764
> > > Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > > Date:   Fri Apr 29 23:26:09 2016 +1000
> > > 
> > >      powerpc/mm/radix: Add checks in slice code to catch radix usage
> > > 
> > >      Radix doesn't need slice support. Catch incorrect usage of slice code
> > >      when radix is enabled.
> > > 
> > >      Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> > >      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > 
> > Hmm, I find that hard to believe. But maybe I'm missing something.
> > 
> > Can you checkout Linus' master and then revert that commit?
> > 
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git
> $ git checkout
> Your branch is up-to-date with 'origin/master'.
> 
> $ git revert 764041e0f43cc7846f6d8eb246d65b53cc06c764 -m 1
> error: Mainline was specified but commit 764041e0f43cc7846f6d8eb246d65b53cc06c764 is not a merge.
> fatal: revert failed
> 
> How can I checkout Linus' master and then revert that commit?

It's not a merge, so just plain git revert:

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git
  $ cd linux-git
  $ git revert 764041e0f43cc7846f6d8eb246d65b53cc06c764
  [master 5dd9737a173e] Revert "powerpc/mm/radix: Add checks in slice code to catch radix usage"
   1 file changed, 16 deletions(-)

cheers
