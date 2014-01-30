Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 054C62C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:39:05 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 03:39:03 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 85C6F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:38:57 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UHcihl11075938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:38:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UHcu58008316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:38:57 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
In-Reply-To: <20140130123457.GA6571@kroah.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140129184544.GA23204@kroah.com> <1391036256.8524.81.camel@pasglop>
 <20140130123457.GA6571@kroah.com>
Date: Thu, 30 Jan 2014 23:08:52 +0530
Message-ID: <8761p15pzn.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Li Zhong <zhong@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg KH <greg@kroah.com> writes:

> On Thu, Jan 30, 2014 at 09:57:36AM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2014-01-29 at 10:45 -0800, Greg KH wrote:
>> > On Tue, Jan 28, 2014 at 05:52:42PM +0530, Aneesh Kumar K.V wrote:
>> > > From: Li Zhong <zhong@linux.vnet.ibm.com>
>> > > 
>> > > It seems that forward declaration couldn't work well with typedef, use
>> > > struct spinlock directly to avoiding following build errors:
>> > > 
>> > > In file included from include/linux/spinlock.h:81,
>> > >                  from include/linux/seqlock.h:35,
>> > >                  from include/linux/time.h:5,
>> > >                  from include/uapi/linux/timex.h:56,
>> > >                  from include/linux/timex.h:56,
>> > >                  from include/linux/sched.h:17,
>> > >                  from arch/powerpc/kernel/asm-offsets.c:17:
>> > > include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
>> > > /root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here
>> > > 
>> > > build fix for upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
>> > > for 3.13 stable series
>> > 
>> > I don't understand, why is this needed?  Is there a corrisponding patch
>> > upstream that already does this?  What went wrong with a "normal"
>> > backport of the patch to 3.13?
>> 
>> There's a corresponding patch in powerpc-next that I'm about to send to
>> Linus today, but for the backport, the "fix" could be folded into the
>> original offending patch.
>
> Oh come on, you know better than to try to send me a patch that isn't in
> Linus's tree already.  Crap, I can't take that at all.
>
> Send me the git commit id when it is in Linus's tree, otherwise I'm not
> taking it.
>
> And no, don't "fold in" anything, that's not ok either.  I'll just go
> drop this patch entirely from all of my -stable trees for now.  Feel
> free to resend them when all of the needed stuff is upstream.

The fix for mremap crash is already in Linus tree. It is the build
failure for older gcc compiler version that is not in linus tree. We
missed that in the first pull request. Do we really need to drop the
patch from 3.11 and 3.12 trees ? The patch their is a variant, and don't
require this build fix.

-aneesh
