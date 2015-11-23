Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B38801A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 14:20:51 +1100 (AEDT)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29BCB140297
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 14:20:51 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so177053408pac.3
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Nov 2015 19:20:49 -0800 (PST)
Date: Mon, 23 Nov 2015 14:20:39 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Cc: anton@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/8] powerpc: Explicitly disable math features when
 copying thread
Message-ID: <20151123142039.3416245a@camb691>
In-Reply-To: <1448240918.3061.6.camel@neuling.org>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-5-git-send-email-cyrilbur@gmail.com>
 <1448240918.3061.6.camel@neuling.org>
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

On Mon, 23 Nov 2015 12:08:38 +1100
Michael Neuling <mikey@neuling.org> wrote:

> On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> > With threads leaving the math bits enabled in their saved MSR to
> > indicate
> > that the hardware is hot and a restore is not needed, children need
> > to turn
> > it off as when they do get scheduled, there's no way their registers
> > could
> > have been hot.
> > 
> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> > ---
> >  arch/powerpc/kernel/process.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/kernel/process.c
> > b/arch/powerpc/kernel/process.c
> > index 398f7bf..441d9e5 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1243,6 +1243,7 @@ int copy_thread(unsigned long clone_flags,
> > unsigned long usp,
> >  
> >  		f = ret_from_fork;
> >  	}
> > +	childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);  
> 
> Is this a current bug? 
> 

It is impossible currently because saving the registers (of the parent, before
the creating the child) also forces a giveup of the facilities.

The next patch in the series decouples the saving and the giving up which
makes this situation possible.

> Mikey
> 
> >  	sp -= STACK_FRAME_OVERHEAD;
> >  
> >  	/*  
