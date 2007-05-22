Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id B4373DDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 20:02:21 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 22 May 2007 12:02:12 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fsl booke MM vs. SMP questions
Message-ID: <20070522100212.GA13225@iram.es>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<20070522084645.GA12009@iram.es>
	<1179825278.32247.827.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179825278.32247.827.camel@localhost.localdomain>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Dave Liu <r63238@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 07:14:38PM +1000, Benjamin Herrenschmidt wrote:
> > Why do you want to clear the reservation here? 
> > 
> > Coming out of some code path with the reservation still held 
> > can only affect buggy code (someone doing st[dw]cx. before 
> > l[dw]arx) AFAIK.
> 
> And buggy CPUs :-)
> 
> Seriously, lots of CPU implementations don't test the address for local
> lwarx stwcx. so if your kernel code "replaces" a reservation with
> another that is left set, the userland stwcx. might well succeed which
> is bogus.
> 

Well, there should always be an stwcx. to clear reservation before
any interrupt return. Otherwise you'll be able to cause hard to
reproduce bugs in the interrupted code.

Checking or not that the reservation address matches the stwcx.
is irrelevant.

	Gabriel
