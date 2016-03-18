Return-Path: <daniel@ffwll.ch>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRJBm1hmyzDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 19:23:11 +1100 (AEDT)
Received: by mail-wm0-x235.google.com with SMTP id l68so26047727wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 01:23:11 -0700 (PDT)
Sender: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Fri, 18 Mar 2016 09:23:56 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Joe Perches <joe@perches.com>
Cc: Gustavo Padovan <gustavo@padovan.org>, Rob Clark <robdclark@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 devel@driverdev.osuosl.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Daniel Stone <daniels@collabora.com>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Riley Andrews <riandrews@android.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Greg Hackmann <ghackmann@google.com>,
 John Harrison <John.C.Harrison@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v9 2/3] kernel.h: add to_user_ptr()
Message-ID: <20160318082356.GF14170@phenom.ffwll.local>
References: <1458236486.9556.11.camel@perches.com>
 <20160317180523.GA2619@joana> <20160317184318.GA2611@joana>
 <1458246150.9556.17.camel@perches.com>
 <CAF6AEGvQa8SOWCtoEfcFAxz6MQ0Nqc-ktqNCdfJU-32-m-mCEQ@mail.gmail.com>
 <1458247207.9556.28.camel@perches.com>
 <CAF6AEGuzr2Vm_yngN7WcoeMLiiqb8B+kEBaNaPNqXdV2ZC-u-Q@mail.gmail.com>
 <1458249003.9556.30.camel@perches.com>
 <20160317211910.GB2611@joana>
 <1458250430.9556.39.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1458250430.9556.39.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2016 at 02:33:50PM -0700, Joe Perches wrote:
> On Thu, 2016-03-17 at 18:19 -0300, Gustavo Padovan wrote:
> > 2016-03-17 Joe Perches <joe@perches.com>:
> > > On Thu, 2016-03-17 at 16:50 -0400, Rob Clark wrote:
> > > > On Thu, Mar 17, 2016 at 4:40 PM, Joe Perches <joe@perches.com> wrote:
> > > []
> > > > > It's a name that seems like it should be a straightforward
> > > > > cast of a kernel pointer to a __user pointer like:
> > > > > 
> > > > > static inline void __user *to_user_ptr(void *p)
> > > > > {
> > > > >         return (void __user *)p;
> > > > > }
> > > > ahh, ok.  I guess I was used to using it in the context of ioctl
> > > > structs..  in that context u64 -> (void __user *) made more sense.
> > > > 
> > > > Maybe uapi_to_ptr()?  (ok, not super-creative.. maybe someone has a
> > > > better idea)
> > > Maybe u64_to_user_ptr?
> > That is a good name. If everyone agrees I can resend this patch
> > changing it to u64_to_user_ptr. Then should we still keep it on
> > kernel.h?
> 
> I've no particular opinion about location,
> but maybe compat.h might be appropriate.
> 
> Maybe add all variants:
> 
> 	void __user *u32_to_user_ptr(u32 val)
> 	void __user *u64_to_user_ptr(u64 val)
> 	u32 user_ptr_to_u32(void __user *p)
> 	u64 user_ptr_to_u64(void __user *p)
> 
> Maybe there's something about 32 bit userspace on
> 64 OS that should be done too.

Tbh I really don't think we should add 32bit variants and encourage the
mispractice of having 32bit user ptrs in ioctl structs and stuff. Anyway,
just my bikeshed on top ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
