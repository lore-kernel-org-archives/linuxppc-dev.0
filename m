Return-Path: <ananth@in.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62AC1DDF32
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 17:10:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3I7AAHW029881
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 03:10:10 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3I7AA3Q163800
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:10:10 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3I7A8mF019827
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 01:10:09 -0600
Date: Wed, 18 Apr 2007 12:43:49 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Emulate more instructions in software
Message-ID: <20070418071349.GA11729@in.ibm.com>
References: <20070418055638.GA16650@in.ibm.com>
	<4F8C7783-242E-4254-A8AD-A8452C7B248C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F8C7783-242E-4254-A8AD-A8452C7B248C@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2007 at 01:11:00AM -0500, Kumar Gala wrote:
> 
> On Apr 18, 2007, at 12:56 AM, Ananth N Mavinakayanahalli wrote:
> 
> > Emulate a few more instructions in software - especially useful during
> > singlestepping (xmon/kprobes).
> >
> > Instructions emulated with this patch are mfcr/mtcr rX, mfxer/mtxer  
> > rX,
> > mflr/mtlr rX, mfctr/mtctr rX and mr rA,rB.
> >
> >
> > Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> When do we actually need to emulate any of these instructions?  I  
> don't see why single stepping would effect the ability to execute  
> these instructions.

In cases when these instructions are kprobed, it'd be possible to
eliminate the single step exception as we can emulate them.

Most usecases of kprobes are at function entry and in most cases, the
instruction at function entry is mflr r0, which can be emulated. So you
can get rid of one exception and get a nice speedup too. My other patch
did just this.

Ananth
