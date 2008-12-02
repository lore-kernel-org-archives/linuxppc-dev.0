Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72365DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 20:20:52 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix bogus cache flushing on all 40x and BookE
	processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
References: <20081201060152.00DCCDDDE3@ozlabs.org>
	<BD75FAE9-7D10-488B-9906-23B2D93F1FB6@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 20:20:41 +1100
Message-Id: <1228209641.7356.176.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-02 at 01:36 -0600, Kumar Gala wrote:

> > #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
> > 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
> > -	    CPU_FTR_UNIFIED_ID_CACHE)
> > +	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
> > #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
> > -	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
> > +	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP |  
> > CPU_FTR_NODSISRALIGN \
> 
> Added a '|' at the end of the line before the escape

Right. Will send a new patch tomorrow. Appart from that, have you
verified it doesn't have any adverse effects for you ? I did some quick
tests on 440 and things seem to be fine.

Cheers,
Ben.
