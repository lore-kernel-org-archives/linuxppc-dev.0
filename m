Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 27B2EDE006
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:41:33 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1529599ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 06:41:31 -0700 (PDT)
Date: Wed, 6 Aug 2008 07:41:28 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Message-ID: <20080806134128.GA9533@secretlab.ca>
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
> I'm trying to get the ppc6xx_defconfig booting on any 8641 (74xx/e600)  
> system.  If I remove the 'simple-bus' compatible from the soc node in  
> the .dts it works.  Otherwise it hangs at but and looks to be crashed in 
> the serial driver due to accessing memory at 0.
>
> I've tried the same .dts (w/'simple-bus') using the  
> mpc8641_hpcn_defconfig and things work.

The Xilinx folks hit something similar.  ns16550 nodes get matched if
the parent claims simple-bus.  If extra stuff needs to be done to use
that port, then bad things happen.

g.
