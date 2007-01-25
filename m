Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D47BDE300
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 08:54:04 +1100 (EST)
Date: Thu, 25 Jan 2007 13:53:07 -0800
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
Message-ID: <20070125215307.GB3126@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>,
	"Eric W.Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 07:34:07PM +1100, Michael Ellerman wrote:
> OK, here's a first cut at moving ops based MSI into the generic code. I'm
> posting this now to make sure I'm not heading off into the weeds.
> 
> The fifth patch contain the guts of it, I've included the MPIC and
> RTAS backends as examples. In fact they actually work.
> 
> In order to smoothly merge this with the old MSI code, the two will need to
> coexist in the tree for at least a few commits, so I've added (invisible)
> Kconfig symbols to allow that.
> 
> I plan to merge the Intel code by:
>  * copying it into drivers/pci/msi/intel.c with zero changes.
>  * providing a minimal shim to connect the ops code to the intel code.
>  * at this point the code should be functional but ugly as hell.
>  * via a longish series of patches, adapt the intel code to better match
>    the new ops code.
>  * this should allow us to bisect through to find any mistakes.
> 
> If people think that's crazy and or stupid please let me know :)

At first glance, this looks sane.  I'll apply the first 4 patches to my
trees, and hold off on the rest until you have the intel patches
finished.

thanks,

greg k-h
