Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0003.hostedemail.com
 [216.40.44.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR1nh4BjTzDqyw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 08:34:00 +1100 (AEDT)
Message-ID: <1458250430.9556.39.camel@perches.com>
Subject: Re: [PATCH v9 2/3] kernel.h: add to_user_ptr()
From: Joe Perches <joe@perches.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Rob Clark <robdclark@gmail.com>, Gustavo Padovan
 <gustavo.padovan@collabora.co.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Daniel
 Stone <daniels@collabora.com>,  Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?=
 <arve@android.com>, Riley Andrews <riandrews@android.com>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Greg Hackmann <ghackmann@google.com>, John
 Harrison <John.C.Harrison@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>,  David Airlie <airlied@linux.ie>, Daniel
 Vetter <daniel.vetter@intel.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 17 Mar 2016 14:33:50 -0700
In-Reply-To: <20160317211910.GB2611@joana>
References: <1458235817-28375-1-git-send-email-gustavo@padovan.org>
 <1458235817-28375-2-git-send-email-gustavo@padovan.org>
 <1458236486.9556.11.camel@perches.com> <20160317180523.GA2619@joana>
 <20160317184318.GA2611@joana> <1458246150.9556.17.camel@perches.com>
 <CAF6AEGvQa8SOWCtoEfcFAxz6MQ0Nqc-ktqNCdfJU-32-m-mCEQ@mail.gmail.com>
 <1458247207.9556.28.camel@perches.com>
 <CAF6AEGuzr2Vm_yngN7WcoeMLiiqb8B+kEBaNaPNqXdV2ZC-u-Q@mail.gmail.com>
 <1458249003.9556.30.camel@perches.com> <20160317211910.GB2611@joana>
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

On Thu, 2016-03-17 at 18:19 -0300, Gustavo Padovan wrote:
> 2016-03-17 Joe Perches <joe@perches.com>:
> > On Thu, 2016-03-17 at 16:50 -0400, Rob Clark wrote:
> > > On Thu, Mar 17, 2016 at 4:40 PM, Joe Perches <joe@perches.com> wrote:
> > []
> > > > It's a name that seems like it should be a straightforward
> > > > cast of a kernel pointer to a __user pointer like:
> > > > 
> > > > static inline void __user *to_user_ptr(void *p)
> > > > {
> > > >         return (void __user *)p;
> > > > }
> > > ahh, ok.  I guess I was used to using it in the context of ioctl
> > > structs..  in that context u64 -> (void __user *) made more sense.
> > > 
> > > Maybe uapi_to_ptr()?  (ok, not super-creative.. maybe someone has a
> > > better idea)
> > Maybe u64_to_user_ptr?
> That is a good name. If everyone agrees I can resend this patch
> changing it to u64_to_user_ptr. Then should we still keep it on
> kernel.h?

I've no particular opinion about location,
but maybe compat.h might be appropriate.

Maybe add all variants:

	void __user *u32_to_user_ptr(u32 val)
	void __user *u64_to_user_ptr(u64 val)
	u32 user_ptr_to_u32(void __user *p)
	u64 user_ptr_to_u64(void __user *p)

Maybe there's something about 32 bit userspace on
64 OS that should be done too.
