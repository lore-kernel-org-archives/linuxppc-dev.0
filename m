Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DE3A67B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 07:24:54 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Date: Wed, 6 Apr 2005 23:24:46 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEGBCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050406121649.GC11066@logos.cnet>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: 8xx v2.6 TLB problems and suggested workaround
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> On Tue, Apr 05, 2005 at 11:51:42PM +0200, Joakim Tjernlund wrote:
> > Hi Marcelo
> > 
> > Reading your report it doesn't sound likely but I will ask anyway:
> > Is it possible that the problem you are seeing isn't caused by the
> > "famous" CPU bug mentioned here: 
> > http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html
> > 
> > The DTLB error handler needs DAR to be set correctly and since the
> > dcbX instructions doesn't set DAR in either DTLB Miss nor DTLB Error you
> > may end up trying to fix the wrong address.
> 
> Hi Joakim,
> 
> First of all, thanks your care!

NP, I want to be able to run 8xx on 2.6 in the future.
 
> 
> Well, I dont think the above issue is exactly what we're hitting because
> DAR is correctly updated on our case with "dcbst".

Are you sure? Cant remeber all details but this looks a bit strange to me
SPR  826 : 0x00001f00         7936
is not 0x00001 supposed to be the physical page?

Also DSISR: C2000000 looks strange and "impossible". Are you sure this value
is correct?

Don't understand why the "tlbie()" call  works around the problem. Can you
explain that a bit more?

> 
> The problem is that it is treated as a write operation, but shouldnt.
> 
> Maybe it is related to dcbst's inability to set DAR?

Could be, but even if it isn't you are in trouble when dcbX instr.
generates DTLB Misses/Errors Sooner or later you will end up with
strange SEGV or hangs.

> 
> BTW, about the CPU15 bug fix, has there been any effort to port/merge 
> it in v2.6 ?

None that I know.
