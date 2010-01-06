Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 70432B6F06
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 05:19:36 +1100 (EST)
Date: Wed, 6 Jan 2010 10:19:33 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/8] fsldma: rename fsl_chan to fchan
Message-ID: <20100106181933.GB26426@ovro.caltech.edu>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<1262326246-936-8-git-send-email-iws@ovro.caltech.edu>
	<20100106180422.GB27146@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100106180422.GB27146@loki.buserror.net>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	dan.j.williams@intel.com, Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 06, 2010 at 12:04:22PM -0600, Scott Wood wrote:
> On Thu, Dec 31, 2009 at 10:10:45PM -0800, Ira W. Snyder wrote:
> > The name fsl_chan seems too long, so it has been shortened to fchan.
> 
> Could be just "chan", no need for namespacing here.
> 

True. A few functions have a parameter "struct dma_chan *chan" from the
DMAEngine API. I tried to keep the name different to avoid confusing
readers of the code.

Would you recommend changing everything to "struct fsldma_chan *chan",
and changing to "struct dma_chan *_chan" for the DMAEngine stuff? It
seems fine to me, and the compiler will warn about mismatched types if
you screw something up. The struct dma_chan isn't used for anything
except container_of() anyway.

Ira
