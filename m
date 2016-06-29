Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfP1m0FVBzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 10:39:08 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c74so3052598pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 17:39:07 -0700 (PDT)
Date: Wed, 29 Jun 2016 10:38:52 +1000
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, robh@kernel.org, arnd@arndb.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [V4, 2/3] powerpc/opal: Add #define to get rc from an
 ASYNC_COMP opal_msg
Message-ID: <20160629103852.17ffdd59@dyn253.ozlabs.ibm.com>
In-Reply-To: <3rf48446rPz9sD5@ozlabs.org>
References: <1467088857-14477-2-git-send-email-sjitindarsingh@gmail.com>
 <3rf48446rPz9sD5@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2016 21:58:28 +1000 (AEST)
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Tue, 2016-28-06 at 04:40:56 UTC, Suraj Jitindar Singh wrote:
> > An opal_msg of type OPAL_MSG_ASYNC_COMP contains the return code in
> > the params[1] struct member. However this isn't intuitive or
> > obvious when reading the code and requires that a user look at the
> > skiboot documentation or opal-api.h to verify this.
> > 
> > Add a #define to get the return code from an opal_msg and update
> > call sites accordingly.  
> 
> Thanks for cleaning this up.
> 
> Two gripes though :)
> 
> >  arch/powerpc/include/asm/opal-api.h            | 4 ++++  
> 
> opal-api.h is supposed to be a subset of the skiboot version.
> 
> So something like this should go in the kernel's opal.h, which has
> all the kernel prototypes etc. which aren't part of the OPAL API. I
> think this routine should fall under that.
Will move this
> 
> > diff --git a/arch/powerpc/include/asm/opal-api.h
> > b/arch/powerpc/include/asm/opal-api.h index 9bb8ddf..7433cf0 100644
> > --- a/arch/powerpc/include/asm/opal-api.h
> > +++ b/arch/powerpc/include/asm/opal-api.h
> > @@ -387,6 +387,10 @@ struct opal_msg {
> >  	__be64 params[8];
> >  };
> >  
> > +#define GET_OPAL_MSG_ASYNC_COMP_RC(msg)	(msg.msg_type ==
> > OPAL_MSG_ASYNC_COMP ? \
> > +
> > be64_to_cpu(msg.params[1]) : \
> > +					OPAL_PARAMETER)
> > +  
> 
> You forgot the 7th commandment!
> 
>  "Never use a #define when a static inline would work"
> 
> :)
> 
> A few reasons:
>   - it's less shouty.
>   - you get type checking.
>   - you don't have to wrap lines with \
>     etc.
> 
> cheers
Thanks, will change this
