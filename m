Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 636F667D63
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 07:16:16 +1000 (EST)
Date: Wed, 4 Oct 2006 16:16:07 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] Add MPC8360EMDS board support (try 2)
Message-Id: <20061004161607.6eeaa51f.kim.phillips@freescale.com>
In-Reply-To: <CEA95FBE-ED7E-4512-A6C5-6362DAE69744@kernel.crashing.org>
References: <20061003231751.00484d8a.kim.phillips@freescale.com>
	<CEA95FBE-ED7E-4512-A6C5-6362DAE69744@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Oct 2006 23:27:42 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Oct 3, 2006, at 11:17 PM, Kim Phillips wrote:
> 
<snip>
> >  arch/powerpc/platforms/83xx/mpc8360e_pb.c  |  220 ++++++
> >  arch/powerpc/platforms/83xx/mpc8360e_pb.h  |   23 +
> >  3 files changed, 1261 insertions(+), 0 deletions(-)
> 
> What's the point of the mpc8360e_pb.h if there's nothing in it?
> 
well I thought I was being consistent with the other 83xx boards ;)

> Also, any reason the files are _pb and config is emds?
> 
_pb == processor board, the core of the mds (modular development system).  The pb can be operated independently of the rest of what comprises the mds.

I used mds nomenclature in 832x since the support includes parts of the mds that are separate from just the pb, e.g. the pci bits in the device tree.

but we need to be more consistent, I agree.

also, there is a wealth of duplicated platform code among each of the four 83xx platforms.  Somethings wrong when one duplicates a file just to s/836/832/g.  How about consolidating them all down to one mpc83xx_mach.c file that enables potential board quirks based on the dev tree root's model property?  That will eliminate all the redundant code, and get rid of the file naming inconsistencies.

Kim
