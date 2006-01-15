Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1F23689C0
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 03:17:36 +1100 (EST)
Subject: Re: [linux-usb-devel] Re: [2.6 patch] remove unused tmp_buf_sem's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20060114034903.GA23074@suse.de>
References: <17348.61824.49889.569928@jaguar.mkp.net>
	<20060114020816.GW29663@stusta.de>  <20060114034903.GA23074@suse.de>
Content-Type: text/plain
Date: Sun, 15 Jan 2006 15:46:16 +0000
Message-Id: <1137339976.2350.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Jes Sorensen <jes@trained-monkey.org>, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org, R.E.Wolff@BitWizard.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Gwe, 2006-01-13 at 19:49 -0800, Greg KH wrote:
> On Sat, Jan 14, 2006 at 03:08:16AM +0100, Adrian Bunk wrote:
> > <--  snip  -->
> > 
> > 
> > tmp_buf_sem sems to be a common name for something completely unused...


That would be correct. The old tty driver layer used to call ->write
from both kernel and user contexts according to a flag. Drivers then all
ended up with the same code copying it into a tmp buffer and using a
locking semaphore. 

Linus took out that code and arranged that ->write always got a kernel
buffer so the remainders should indeed go.

Alan
