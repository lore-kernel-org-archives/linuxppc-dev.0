Return-Path: <greg@kroah.com>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8581D2C020A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:33:52 +1100 (EST)
Date: Thu, 30 Jan 2014 04:34:57 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix compile error of pgtable-ppc64.h
Message-ID: <20140130123457.GA6571@kroah.com>
References: <1390911762-5659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390911762-5659-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140129184544.GA23204@kroah.com>
 <1391036256.8524.81.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391036256.8524.81.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 30, 2014 at 09:57:36AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-01-29 at 10:45 -0800, Greg KH wrote:
> > On Tue, Jan 28, 2014 at 05:52:42PM +0530, Aneesh Kumar K.V wrote:
> > > From: Li Zhong <zhong@linux.vnet.ibm.com>
> > > 
> > > It seems that forward declaration couldn't work well with typedef, use
> > > struct spinlock directly to avoiding following build errors:
> > > 
> > > In file included from include/linux/spinlock.h:81,
> > >                  from include/linux/seqlock.h:35,
> > >                  from include/linux/time.h:5,
> > >                  from include/uapi/linux/timex.h:56,
> > >                  from include/linux/timex.h:56,
> > >                  from include/linux/sched.h:17,
> > >                  from arch/powerpc/kernel/asm-offsets.c:17:
> > > include/linux/spinlock_types.h:76: error: redefinition of typedef 'spinlock_t'
> > > /root/linux-next/arch/powerpc/include/asm/pgtable-ppc64.h:563: note: previous declaration of 'spinlock_t' was here
> > > 
> > > build fix for upstream SHA1: b3084f4db3aeb991c507ca774337c7e7893ed04f
> > > for 3.13 stable series
> > 
> > I don't understand, why is this needed?  Is there a corrisponding patch
> > upstream that already does this?  What went wrong with a "normal"
> > backport of the patch to 3.13?
> 
> There's a corresponding patch in powerpc-next that I'm about to send to
> Linus today, but for the backport, the "fix" could be folded into the
> original offending patch.

Oh come on, you know better than to try to send me a patch that isn't in
Linus's tree already.  Crap, I can't take that at all.

Send me the git commit id when it is in Linus's tree, otherwise I'm not
taking it.

And no, don't "fold in" anything, that's not ok either.  I'll just go
drop this patch entirely from all of my -stable trees for now.  Feel
free to resend them when all of the needed stuff is upstream.

greg k-h
