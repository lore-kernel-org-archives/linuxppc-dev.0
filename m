Return-Path: <greg@kroah.com>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33B18B6FD1
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 04:48:31 +1000 (EST)
Date: Thu, 25 Aug 2011 11:46:55 -0700
From: Greg KH <greg@kroah.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] tty/powerpc: fix build break with ehv_bytechan.c on
	allyesconfig
Message-ID: <20110825184655.GB1891@kroah.com>
References: <1314289245-14946-1-git-send-email-timur@freescale.com>
	<20110825163234.GA31629@kroah.com> <4E568E19.405@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E568E19.405@freescale.com>
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2011 at 01:02:01PM -0500, Timur Tabi wrote:
> Greg KH wrote:
> > tested doesn't mean that it shouldn't still build properly for other
> > platforms, right?
> 
> The problem is the dependency on MSR_GS, which is defined only for Book-E
> PowerPC chips, not all PowerPC.
> 
> So I gave it some more thought, and technically ePAPR extends beyond Book-E, so
> it's wrong for the driver to depend on anything specific to Book-E.  I've
> removed the code that breaks:
> 
> 	/* Check if we're running as a guest of a hypervisor */
> 	if (!(mfmsr() & MSR_GS))
> 		return;

But don't you really want this type of check at runtime?  What happens
if you load this driver on a machine that is not a guest?  Will things
break?  Shouldn't you still refuse to load somehow?

thanks,

greg k-h
