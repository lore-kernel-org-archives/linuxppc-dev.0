Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id 37F212BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 00:04:25 +1100 (EST)
Message-ID: <003801c4dd26$d0e30090$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <robin.gilks@tait.co.nz>
References: <41B67FCF.6040100@tait.co.nz>
	<1102498710.414.98.camel@linpc003.aimsys.nl>
Date: Wed, 8 Dec 2004 08:06:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Exception handling on mpc8xx cores
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> On Wed, 2004-12-08 at 05:15, Robin Gilks wrote:
> > Greetings
> > 
> > Any Freescale lurkers out there?
> > 
> > The mpc866 manual implies that if the internal core times out an 
> > external Transfer Acknowledge bus signal (by exerting the internally 
> > generated Transfer Error Acknowledge signal) an exception is generated.
> > 
> > I've tried extending the external TA signal well beyond 2040 clock 
> > cycles the maximum timeout allows and I see the busses start up again 
> > (indicationg that they are no longer waiting) but I don't see anything 
> > on TEA and I don't get an exception thrown.
> > 
> > Any clues? Manual error?, silicon error?, my brain error?
> 
> Did you enable the bus monitor in the SYPCR register?
> 

You've also got to have ME set in MSR to get the exception.  For whatever 
it's worth, I have an mpc852 design (part of 866 family) that uses external
acknowledge and it works as advertised.  I've seen the acknowledger,
a DSP, fail, and we get a machine check exception.  (I've never 
looked at TEA, though).

Mark Chambers
