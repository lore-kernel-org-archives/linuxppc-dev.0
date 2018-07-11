Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qfsy5p8kzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:06 +1000 (AEST)
In-Reply-To: <1521771052-5973-1-git-send-email-maurosr@linux.vnet.ibm.com>
To: "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel@gpiccoli.net
Subject: Re: powerpc/eeh: Avoid misleading message "EEH: no capable adapters
 found"
Message-Id: <41Qfsx6lRhz9rxs@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-23 at 02:10:52 UTC, "Mauro S. M. Rodrigues" wrote:
> Due to recent refactoring in EEH in:
> commit b9fde58db7e5 ("powerpc/powernv: Rework EEH initialization on
> powernv")
> a misleading message was seen in the kernel message buffer:
> 
> [    0.108431] EEH: PowerNV platform initialized
> [    0.589979] EEH: No capable adapters found
> 
> This happened due to the removal of the initialization delay for powernv
> platform.
> 
> Even though the EEH infrastructure for the devices is eventually
> initialized and still works just fine the eeh device probe step is
> postponed in order to assure the PEs are created. Later
> pnv_eeh_post_init does the probe devices job but at that point the
> message was already shown right after eeh_init flow.
> 
> This patch introduces a new flag EEH_POSTPONED_PROBE to represent that
> temporary state and avoid the message mentioned above and showing the
> follow one instead:
> 
> [    0.107724] EEH: PowerNV platform initialized
> [    4.844825] EEH: PCI Enhanced I/O Error Handling Enabled
> 
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> Acked-by: Russell Currey <ruscur@russell.cc>
> Tested-by:Venkat Rao B <vrbagal1@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ee8c446fed99ffdc29dedf7d2a8854

cheers
