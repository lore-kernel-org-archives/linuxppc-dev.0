Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E88F11A024F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 May 2014 12:48:31 +1000 (EST)
Message-ID: <1401331711.4930.7.camel@concordia>
Subject: Re: Kernel 3.15: Boot problems with a PA6T board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Thu, 29 May 2014 12:48:31 +1000
In-Reply-To: <5385C7A3.1080508@xenosoft.de>
References: <5366649E.4030102@xenosoft.de>
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>
 <1401107166.23096.1.camel@concordia> <53851AFA.5040504@xenosoft.de>
 <1401251015.5468.5.camel@concordia> <5385A3F4.8070004@xenosoft.de>
 <5385C7A3.1080508@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-05-28 at 13:25 +0200, Christian Zigotzky wrote:
> On 28.05.2014 10:53, Christian Zigotzky wrote:
> > Hi Michael,
> >
> > Thank you for your answer and thank you for your help. :-)
> >
> > On 28.05.2014 06:23, Michael Ellerman wrote:
> >> On Wed, 2014-05-28 at 01:08 +0200, Christian Zigotzky wrote:
> >>
> >> I'm going to guess that cd427485357c0c4b99f69719251baacf25946e11 is 
> >> BAD. Can
> >> you please confirm or deny that?
>
> > It's not BAD. It boots.

Hmm, interesting.

> >> If cd42748 is *good*, then you'll need to do a bigger bisect from 
> >> d8ff9cd to
> >> 18a1a7a.

> OK :-)
> 
> -> git clone 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux2-git
> -> git bisect start
> -> git bisect good d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b
> -> git bisect bad 18a1a7a1d862ae0794a0179473d08a414dd49234
> 
> Output:
> Bisecting: 5900 revisions left to test after this (roughly 13 steps)
> [cb1595563880a81dab6eab9a5ecb4520d2e76077] Merge tag 'tty-3.15-rc1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> 
> Unfortunately it doesn't boot. :-(

OK. So you do:

$ git bisect bad

And it will pick a new commit for you to test. Repeat that ~13 times and you
should have identified the bad commit.

cheers
