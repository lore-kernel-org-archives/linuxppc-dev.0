Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DE31A1D6E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 06:42:34 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 87DB6140273
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2015 06:42:33 +1000 (AEST)
Message-ID: <1436473657.2658.126.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/kexec: Reset secondary cpu endianess before
 kexec
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>, "Samuel
 Mendoza-Jonas" <sam.mj@au1.ibm.com>
Date: Thu, 9 Jul 2015 15:27:37 -0500
In-Reply-To: <20150709154211.GB2990@gate.crashing.org>
References: <1436318605-13031-1-git-send-email-sam.mj@au1.ibm.com>
 <1436322938.2658.60.camel@freescale.com>
 <20150708040455.GA9086@pale.ozlabs.ibm.com>
 <1436329328.2658.75.camel@freescale.com>
 <20150709154211.GB2990@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-09 at 10:42 -0500, Segher Boessenkool wrote:
> On Tue, Jul 07, 2015 at 11:22:08PM -0500, Scott Wood wrote:
> > > I agree about using labels, but "bcl 20,31,foo" is not the same thing
> > > as "bl foo".  The former is a form of bl that doesn't perturb the link
> > > stack and is therefore better for performance when you're not going to
> > > do a matching blr later (not that performance is at all critical
> > > here).
> > 
> > If performance mattered I would have complained about the extra mfmsr. :-)
> > 
> > I see that some other parts of the kernel are using that bcl instruction, 
> > but 
> > if it is actually worthwhile in those places, it'd be nice to at least 
> > stick 
> > it in a macro for readability...
> 
> How is that going to help?  It's just idiom; replacing it with some other
> idiom only means people already used to the 20,31 thing (which is quite old
> by now, btw.; 74xx days) will have to learn the new thing.

That's fine for people who are used to it (especially if it's the only number-
based bc they routinely come across), but I had to look up what it meant.  
Simplified mnemonics exist for a reason.

> Unless you can think of a nice short name that can even be made an extended
> mnemonic?

For a macro I was thinking "BL_NORET" but for a mnemonic it'd probably be 
shortened to something like "blnr".

-Scott
