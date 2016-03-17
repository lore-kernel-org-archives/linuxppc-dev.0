Return-Path: <robdclark@gmail.com>
Received: from mail-yw0-x22b.google.com (mail-yw0-x22b.google.com
 [IPv6:2607:f8b0:4002:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR0qF12RZzDr47
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 07:50:17 +1100 (AEDT)
Received: by mail-yw0-x22b.google.com with SMTP id g127so115637134ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 13:50:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458247207.9556.28.camel@perches.com>
References: <1458235817-28375-1-git-send-email-gustavo@padovan.org>
 <1458235817-28375-2-git-send-email-gustavo@padovan.org>
 <1458236486.9556.11.camel@perches.com>
 <20160317180523.GA2619@joana> <20160317184318.GA2611@joana>
 <1458246150.9556.17.camel@perches.com>
 <CAF6AEGvQa8SOWCtoEfcFAxz6MQ0Nqc-ktqNCdfJU-32-m-mCEQ@mail.gmail.com>
 <1458247207.9556.28.camel@perches.com>
Date: Thu, 17 Mar 2016 16:50:14 -0400
Message-ID: <CAF6AEGuzr2Vm_yngN7WcoeMLiiqb8B+kEBaNaPNqXdV2ZC-u-Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] kernel.h: add to_user_ptr()
From: Rob Clark <robdclark@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 devel@driverdev.osuosl.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Daniel Stone <daniels@collabora.com>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Riley Andrews <riandrews@android.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Greg Hackmann <ghackmann@google.com>, John Harrison <John.C.Harrison@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2016 at 4:40 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2016-03-17 at 16:33 -0400, Rob Clark wrote:
>> On Thu, Mar 17, 2016 at 4:22 PM, Joe Perches <joe@perches.com> wrote:
>> > On Thu, 2016-03-17 at 15:43 -0300, Gustavo Padovan wrote:
>> > > 2016-03-17 Gustavo Padovan <gustavo.padovan@collabora.co.uk>:
>> > > > 2016-03-17 Joe Perches <joe@perches.com>:
>> > > > > On Thu, 2016-03-17 at 14:30 -0300, Gustavo Padovan wrote:
>> > > > > > This function had copies in 3 different files. Unify them in
>> > > > > > kernel.h.
>> > > > > This is only used by gpu/drm.
>> > > > >
>> > > > > I think this is a poor name for a generic function
>> > > > > that would be in kernel.h.
>> > > > >
>> > > > > Isn't there an include file in linux/drm that's
>> > > > > appropriate for this.  Maybe drmP.h
>> > > > >
>> > > > > Maybe prefix this function name with drm_ too.
>> > > > No, the next patch adds a user to drivers/staging (which will be moved
>> > > > to drivers/dma-buf) soon. Maybe move to a different header in
>> > > > include/linux/? not sure which one.
>> > > >
>> > > > >
>> > > > >
>> > > > > Also, there's this that might conflict:
>> > > > >
>> > > > > arch/powerpc/kernel/signal_32.c:#define to_user_ptr(p)          ptr_to_compat(p)
>> > > > > arch/powerpc/kernel/signal_32.c:#define to_user_ptr(p)          ((unsigned long)(p))
>> > > > Right, I'll figure out how to replace these two too.
>> > > The powerpc to_user_ptr has a different meaning from the one I'm adding
>> > > in this patch. I propose we just rename powerpc's to_user_ptr to
>> > > __to_user_ptr and leave the rest as is.
>> > I think that's not a good idea, and you should really check
>> > this concept with the powerpc folk (added to to:s and cc:ed)
>> >
>> > If it were really added, then the function meaning is incorrect.
>> >
>> > This is taking a u64, casting that to (unsigned long/uint_ptr_t),
>> > then converting that to a user pointer.
>> >
>> > Does that naming and use make sense on x86-32 or arm32?
>> >
>> fwiw Gustavo's version of to_user_ptr() is in use on arm32 and arm64..
>> Not entirely sure what doesn't make sense about it
>
> It's a name that seems like it should be a straightforward
> cast of a kernel pointer to a __user pointer like:
>
> static inline void __user *to_user_ptr(void *p)
> {
>         return (void __user *)p;
> }

ahh, ok.  I guess I was used to using it in the context of ioctl
structs..  in that context u64 -> (void __user *) made more sense.

Maybe uapi_to_ptr()?  (ok, not super-creative.. maybe someone has a better idea)

BR,
-R

> As a static function in a single file, it's not
> great, but OK, fine, it's static.
>
> As a global function in kernel.h, it's misleading.
>
>
