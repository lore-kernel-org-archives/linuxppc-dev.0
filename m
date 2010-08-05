Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 8DE921007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 03:54:37 +1000 (EST)
Received: from mail80-va3 (localhost.localdomain [127.0.0.1])	by
	mail80-va3-R.bigfish.com (Postfix) with ESMTP id 9BA1C530474	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2010 17:54:20 +0000 (UTC)
Received: from VA3EHSMHS031.bigfish.com (unknown [10.7.14.235])	by
	mail80-va3.bigfish.com (Postfix) with ESMTP id 2D61618F8051	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2010 17:54:20 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75HsGS4003756	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 5 Aug 2010 10:54:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75I5cbY014234	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 5 Aug 2010 13:05:38 -0500 (CDT)
Date: Thu, 5 Aug 2010 12:54:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] fsl_rio: fix compile errors
Message-ID: <20100805125415.3a939502@schlenkerla.am.freescale.net>
In-Reply-To: <F653C93C-5650-4D7B-99F7-090436CFC533@kernel.crashing.org>
References: <1276842263-4186-1-git-send-email-leoli@freescale.com>
	<F653C93C-5650-4D7B-99F7-090436CFC533@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Aug 2010 12:39:48 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Jun 18, 2010, at 1:24 AM, Li Yang wrote:
> 
> > Fixes the following compile problem on E500 platforms:
> > arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
> > arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared (first use in this function)
> > 
> > Also fixes the compile problem on non-E500 platforms.
> > 
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/sysdev/fsl_rio.c |    6 +++++-
> > 1 files changed, 5 insertions(+), 1 deletions(-)
> 
> I'm confused is this handler not relevant for e500MC?  The 2nd patch makes me thing it is.

It is, though it needs to use a different MCSR bit on e500mc.

Are you referring to the #ifdef CONFIG_E500?  CONFIG_PPC_E500MC depends
on CONFIG_E500...

-Scott
