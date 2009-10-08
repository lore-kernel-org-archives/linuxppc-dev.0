Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE37FB7B68
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:21:34 +1100 (EST)
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OFB3DEEF6E.1F3F6AC5-ONC1257649.00246C73-C1257649.002523BD@transmode.se>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>
	<OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
	<1254960296.2733.3.camel@pasglop>
	<OFE2E96EF3.F21AB563-ONC1257649.0000A4AC-C1257649.0001C04D@transmode.se>
	<1254961699.2417.1.camel@pasglop>
	<OFB3DEEF6E.1F3F6AC5-ONC1257649.00246C73-C1257649.002523BD@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:21:25 +1100
Message-Id: <1255033285.2146.13.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 08:45 +0200, Joakim Tjernlund wrote:

> > Generic code should sort it out in handle_mm_fault() (or earlier if it
> > can't find a VMA at all).
> 
> How can it? You need to know more that just read and write.

It does. It's going to look for the VMA, which will tell it what is
allowed or not. You'll notice 4xx/BookE doesn't use DSISR (except the
ESR bit we pass to separate loads from stores).

If the region has no access, the kernel will know it (no VMA for
example) and will trigger a SEGV.

Really, the DSISR stuff is not as necessary as you think it is :-) You
should be able to jump to C code straight from both TLB error
interrupts.

> >
> > But that's a slow path anyways.
> 
> How so? You take a TLB Error for the first write to
> every page.

Compared to the TLB miss that is :-) But my main point is that a TLB
error caused by a lack of DIRTY or ACCESSED will be rare.

Ben.
