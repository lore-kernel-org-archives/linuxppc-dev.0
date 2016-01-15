Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A8851A17FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 16:54:25 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8B9F1140328
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:54:24 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n128so8152374pfn.3
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 21:54:24 -0800 (PST)
Date: Fri, 15 Jan 2016 16:54:16 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 4/8] powerpc: Explicitly disable math features when
 copying thread
Message-ID: <20160115165416.2f7328ae@camb691>
In-Reply-To: <1452836542.25634.33.camel@neuling.org>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-5-git-send-email-cyrilbur@gmail.com>
 <1452836542.25634.33.camel@neuling.org>
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

On Fri, 15 Jan 2016 16:42:22 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:
> > With threads leaving the math bits enabled in their saved MSR to indicate
> > that the hardware is hot and a restore is not needed, children need to turn
> > it off as when they do get scheduled, there's no way their registers could
> > have been hot.  
> 
> Is this a bug in the current code?
> 

You're very consistent:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-November/136469.html

;)

> Mikey
> 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  arch/powerpc/kernel/process.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/kernel/process.c
> > b/arch/powerpc/kernel/process.c
> > index dccc87e..e0c3d2d 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags,
> > unsigned long usp,
> >  
> >  		f = ret_from_fork;
> >  	}
> > +	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
> >  	sp -= STACK_FRAME_OVERHEAD;
> >  
> >  	/*  
