Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E301BB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 23:18:21 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] viotape: Fix memory and semaphore leak
Date: Thu, 13 Aug 2009 15:18:07 +0200
References: <200907181506.33499.mb@bu3sch.de>
	<1250139603.3587.106.camel@pasglop>
In-Reply-To: <1250139603.3587.106.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200908131518.07707.mb@bu3sch.de>
Cc: Dave Boutcher <boutcher@us.ibm.com>, Ryan Arnold <ryanarn@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Colin Devilbiss <devilbis@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 13 August 2009 07:00:03 Benjamin Herrenschmidt wrote:
> On Sat, 2009-07-18 at 15:06 +0200, Michael Buesch wrote:
> > This patch fixes a memory and semaphore leak in the viotape driver's
> > char device write op. It leaks the DMA memory and the semaphore lock
> > in case the device was opened with O_NONBLOCK.
> > 
> > This patch is only compile tested, because I do not have the hardware.
> > 
> > Signed-off-by: Michael Buesch <mb@bu3sch.de>
> 
> (going trough my backlog ...)
> 
> Thanks Michael, but I don't think that's right...
> 
> IE. We aren't waiting for the write to complete, which means that it can
> be happening asynchronously, thus we must not free the DMA memory until
> it has actually complete.
> 
> Now, if you look at vioHandleTapeEvent(), it does appear that when the
> completion happens, the DMA memory will eventually be released and the
> mutex up'ed. 
> 
> Or am I missing something ?

I think you are right.


-- 
Greetings, Michael.
