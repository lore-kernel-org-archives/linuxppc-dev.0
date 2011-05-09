Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 5E946B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 02:10:41 +1000 (EST)
Date: Mon, 9 May 2011 11:09:35 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
Message-ID: <20110509160935.GA14965@crust.elkhashab.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 05, 2011 at 09:44:27AM -0700, Tirumala Marri wrote:
> >
> > Also, the patch removes the code for waiting for the link to be up with
> > a comment "What DCR has the link status on the 460SX?". Please fix that
> > (Tirumala, can you provide the missing information ?)
> >
> 
> It is not one register. Here is the flow for Gen-1.
> 1. PECFGn_DLLSTA[3] will be asserted when pci-e link comes up.
> 2. now progream the UTL buffer configuration registers.
> 3. SW should assert PEUTLn_PCTL[0] to cause flow control initialization.
> This is memory mapped using GPL register REGBH , REBAL and REGMSK
> 4. Now check for the PEUTLN_PSTA[8] for the flow control init completion.


So what is the best way to handle this?  It appears (based
on the comments of others and my own experience) that there
is no DCR that exists and behaves the way that previous SOCs
behaved to give us the link status?  The register above 
PECFGn_DLLSTA is actually in the PCIe configuration space so
we would have to map that in to be able to read that
register during the link check.  Is that correct or ok?

I've communicated with some people over email and they had
tried the (PESDRn_HSSLySTS) register.  Recognizing that
there exists one of these for each port/lane, is there a way
to use this one?  It is in the indirect DCR space.  I'd
tried this myself and never did get it to do anything but I
could have been looking at the wrong lane or something.

Lastly, what was the reason for forcing the original code to
be GEN-1 speeds?

ayman
