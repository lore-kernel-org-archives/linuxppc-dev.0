Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6B0FD688B9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 05:15:01 +1100 (EST)
Date: Mon, 12 Dec 2005 10:14:57 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Simon Haynes <simon@baydel.com>
Message-ID: <20051212181457.GA30505@gate.ebshome.net>
References: <200512121726.34944.simon@baydel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200512121726.34944.simon@baydel.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ibm emac driver update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Dec 12, 2005 at 05:26:34PM +0000, Simon Haynes wrote:
> I am running a Ebony board with linux-2.6.12-rc1 and I amd having intermittent 
> network problems. Having searched the archives it would seem that the driver
> for the IBM EMAC is buggy ? 
> 
> I have tried to patch my kernel with 
> 
> http://kernel.ebsname.net/emac/4xx_napi_emac.diff
> 
> I believe this is almost a total driver re-write. Is this correct ?
> 
> After having a couple of problems applying the patch, Kconfig and 
> ibm_emac_core.c. I fixed up the original code and applied the patch.
> 
> On compilation the build fails with missing references to kzalloc,
> which I guess I could easily fix with kmalloc and memset. 
> 
> However there is also an undefined field,  dcr_base, in the ocp_func_mal_data
> structure.  This structure appears to be defined in include/asm/ibm_ocp.h and 
> this file does not appear to be changed by the patch. I guess this patch is 
> for a later kernel.
> 
> Can anyone point me in the direction of a suitable patch for this kernel ?

I'm not sure about 2.6.12-rc1, but you can try GIT tree/patches at 
http://kernel.ebshome.net. 

Hint: you can assume that in addition to emac_3-2.6-28.diff, there are 
also emac_3-2.6-NN.diff (NN < 28) on my website which were made for 
earlier kernel versions :).

Alternatively, you can backport all relevant stuff from current 2.6 or 
you can pay someone to do this for you.

-- 
Eugene
