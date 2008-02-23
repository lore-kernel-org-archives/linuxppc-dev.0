Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 6495BDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 11:30:30 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so618095pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 16:30:29 -0800 (PST)
Date: Fri, 22 Feb 2008 18:30:25 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: MODPOST section mismatches
Message-ID: <20080222183025.280b6ea3@vader.jdub.homelinux.org>
In-Reply-To: <20080222230722.B7FDBDDE45@ozlabs.org>
References: <20080221213313.97814DDF55@ozlabs.org>
	<20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<20080222222637.C82EADDF0F@ozlabs.org>
	<20080222163625.29433d12@weaponx>
	<20080222230722.B7FDBDDE45@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 18:07:37 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> At 05:36 PM 2/22/2008, you wrote:
> >On Fri, 22 Feb 2008 17:26:52 -0500
> >Steve Heflin <sheflin@newagemicro.com> wrote:
> >
> > > FLAT_MEM is one of the configuration options:
> > >        CONFIG_ARCH_FLATMEM_ENABLE=y
> >
> >That has to do with NUMA stuff.  It really doesn't have much bearing on
> >the section warnings.
> 
> ah, thanks for setting me straight. I thought it meant that 
> everything existed in a flat address space and existed in memory at 
> the same time, and therefore the different section warnings might not apply. 

Nah.  The section warnings come about because if something is marked
__init but referenced in a function that isn't then an oops could occur
because the __init sections are discarded after a certain point in the
kernel boot.  The same is true for __devinit, etc.

So the section warnings are still bugs that need fixing, but they're
orthogonal to the memory model for the most part.

josh
