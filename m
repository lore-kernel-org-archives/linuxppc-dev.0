Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A1CD2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 05:03:22 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 23:33:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D24B83940061
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:33:14 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0UI37F635520696
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:33:07 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0UI3E33015193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:33:14 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
In-Reply-To: <20140130175514.GA29370@kroah.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140129184544.GA23204@kroah.com> <1391036256.8524.81.camel@pasglop>
 <20140130123457.GA6571@kroah.com> <8761p15pzn.fsf@linux.vnet.ibm.com>
 <20140130175514.GA29370@kroah.com>
Date: Thu, 30 Jan 2014 23:33:13 +0530
Message-ID: <8738k55ov2.fsf@linux.vnet.ibm.com>
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

> On Thu, Jan 30, 2014 at 11:08:52PM +0530, Aneesh Kumar K.V wrote:
>> Greg KH <greg@kroah.com> writes:
>> 
>> > On Thu, Jan 30, 2014 at 09:57:36AM +1100, Benjamin Herrenschmidt wrote:
>> >> On Wed, 2014-01-29 at 10:45 -0800, Greg KH wrote:
>> >> > On Tue, Jan 28, 2014 at 05:52:42PM +0530, Aneesh Kumar K.V wrote:
>> >> > > From: Li Zhong <zhong@linux.vnet.ibm.com>
>> >> > > 
>> >> > > It seems that forward declaration couldn't work well with typedef, use
>> >> > > struct spinlock directly to avoiding following build errors:
>> >> > > 
>> >> > > In file included from include/linux/spinlock.h:81,
>> >> > >                  from include/linux/seqlock.h:35,
>> >> > >                  from include/linux/time.h:5,
>> >> > >                  from include/uapi/linux/timex.h:56,
>> >> > >                  from include/linux/timex.h:56,
>> >> > >                  from include/linux/sched.h:17,
>> >> > >                  from arch/powerpc/kernel/asm-offsets.c:17:
>> >> > > include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
>> >> > > /root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here
>> >> > > 
>> >> > > build fix for upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
>> >> > > for 3.13 stable series
>> >> > 
>> >> > I don't understand, why is this needed?  Is there a corrisponding patch
>> >> > upstream that already does this?  What went wrong with a "normal"
>> >> > backport of the patch to 3.13?
>> >> 
>> >> There's a corresponding patch in powerpc-next that I'm about to send to
>> >> Linus today, but for the backport, the "fix" could be folded into the
>> >> original offending patch.
>> >
>> > Oh come on, you know better than to try to send me a patch that isn't in
>> > Linus's tree already.  Crap, I can't take that at all.
>> >
>> > Send me the git commit id when it is in Linus's tree, otherwise I'm not
>> > taking it.
>> >
>> > And no, don't "fold in" anything, that's not ok either.  I'll just go
>> > drop this patch entirely from all of my -stable trees for now.  Feel
>> > free to resend them when all of the needed stuff is upstream.
>> 
>> The fix for mremap crash is already in Linus tree.
>
> What is the git commit id?

upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f

That is patch 1 in this series.


>
>> It is the build failure for older gcc compiler version that is not in
>> linus tree.
>
> That is what I can not take.
>
>> We missed that in the first pull request. Do we really need to drop
>> the patch from 3.11 and 3.12 trees ?
>
> I already did.
>
>> The patch their is a variant, and don't require this build fix.
>
> Don't give me a "variant", give me the exact same patch, only changed to
> handle the fuzz/differences of older kernels, don't make different
> changes to the original patch to make up for things you found out later
> on, otherwise everyone is confused as to why the fix for the fix is not
> in the tree.

In this specific case it may be difficult. 3.13 have other changes
around the code path. It has split pmd locks etc which result in us
doing a withdraw and deposit even on x86. For 3.11 and 3.12, we need to
do that extra withdraw and deposit only for ppc64. Hence the variant
which used #ifdef around that code. 

>
> So, when both patches get in Linus's tree, please send me the properly
> backported patches and I'll be glad to apply them.
>

-aneesh
