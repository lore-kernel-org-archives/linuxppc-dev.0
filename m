Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5793367B77
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 19:34:59 +1100 (EST)
Date: Wed, 13 Dec 2006 11:35:05 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] cpm2: Updates for CPM2 pic
Message-ID: <20061213113505.6d5d90fd@vitb.ru.mvista.com>
In-Reply-To: <A55328DA-0FC7-4334-B300-B853B9050773@kernel.crashing.org>
References: <20061212012641.5ef493f7@localhost.localdomain>
	<20061211223659.20169.50415.stgit@localhost.localdomain>
	<CB3BCBF7-D800-4438-A7D5-3798C56F9720@kernel.crashing.org>
	<20061212215509.696cccf8@vitb.ru.mvista.com>
	<A55328DA-0FC7-4334-B300-B853B9050773@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 Dec 2006 13:58:44 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Dec 12, 2006, at 12:55 PM, Vitaly Bordug wrote:
> 
> > On Mon, 11 Dec 2006 20:21:52 -0600
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >>
> >> On Dec 11, 2006, at 4:36 PM, Vitaly Bordug wrote:
> >>
> >>>
> >>> This contains important fixes for the CPM2 PIC code. Eliminated
> >>> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
> >>> interrupt
> >>> mapping. Updated devicetree files to reflect that. Changed direct
> >>> IC-related IO accesses to the IO accessors.
> >>
> >> Since your changing the interrupt numbers, do you mind changing the
> >> interrupt sense to match ipic?  I was hoping to introduce a generic
> >> host_xlate function to cover the various embedded pic's.
> > Umm, can you pls elaborate what do you want to achieve?
> 
> Its a minor thing, but the values we picked for ipic to encode sense/ 
> polarity match the linux definitions.  The idea is that  if we use  
> the same encoding on multiple pic's we can sure the host_xlate code.
> 
I started it but faced with the problem:

in 8560, there are both mpic and cpm2 pic. To keep consistency (so that cpm irqs encode sence one way, and generic - mpic -  in another), we'll have to modify mpic too, and all the 85xx dts's as well. 

Yet doable, it's pretty big change, and I think it should be put to the patch, independent of small fixes I have introduced, and that should come separately (or else we'll have hard time git-bisecting for troubles).

If you envision this way as a proper one for mpic too, I'll head for it though.

-- 
Sincerely, 
Vitaly
