Return-Path: <dsterba@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B6lY20qpzF2BN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 23:34:39 +1100 (AEDT)
Date: Wed, 28 Mar 2018 14:32:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.16: Reported regressions as of Tuesday, 2018-03-27 (Was:
 Linux 4.16-rc7)
Message-ID: <20180328123205.GF30422@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CA+55aFxpxHnWBeTXN+DKqwCMW_=T2cR8UxSBVk_6c8LL7Et5JQ@mail.gmail.com>
 <d1f5b976-f293-5767-9faf-c4f569f8ba55@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d1f5b976-f293-5767-9faf-c4f569f8ba55@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 09:13:32PM +0200, Thorsten Leemhuis wrote:
> On 26.03.2018 01:37, Linus Torvalds wrote:
> > […] Anyway. Go out and test. And let's hope next week is nice and calm and
> > I can release the final 4.16 next Sunday without any extra  rc's.
> > 
> >                Linus
> 
> Hi! Find below my sixth regression report for Linux 4.16. It lists 7
> regressions I'm currently aware of. 2 were fixed since last weeks
> report; 2 are new.
> 
> Are you aware of any other regressions that got introduced this
> development cycle? Then please let me know by mail (a simple bounce or
> forward to the sender of this email address is enough!). And please tell
> me if there is anything in the report that shouldn't be there.
> 
> Ciao, Thorsten
> 
> == Current regressions ==
> 
> Dell R640 does not boot due to SCSI/SATA failure
> - Status: Afaics still unfixed; lost track, ask reporter for an update
> on Monday morning, no reply yet
> - Cause:  https://git.kernel.org/torvalds/c/84676c1f21e8
> - Reported: 2018-02-22
> https://marc.info/?l=linux-kernel&m=151931128006031
> - Note: Issue understood and even (kind of accidentally) fixed by a
> patch series that was proposed for 4.17 (see links)
> - Last known developer activity: 2018-03-14
> https://marc.info/?l=linux-block&m=152102086831636&w=2
> - Other relevant links:
> https://marc.info/?l=linux-block&m=152051511802229&w=2
> https://marc.info/?l=linux-kernel&m=152026091325037

I'm not the original reporter but I can confirm this regression has been
fixed by git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git
scsi-fixes (tag 0c30612d535460af7fe16e7e6ed8b97defe4adbe)

The machine has a HP array and stopped booting some time around rc1. I
tried to bisect it and in the end it was the commit 84676c1f21e8 that I
reverted for testing builds, so I'm sure it's the same issue as you've
been tracking.
