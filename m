Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 490A81A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 15:57:00 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6E93F1402CD
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2016 15:56:59 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id q129so5863643pfb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Mar 2016 20:56:59 -0800 (PST)
Date: Wed, 2 Mar 2016 15:56:46 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Michael Neuling
 <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V10 02/28] powerpc, process: Add the function
 flush_tmregs_to_thread
Message-ID: <20160302155646.212070ff@camb691>
In-Reply-To: <56D66C12.9090205@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455613198-5113-3-git-send-email-khandual@linux.vnet.ibm.com>
 <20160302111500.7b50fac9@camb691>
 <56D66C12.9090205@linux.vnet.ibm.com>
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

On Wed, 02 Mar 2016 09:59:06 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 03/02/2016 05:45 AM, Cyril Bur wrote:
> > On Tue, 16 Feb 2016 14:29:32 +0530
> > Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> >   
> >> This patch creates a function flush_tmregs_to_thread which
> >> will then be used by subsequent patches in this series. The
> >> function checks for self tracing ptrace interface attempts
> >> while in the TM context and logs appropriate warning message.
> >>  
> > 
> > Hi Anshuman,
> > 
> > You'll have to bare with me, my ptrace knowledge is non existent so you might
> > have to walk me though some aspects.
> > 
> > I have been playing with FPU/VMX and VSX saving so I thought I'd take a look.  
> 
> Sure.
> 
> 
> >   
> >> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/switch_to.h |  8 ++++++++
> >>  arch/powerpc/kernel/process.c        | 20 ++++++++++++++++++++
> >>  2 files changed, 28 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> >> index 5b268b6..7b297bf 100644
> >> --- a/arch/powerpc/include/asm/switch_to.h
> >> +++ b/arch/powerpc/include/asm/switch_to.h
> >> @@ -70,6 +70,14 @@ static inline void disable_kernel_spe(void)
> >>  }
> >>  #endif
> >>  
> >> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >> +extern void flush_tmregs_to_thread(struct task_struct *);
> >> +#else
> >> +static inline void flush_tmregs_to_thread(struct task_struct *t)
> >> +{
> >> +}
> >> +#endif
> >> +
> >>  static inline void clear_task_ebb(struct task_struct *t)
> >>  {
> >>  #ifdef CONFIG_PPC_BOOK3S_64
> >> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> >> index dccc87e..2c4fa7f 100644
> >> --- a/arch/powerpc/kernel/process.c
> >> +++ b/arch/powerpc/kernel/process.c
> >> @@ -918,6 +918,26 @@ static inline void restore_sprs(struct thread_struct *old_thread,
> >>  #endif
> >>  }
> >>    
> > 
> > 
> >   
> >> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >> +void flush_tmregs_to_thread(struct task_struct *tsk)
> >> +{
> >> +	/*
> >> +	 * Process self tracing is not yet supported through
> >> +	 * ptrace interface. Ptrace generic code should have
> >> +	 * prevented this from happening in the first place.
> >> +	 * Warn once here with the message, if some how it
> >> +	 * is attempted.
> >> +	 */
> >> +	WARN_ONCE(tsk == current,
> >> +		"Not expecting ptrace on self: TM regs may be incorrect\n");
> >> +
> >> +	/*
> >> +	 * If task is not current, it should have been flushed
> >> +	 * already to it's thread_struct during __switch_to().
> >> +	 */  
> > 
> > I totally agree except this highlights something that I notice in subsequent
> > patches, and existing code. All the *_{get,set}() functions call
> > flush_*_to_thread() when, as per your comment (and my understanding of task
> > switching) there really shouldn't be a need to do that. My only thought is that
> > this could be a relic of uniprocessor days when it would have been necessary but
> > Anton recently stripped that out. Are you able to shed some light here?  
> 
> Its been sometime I had looked into this aspect of the series. I remember
> Michael Neuling and myself discussed about this and settled on a single
> WARN_ON here as nothing else was required to be done in the function. It
> may be possible that all the flush_*_to_thread() functions used else where
> are because of uniprocessor concerns. I dont understand completely our
> context save/restore paths including the lazy ones. I believed that these
> flush_*_to_thread() routines just made sure task struct has the latest
> values of the thread context in case of some complicated save/restore
> paths might not have done the complete save at that point in time.
> 

Well as you note in the comment though, it should be done since we've gone
through __switch_to()...

> If you think that all these flush_*_to_thread() functions used through
> out POWER ptrace need review to see whether they are required or not
> anymore I would suggest we should do it as a separate patch after this
> series and I am willing to work with you on that.

I THINK your patches are correct and we're just performing needless
flush_*_to_thread() calls now in which case its fine and we can review laster,
my concern is that I've been wrong before so having flush_tmregs_to_thread() do
nothing worries me. I wonder if Mr Neuling or Mr Ellerman have anything to say
on the subject...

> 
> > 
> > The reason I ask is that if the flush_*_to_thread() calls ARE actually
> > important then I worry that this function is inadequate...  
> 
> I guess we went through that and finally settled on WARN_ON once but dont
> remember the exact context now. Will look into all previous discussions
> on this and get back.

Thanks,

Cyril
> 
