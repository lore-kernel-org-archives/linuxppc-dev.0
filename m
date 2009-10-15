Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6FFE6B7B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 05:42:16 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n9FIfdCx179148
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 18:41:44 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9FIfTBo1482916
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:41:29 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9FIfSG5002398
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 19:41:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
Date: Thu, 15 Oct 2009 20:41:26 +0200
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910151305.47100.borntraeger@de.ibm.com>
	<20091015160906.GA3730@loki.buserror.net>
In-Reply-To: <20091015160906.GA3730@loki.buserror.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910152041.26646.borntraeger@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, brueckner@linux.vnet.ibm.com,
	Timur Tabi <timur@freescale.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag 15 Oktober 2009 18:09:06 schrieb Scott Wood:
> On Thu, Oct 15, 2009 at 01:05:47PM +0200, Christian Borntraeger wrote:
> > The fact that struct console->write returns void indicates that the
> > console layer is not interested in errors. We have two policies we can
> > implement:
> >
> > 1. drop console messages if case of congestion but keep the system going
> > 2. dont drop messages and wait, even if the system might come to a
> > complete stop
> >
> > Looking at drivers/char/vt.c
> >         /* console busy or not yet initialized */
> >         if (!printable)
> >                 return;
> >         if (!spin_trylock(&printing_lock))
> >                 return;
> > could mean that  Linux consoles should not block.
> 
> That's a bit different -- the code above is testing for potential deadlocks
> within Linux (or a not-yet-initialized console), not a device that has yet
> to process the last batch of characters we threw at it.  Plus, given the
> "console must be locked when we get here" comment, I'm not sure that you'll
> ever see contention on printing_lock?
> 
> Serial consoles currently block when waiting for the buffer to drain:

Right. Looking at more drivers it seems that both ways (waiting and dropping) 
are used.

Hmmm, if we are ok with having both options, we should let the hvc backend 
decide if it wants to drain or to discard.

If we just busy loop, it actually does not matter how we let hvc_console react 
on 0, as long as we adopt all backends to use that interface consistent.

On the other hand, backends might want to do special magic on congestion so I 
personally tend to let the backend loop instead of hvc_console. But I am really  
not sure.

Christian
