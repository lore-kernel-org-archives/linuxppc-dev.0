Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B88EEB7B6B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:18:24 +1100 (EST)
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:18:14 +1100
Message-Id: <1255033094.2146.9.camel@pasglop>
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

On Thu, 2009-10-08 at 13:11 -0700, Dan Malek wrote:
> 
> There are many comments written about 8xx as various
> behavior was discovered.  Worse, some of these details
> would be different among the different processor versions.
> You need to be careful and test as many different part
> versions as possible to ensure you have everything
> covered.....  then someone will find a part that doesn't
> quite work, "fix" it, and break others :-)
> 
> In this particular case, the PEM does state dcbst is treated
> as a load, but from experience we know 8xx doesn't work
> that way.  Of course, since dcbst is a store operation,
> you could argue that 8xx got it correct :-) 

Hehe. Well, it's architecturally incorrect, as dcbst is not really a
store operation in the sense that it doesn't modify the target cache
line, and as such doesn't (mustn't) be covered by write access
protection, shouldn't set DIRTY, etc...

So I would argue that 8xx got it wrong either way :-)

Cheers,
Ben.
