Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCD461A0058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 01:42:28 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 126231402B8
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 01:42:25 +1000 (AEST)
Date: Thu, 9 Jul 2015 10:42:11 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
 Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
Message-ID: <20150709154211.GB2990@gate.crashing.org>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
 <1436322938.2658.60.camel@freescale.com>
 <20150708040455.GA9086@pale.ozlabs.ibm.com>
 <1436329328.2658.75.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436329328.2658.75.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2015 at 11:22:08PM -0500, Scott Wood wrote:
> > I agree about using labels, but "bcl 20,31,foo" is not the same thing
> > as "bl foo".  The former is a form of bl that doesn't perturb the link
> > stack and is therefore better for performance when you're not going to
> > do a matching blr later (not that performance is at all critical
> > here).
> 
> If performance mattered I would have complained about the extra mfmsr. :-)
> 
> I see that some other parts of the kernel are using that bcl instruction, but 
> if it is actually worthwhile in those places, it'd be nice to at least stick 
> it in a macro for readability...

How is that going to help?  It's just idiom; replacing it with some other
idiom only means people already used to the 20,31 thing (which is quite old
by now, btw.; 74xx days) will have to learn the new thing.

Unless you can think of a nice short name that can even be made an extended
mnemonic?


Segher
