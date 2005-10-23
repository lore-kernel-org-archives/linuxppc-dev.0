Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id C599B685ED
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Oct 2005 03:44:07 +1000 (EST)
Date: Sun, 23 Oct 2005 10:44:05 -0700
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051023174405.GA13889@pants.nu>
References: <20051022213037.GA6097@suse.de>
	<Pine.LNX.4.62.0510231021070.16077@numbat.sonytel.be>
	<1130055811.7919.61.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130055811.7919.61.camel@gaston>
Cc: Andrew Morton <akpm@osdl.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] hide pmac specific drivers if CONFIG_ADB is not set
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 23, 2005 at 06:23:31PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2005-10-23 at 10:23 +0200, Geert Uytterhoeven wrote:
> > On Sat, 22 Oct 2005, Olaf Hering wrote:
> > > SCSI_MESH exists on old Macs, but the PB Lombard has an external connector
> > 
> > And on some CHRP.
> > 
> > You can no longer enable MESH when compiling for CHRP or when disabling ADB?
> > 
> > It's clearly visible my LongTrail died last year... :-(
> 
> Come on, Geert, I told you back then I was doing that :) You didn't
> complain and we figured out nobody around had any of these in working
> conditions anymore :)

Well, it really doesn't have anything to do with ADB. The problem is
actually the macio bus layer, but we don't have CONFIG_ options for
that. I've been working on getting the macio code running in 68k,
so I was thinking of introducing a CONFIG_MACIO. Would this be an
acceptable option? On 68k, I would just default it to yes if the
config has CONFIG_MAC, but it could be made a real question for ppc
since the platform stuff doesn't really let you select just a pci
powermac kernel anymore. Any comments?

I suppose if anyone still has one of those old CHRP machines, we
could probably get hydra supported by macio_asic to get some of the
other drivers working on it.

	Brad Boyer
	flar@allandria.com
