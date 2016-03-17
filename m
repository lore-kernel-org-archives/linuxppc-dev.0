Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0039.hostedemail.com
 [216.40.44.39])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR0Mn4mTCzDq70
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 07:29:57 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave05.hostedemail.com (Postfix) with ESMTP id EC8DC184F16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 20:22:43 +0000 (UTC)
Message-ID: <1458246150.9556.17.camel@perches.com>
Subject: Re: [PATCH v9 2/3] kernel.h: add to_user_ptr()
From: Joe Perches <joe@perches.com>
To: Gustavo Padovan <gustavo@padovan.org>, Gustavo Padovan
 <gustavo.padovan@collabora.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
 dri-devel@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>, Arve
 =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Riley Andrews
 <riandrews@android.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Rob Clark
 <robdclark@gmail.com>, Greg Hackmann <ghackmann@google.com>, John Harrison
 <John.C.Harrison@Intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, akpm@linux-foundation.org, David
 Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 17 Mar 2016 13:22:30 -0700
In-Reply-To: <20160317184318.GA2611@joana>
References: <1458235817-28375-1-git-send-email-gustavo@padovan.org>
 <1458235817-28375-2-git-send-email-gustavo@padovan.org>
 <1458236486.9556.11.camel@perches.com> <20160317180523.GA2619@joana>
 <20160317184318.GA2611@joana>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-17 at 15:43 -0300, Gustavo Padovan wrote:
> 2016-03-17 Gustavo Padovan <gustavo.padovan@collabora.co.uk>:
> > 2016-03-17 Joe Perches <joe@perches.com>:
> > > On Thu, 2016-03-17 at 14:30 -0300, Gustavo Padovan wrote:
> > > > 
> > > > This function had copies in 3 different files. Unify them in
> > > > kernel.h.
> > > This is only used by gpu/drm.
> > > 
> > > I think this is a poor name for a generic function
> > > that would be in kernel.h.
> > > 
> > > Isn't there an include file in linux/drm that's
> > > appropriate for this.  Maybe drmP.h
> > > 
> > > Maybe prefix this function name with drm_ too.
> > No, the next patch adds a user to drivers/staging (which will be moved
> > to drivers/dma-buf) soon. Maybe move to a different header in
> > include/linux/? not sure which one.
> > 
> > > 
> > > Also, there's this that might conflict:
> > > 
> > > arch/powerpc/kernel/signal_32.c:#define to_user_ptr(p)          ptr_to_compat(p)
> > > arch/powerpc/kernel/signal_32.c:#define to_user_ptr(p)          ((unsigned long)(p))
> > Right, I'll figure out how to replace these two too.
> The powerpc to_user_ptr has a different meaning from the one I'm adding
> in this patch. I propose we just rename powerpc's to_user_ptr to
> __to_user_ptr and leave the rest as is.

I think that's not a good idea, and you should really check
this concept with the powerpc folk (added to to:s and cc:ed)

If it were really added, then the function meaning is incorrect.

This is taking a u64, casting that to (unsigned long/uint_ptr_t),
then converting that to a user pointer.

Does that naming and use make sense on x86-32 or arm32?
