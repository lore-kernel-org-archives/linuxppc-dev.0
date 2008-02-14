Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E109DDFBF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 08:26:23 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1ELQG67024965
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 16:26:16 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1ELQEa8124218
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 14:26:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1ELQEvh022471
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 14:26:14 -0700
Date: Thu, 14 Feb 2008 15:24:48 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 0/4]: Respun LMB patches.
Message-ID: <20080214152448.49c69238@zod.rchland.ibm.com>
In-Reply-To: <38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
References: <20080213.170938.34536425.davem@davemloft.net>
	<38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Feb 2008 14:58:22 -0600
Becky Bruce <becky.bruce@freescale.com> wrote:

> 
> On Feb 13, 2008, at 7:09 PM, David Miller wrote:
> 
> >
> > I've taken into consideration the various feedback, and
> > ported the bug fix and other LMB patches posted recently
> > in an effort to keep the patch churn by others down wrt.
> > my moving of these files.
> >
> > 1) Use HAVE_LMB as suggested by Sam.
> >
> > 2) Fix potential build errors wrt. asm/prom.h dependencies.
> >
> >    My algorithm was:
> >
> >    a) If the file only included asm/lmb.h I added an include
> >       of both linux/lmb.c and asm/prom.h
> >
> >    b) If the file already includes asm/prom.h, I merely
> >       changed the asm/lmb.h to linux/lmb.h
> >
> >    Header include mimimizations can be done as followon patches.
> >
> > 3) Integrate Kumar Gala's initial region fix.
> >
> > 4) Integrate Becky Bruce's large physical addressing change,
> >    but using u64 instead of phys_addr_t.
> >
> > It's all at:
> >
> > 	master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git
> >
> > like before.
> 
> 
> Thanks for picking up the patches from Kumar and myself and fitting  
> them into your series - this is much appreciated.  FYI, I applied the  
> entire patch series to my local tree and test-booted both mpc8641 and  
> mpc8568mds and both build and boot cleanly. I also built pasemi and  
> ebony, those build cleanly as well.

I plan on actually testing this on Ebony, Walnut, and Bamboo either
later tonight or tomorrow.  I don't expect many issues.

Dave, those above boards would cover the build of PowerPC 4xx CPU cores.
Just an FYI.

josh
