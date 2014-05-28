Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBA411A024E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 14:23:35 +1000 (EST)
Message-ID: <1401251015.5468.5.camel@concordia>
Subject: Re: Kernel 3.15: Boot problems with a PA6T board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 28 May 2014 14:23:35 +1000
In-Reply-To: <53851AFA.5040504@xenosoft.de>
References: <5366649E.4030102@xenosoft.de>
 <1399268891.4600.3.camel@concordia> <53720AAC.1000100@xenosoft.de>
 <1401107166.23096.1.camel@concordia> <53851AFA.5040504@xenosoft.de>
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

On Wed, 2014-05-28 at 01:08 +0200, Christian Zigotzky wrote:
> Hi Michael,
> 
> Thanks a lot for your answer.
> 
> ...
>
> 18a1a7a1d862ae0794a0179473d08a414dd49234 <- It doesn't boot. Error messages: Oops: Machine check, sig: 7 [#1] CPU: 1 PID: 1 Comm: swapper/0 not tainted
> d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b <- It boots. :-)
> 0f5a869600141a0d5575e3190af01a050c081b07 <- It boots. :-)
> c7e64b9ce04aa2e3fad7396d92b5cb92056d16ac <- It boots. :-)
> d3e144532703fe2454b56eddb56f30d2d620187b <- It boots. :-)
> 
> I think the machine check is the problem.

Yes I think it is. Do you get any more info, or just that one line?

So I think the latest working commit we have is d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b.

I'm going to guess that cd427485357c0c4b99f69719251baacf25946e11 is BAD. Can
you please confirm or deny that?

Assuming cd42748 is bad, you should do a git bisect between it and 18a1a7a.
That should be a fairly quick bisect. That would be:

$ git bisect start
$ git bisect good d8ff9cdf68fd119d491f3de90e1a612afc2f3b2b
$ git bisect bad  cd427485357c0c4b99f69719251baacf25946e11

If cd42748 is *good*, then you'll need to do a bigger bisect from d8ff9cd to
18a1a7a.


cheers
