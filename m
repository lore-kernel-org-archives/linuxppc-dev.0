Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id A1053B70ED
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 21:42:35 +1100 (EST)
Date: Mon, 22 Nov 2010 11:37:17 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Change in PCI behaviour
Message-ID: <20101122103717.GA11649@iram.es>
References: <4CE69AF6.6090408@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CE69AF6.6090408@mlbassoc.com>
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 19, 2010 at 08:42:46AM -0700, Gary Thomas wrote:
> In this case, note that PCI device 0000:00:0c.0 is at 0xc0000000.
> This causes problems because it's a truly stupid device that does
> not work properly at PCI [relative] address 0x00000000.  It simply
> does not respond at that address.  Pick anywhere else and it will
> work fine!

Yes, but it was one upon a time in the PCI spec that setting the
a base register to 0 should disable the corresponding decoder.

I don't know whether this has changed (I actually never had the 
final PCI spec, only drafts). However I once had a device who
actually did not disable base addresses set to zero and this was 
described as a bug in its (numerous) errata. This also caused
a lot of mayhem since in some versions/configurations it used 
up to 64kB of PCI I/O space (especially fun on x86...). 

	Gabriel
