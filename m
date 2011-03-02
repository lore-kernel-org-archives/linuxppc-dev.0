Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 2B2FCB6F0B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Mar 2011 03:42:50 +1100 (EST)
Date: Wed, 2 Mar 2011 08:42:47 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110302164247.GC18826@ovro.caltech.edu>
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
	<4D6C134C.4070407@embedded-sol.com>
	<20110301002156.GC31428@ovro.caltech.edu>
	<4D6C89A7.8010803@embedded-sol.com>
	<20110301165515.GA23403@ovro.caltech.edu>
	<20110301195208.GC23403@ovro.caltech.edu>
	<4D6DDA85.8070204@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6DDA85.8070204@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2011 at 07:49:57AM +0200, Felix Radensky wrote:
> Hi Ira,
> 
> On 03/01/2011 09:52 PM, Ira W. Snyder wrote:
> > On Tue, Mar 01, 2011 at 08:55:15AM -0800, Ira W. Snyder wrote:
> >
> > [ big snip ]
> >
> >
> > I'd still like the bisect if you have a chance. I've re-reviewed the
> > patch series, and found the places that change register writes to the
> > controller.
> >
> > The patch below changes the register operations back to the original
> > order. It doesn't make any sense why this would be required, but it is
> > worth a quick try.
> >
> > I've added an "XXX" mark where you can comment out a single line if this
> > patch fails. It is highly unlikely to make any difference, but I'm
> > really having a hard time understanding what is wrong.
> >
> >
> This patch fixes the problem. See below
> 

Excellent! I know what is happening now. The 85xx controller doesn't
clear the "channel start" bit at the end of a transfer. Sure enough,
buried near the end of the chapter, the datasheet implies this in a
table very far away from the register definitions. The 83xx datasheet
explicitly states that it clears this bit automatically.

I'll post an updated patch series later today. Thank you so much for
being patient and trying out all of these patches.

Ira
