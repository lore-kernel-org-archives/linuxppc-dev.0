Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 387A1474D6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:25:37 +1100 (EST)
Message-Id: <33EE789F-D0A8-40A0-BF2A-B8084613B431@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20081215013251.0359db80@xilun.lan.proformatique.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Date: Tue, 16 Dec 2008 12:23:25 -0600
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
	<493E88B7.5020702@freescale.com>
	<20081209161422.5e289e6c@xilun.lan.proformatique.com>
	<493E8BE2.809@freescale.com>
	<20081214195050.677ba7d1@xilun.lan.proformatique.com>
	<18757.30913.736857.463769@cargo.ozlabs.ibm.com>
	<20081215013251.0359db80@xilun.lan.proformatique.com>
Cc: Tjernlund <joakim.tjernlund@transmode.se>,
	Guillaume Knispel <gknispel@proformatique.com>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> The problem obviously only affect people that make use of
> rh_alloc_fixed(), which is the case when you program an MCC or a QMC
> controller of the CPM. Without the patch cpm_muram_alloc_fixed()
> succeed when it should not, for example when trying to allocate out of
> range areas or already allocated areas, so it is possible that buffer
> descriptors or other control structures used by other controllers get
> corrupted.
>
> Digging into ooooold Linux (like 2.6.9, I haven't checked before),
> the problem seems to always have been present.
>
> Without this patch I experienced oops (sometimes panic, sometimes not)
> in various unrelated part (probably an indirect result of either
> corruption of rheap management structures or corruption caused by the
> CPM using crazy overwritten data) and also initialization of
> multi-channel control structures putting other communication
> controllers out-of-order.
>
> The only risk I can think off is that it could break some out of tree
> kernel space code which worked because of luck and a double error -  
> for
> example when doing a single DPRam allocation from offset 0 while
> leaving an area reserved at the base of the DPRam. So I think it  
> should
> be put in 2.6.28.

Paul are you planning on picking this up for .28 if not I'll pick it  
up for .29

- k
