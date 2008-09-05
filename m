Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D15C2DDED8
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 13:24:39 +1000 (EST)
Subject: Re: [PATCH 2/3] ibm_newemac: Introduce mal_has_feature
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080904150205.GC2479@yoda.jdub.homelinux.org>
References: <cover.1220540078.git.jwboyer@linux.vnet.ibm.com>
	<20080904150205.GC2479@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Fri, 05 Sep 2008 13:19:23 +1000
Message-Id: <1220584763.4879.97.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-04 at 11:02 -0400, Josh Boyer wrote:
> There are some PowerPC SoCs that do odd things with the MAL handling.  In
> order to accommodate them, we need to introduce a feature mechanism that is
> similar to the existing emac_has_feature function.
> 
> This adds a feature variable to the mal_instance structure, and adds a
> mal_has_feature function with some feature definitions.  These are guarded
> by Kconfig options that are selected by the affected platforms.
> 
> Signed-of-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

You also add an actual feature (CLR_ICINSTAT). You should document that
or move it to a separate patch.

> +/* Features of various MAL implementations */
> +
> +/* Dummy feature bit so the enum works properly */
> +#define MAL_FTR_DUMMY	0x00000001

Nah. Just stick an | 0 in the enum to make it happy.

Cheers,
Ben.
