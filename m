Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id 81A9BDE02E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:03:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so516960anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Apr 2008 05:03:36 -0700 (PDT)
Subject: Re: [kvm-ppc-devel] [PATCH] Add idle power save for ppc 4xx
From: Josh Boyer <jwboyer@gmail.com>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <11F8A893-409D-4449-9DAB-BF248045E6D9@pobox.com>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<1206987598.9165.10.camel@thinkpadL>
	<1207011862.7490.5.camel@concordia.ozlabs.ibm.com>
	<1207019732.12155.81.camel@vader.jdub.homelinux.org>
	<11F8A893-409D-4449-9DAB-BF248045E6D9@pobox.com>
Content-Type: text/plain
Date: Tue, 01 Apr 2008 07:03:26 -0500
Message-Id: <1207051406.12155.88.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-04-01 at 08:01 -0400, Jimi Xenidis wrote:
> On Mar 31, 2008, at 11:15 PM, Josh Boyer wrote:
> 
> > On Tue, 2008-04-01 at 12:04 +1100, Michael Ellerman wrote:
> >>>>> I'm assuming you pass a dtb to the virtual guest when you start  
> >>>>> it up.
> >>>>> Could you define a property in the CPU node there that can be  
> >>>>> parsed to
> >>>>> use the power_save function instead of always making it the  
> >>>>> default?
> >>>>
> >>>> Actually, you probably don't want this as a property in the device
> >>>> tree.  It doesn't describe hardware.  A Kconfig option might be
> >>>> warranted though.
> >>>
> >>> I'll go with the Kconfig option.
> >>
> >> Go with a device-tree check. The pseries kernel supports both bare- 
> >> metal
> >> and hypervisor in the same kernel image, and it works out which it's
> >> running on by looking at the device-tree. This seems equivalent to  
> >> me?
> >
> > After some back and forth on IRC, we decided on that as well.  I love
> > being right, then wrong, then right again.
> 
> Awesome, can you summarize for the rest of us?

A node or property will be in the device tree that the guests can use to
determine if it's running under a hypervisor or not.

The details are yet to be worked out, so there isn't much more of a
summary yet.  There was also some conversation about having an "idle="
kernel parameter similar to the PA-Semi port that would allow toggling
of it as well.

josh
