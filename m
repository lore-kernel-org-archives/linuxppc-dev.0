Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F43FDE3D8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 23:47:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GDlGgk011652
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:47:16 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GDlFAW190974
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:47:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GDlFJh010877
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 07:47:15 -0600
Date: Wed, 16 Apr 2008 08:43:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080416084349.3c9997f1@zod.rchland.ibm.com>
In-Reply-To: <1208350247.6958.283.camel@pasglop>
References: <20080415102704.39511160@zod.rchland.ibm.com>
	<20080416072758.092c83c5@zod.rchland.ibm.com>
	<20080416073139.7f56e72c@zod.rchland.ibm.com>
	<1208350247.6958.283.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Apr 2008 22:50:47 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-04-16 at 07:31 -0500, Josh Boyer wrote:
> > On Wed, 16 Apr 2008 07:27:58 -0500
> > Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > 
> > > On Tue, 15 Apr 2008 10:27:04 -0500
> > > Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > > 
> > > > Valentine Barshak (2):
> > > >       [POWERPC] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
> > > >       [POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround
> > > 
> > > These two commits have been dropped from the branch.  They cause the
> > > allyesconfig build for powerpc to fail because CONFIG_PPC_DCR_MMIO
> > > doesn't understand the dcri_clrset macro.
> > 
> > Crap.  Looks like you already pulled the tree.  We need to either
> > revert those two commits, or essentially define dcri_clrset to a do {}
> > while(0) in include/asm-powerpc/dcr-mmio.h so things build.
> 
> Why ? It should do the right thing, not nop ...

"... so things build."  Relax Ben.  That isn't a final solution.

I'd rather just do an outright revert of the commits for now.

For a final solution, we're going to have to come up with a more clever
way of doing the clocking stuff in ibm_newemac.  The SDRs are board
specific and completely outside of EMAC/MAL itself.  So doing a dcr_map
on it becomes a bit more difficult, since there really isn't an SDR
node in the device tree at the moment.

josh
