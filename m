Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBA3F67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 06:45:15 +1000 (EST)
Date: Wed, 6 Apr 2005 09:16:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050406121649.GC11066@logos.cnet>
References: <BCEFJBPJCGFCNMMMIDBHEEFNCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHEEFNCLAA.Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 05, 2005 at 11:51:42PM +0200, Joakim Tjernlund wrote:
> Hi Marcelo
> 
> Reading your report it doesn't sound likely but I will ask anyway:
> Is it possible that the problem you are seeing isn't caused by the
> "famous" CPU bug mentioned here: 
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016351.html
> 
> The DTLB error handler needs DAR to be set correctly and since the
> dcbX instructions doesn't set DAR in either DTLB Miss nor DTLB Error you
> may end up trying to fix the wrong address.

Hi Joakim,

First of all, thanks your care! 

Well, I dont think the above issue is exactly what we're hitting because
DAR is correctly updated on our case with "dcbst". 

The problem is that it is treated as a write operation, but shouldnt.

Maybe it is related to dcbst's inability to set DAR? 

BTW, about the CPU15 bug fix, has there been any effort to port/merge 
it in v2.6 ? 
