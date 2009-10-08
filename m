Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EF52B7B69
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:39:22 +1100 (EST)
In-Reply-To: <7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950285.2409.10.camel@pasglop>
	<OF44C1983F.1C42E290-ONC1257649.0069CAF3-C1257649.006A78D1@transmode.se>
	<7A3C6D4C-E92B-434D-AF68-7AEEDE6DAD45@embeddedalley.com>
Subject: Re: [PATCH 3/6] 8xx: invalidate non present TLBs
To: Dan Malek <dan@embeddedalley.com>
Message-ID: <OFB570D3CC.F2AE189F-ONC1257649.0070C808-C1257649.00714D8A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 22:37:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Dan Malek <dan@embeddedalley.com> wrote on 08/10/2009 22:11:07:
>
>
> On Oct 8, 2009, at 12:22 PM, Joakim Tjernlund wrote:
>
> > hare are comments in the kernel that dcbst wrongly
> > generates TLB Errors with store set on 8xx. Is this really so?
> > Should dcbst always trap as a load?

Hi, been a long time since I heard from you :)

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

One could try clearing the store bit in the page fault handler, but then
that might cause a loop.
Not sure it has any practical meaning though.

Anyhow, you are welcome to have a look at the patches I have been tossing out.

 Jocke
