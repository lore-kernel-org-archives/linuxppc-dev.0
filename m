Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTRfr3pRBzDqb7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 09:07:48 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id h64so7447778pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 16:07:48 -0700 (PDT)
Date: Fri, 19 May 2017 09:07:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-am33-list@redhat.com,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 uobergfe@redhat.com
Subject: Re: [RFC] arch hardlockup detector interfaces improvement
Message-ID: <20170519090731.1e49cd0d@roar.ozlabs.ibm.com>
In-Reply-To: <20170518163028.tf2llimuo4l4l5nv@redhat.com>
References: <20170518155026.23799-1-npiggin@gmail.com>
 <20170518163028.tf2llimuo4l4l5nv@redhat.com>
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

On Thu, 18 May 2017 12:30:28 -0400
Don Zickus <dzickus@redhat.com> wrote:

> (adding Uli)
> 
> On Fri, May 19, 2017 at 01:50:26AM +1000, Nicholas Piggin wrote:
> > I'd like to make it easier for architectures that have their own NMI /
> > hard lockup detector to reuse various configuration interfaces that are
> > provided by generic detectors (cmdline, sysctl, suspend/resume calls).
> > 
> > I'd also like to remove the dependency of arch hard lockup detectors
> > on the softlockup detector. The reason being these watchdogs can be
> > very small (sparc's is like a page of core code that does not use any
> > big subsystem like kthreads or timers).
> > 
> > So I do this by adding a separate CONFIG_SOFTLOCKUP_DETECTOR, and
> > juggling around what goes under config options. HAVE_NMI_WATCHDOG
> > continues to be the config for arch to override the hard lockup
> > detector, which is expanded to cover a few more cases.  
> 
> Basically you are trying to remove the heavy HARDLOCKUP pieces to minimize
> the SOFTLOCKUP piece and use your own NMI detector, right?
> 
> I am guessing you would then disable SOFTLOCKUP to remove all the kthread
> and timer stuff but continue to use the generic infrastructure to help
> manager your own NMI detector?

Yes that's right.

> A lot of the code is just re-organizing things and adding an explicit
> ifdef on SOFTLOCKUP, which seems fine to me.
> 
> I just need to spend some time on some of your #else clauses to see what
> functionality is dropped when you use your approach.

Okay, appreciated. I can trim down cc lists and send you my powerpc
WIP if you'd like to have a look.

Thanks,
Nick
