Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2ADB6B7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 09:32:44 +1000 (EST)
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stef Simoens <stef.simoens@scarlet.be>
In-Reply-To: <4A70937B.7040201@scarlet.be>
References: <4A68E1CE.4040307@scarlet.be>
	<1248425553.25467.20.camel@pasglop>  <4A70937B.7040201@scarlet.be>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 09:32:38 +1000
Message-Id: <1248910358.1509.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-07-29 at 20:22 +0200, Stef Simoens wrote:
> 2.6.29 works OK
> 2.6.30-rc1 doesn't work (BUG...)
> 2.6.30-rc1 with your patch ... seems to hang when it should be
> mounting the root directory.
> 
> Is it worthwhile doing a git bisect?

It probably is, since it should work with my patch, so something else
changed, maybe in the SCSI stack.

One thing I know is that the MESH HW has "issues" that make it very
sensitive to alignment DMA buffers, it's possible that the SCSI stack no
longer aligns some stuff ?

Cheers,
Ben.
