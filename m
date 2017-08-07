Return-Path: <srs0=jf/o=7j=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQtxf2fTCzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:27:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xQtxf1fDQz8tPg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 20:27:02 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xQtxd49m7z9sR9
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2017 20:27:01 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id j68so37371pfc.2
 for <linuxppc-dev@ozlabs.org>; Mon, 07 Aug 2017 03:27:00 -0700 (PDT)
Date: Mon, 7 Aug 2017 20:26:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
Message-ID: <20170807202638.4239c2d4@roar.ozlabs.ibm.com>
In-Reply-To: <877eyfpupf.fsf@concordia.ellerman.id.au>
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 <877eyjkt0u.fsf@linux-m68k.org>
 <20170805233917.72e49d2f@roar.ozlabs.ibm.com>
 <877eyfpupf.fsf@concordia.ellerman.id.au>
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

On Mon, 07 Aug 2017 19:56:28 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Fri, 04 Aug 2017 21:54:57 +0200
> > Andreas Schwab <schwab@linux-m68k.org> wrote:
> >  
> >> No, this is really a 4.13-rc1 regression.
> >> 
> >> Andreas.
> >>   
> >
> > SLB miss with MSR[RI]=0 on
> >
> > lbz     r0,THREAD+THREAD_LOAD_FP(r7)
> >
> > Caused by bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f  
> 
> Ah of course. Not sure why I haven't seen it in any of my testing :/
> 
> > Hmm, I'll see if something can be done, but that MSR_RI stuff in syscall
> > exit makes things fairly difficult (and will reduce performance improvement
> > of this patch anyway).
> >
> > I'm trying to work to a point where we have a soft-RI bit for these kinds of
> > uses that would avoid all this complexity. Until then it may be best to
> > just revert this patch.  
> 
> OK. Let me know in the next day or two what you want to do.
> 
> One option would be to load THREAD_LOAD_FP/THREAD_LOAD_VEC before we
> turn off RI.

Yeah, although that's a couple of unnecessary loads when we haven't
used the fp regs.

This path hits often on return from context switch, but for general
syscalls it's less clear. And considering it's fairly tricky code at
this point I'm thinking maybe just revert it for now?

Thanks,
Nick
