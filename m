Return-Path: <tmarri@apm.com>
Received: from exprod5og116.obsmtp.com (exprod5og116.obsmtp.com [64.18.0.147])
	by ozlabs.org (Postfix) with SMTP id EE1C0B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 04:16:38 +1000 (EST)
Received: by gwb17 with SMTP id 17so890384gwb.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 11:16:35 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop>
	<1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
In-Reply-To: <20110509160935.GA14965@crust.elkhashab.com>
MIME-Version: 1.0
Date: Thu, 12 May 2011 11:16:34 -0700
Message-ID: <6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
Subject: RE: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
To: Ayman El-Khashab <ayman@elkhashab.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So what is the best way to handle this?  It appears (based
on the comments of others and my own experience) that there
is no DCR that exists and behaves the way that previous SOCs
behaved to give us the link status?  The register above
PECFGn_DLLSTA is actually in the PCIe configuration space so
we would have to map that in to be able to read that
register during the link check.  Is that correct or ok?
[marri] yes, you need to program DCR register access these local PCIE_CFG
registers.


I've communicated with some people over email and they had
tried the (PESDRn_HSSLySTS) register.  Recognizing that
there exists one of these for each port/lane, is there a way
to use this one?  It is in the indirect DCR space.  I'd
tried this myself and never did get it to do anything but I
could have been looking at the wrong lane or something.
[marri]This is at SERDES level. If this link up doesn't necessarily
Overall stack is up. This is mostly used for BIST and diagnostics.

Lastly, what was the reason for forcing the original code to
be GEN-1 speeds?
[marri] Gen-2 need some extra checks compared to Gen-1.
There were not many Gen-2 devices at the time of submission
To test them.
