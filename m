Return-Path: <B11780@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4DBBAB7012
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 01:21:41 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix writing to spin table
	'cpu-release-addr' on ppc64e
MIME-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1299359119-7176-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 15 Mar 2011 09:21:33 -0500
Message-ID: <12102DD7-D708-4FC6-928B-309F8A8C5BBA@freescale.com>
References: <1299359119-7176-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 5, 2011, at 3:05 PM, Kumar Gala wrote:

> From: Kumar Gala <kumar.gala@freescale.com>
> 
> If the spin table is located in the linear mapping (which can happen if
> we have 4G or more of memory) we need to access the spin table via a
> cacheable coherent mapping like we do on ppc32 (and do explicit cache
> flush).
> 
> See the following commit for the ppc32 version of this issue:
> 
> commit d1d47ec6e62ab08d2ebb925fd9203abfad3adfbf
> Author: Peter Tyser <ptyser@xes-inc.com>
> Date:   Fri Dec 18 16:50:37 2009 -0600
> 
>    powerpc/85xx: Fix SMP when "cpu-release-addr" is in lowmem
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/platforms/85xx/smp.c |    6 +++++-
> 1 files changed, 5 insertions(+), 1 deletions(-)

applied

- k
