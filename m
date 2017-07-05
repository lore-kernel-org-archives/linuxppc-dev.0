Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2k586G1XzDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 00:38:36 +1000 (AEST)
Message-ID: <1499265500.16202.70.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?=
 Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Date: Wed, 05 Jul 2017 09:38:20 -0500
In-Reply-To: <20170705110702.GO2180@umbus.fritz.box>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
 <1499055599.16202.23.camel@kernel.crashing.org>
 <18d0c283-3527-d599-36d8-4397a0a4d6db@kaod.org>
 <20170705110702.GO2180@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-05 at 21:07 +1000, David Gibson wrote:
> I don't know if it helps, but we do have the ability to trigger a full
> system reset from CAS, so possibly we can do the XICS/XIVE
> instantiation in the reset path.
> 
> I don't think we use that CAS reset ability yet - we just adjust the
> device tree and continue the boot.  But it's there if we need it.
> 
> Worst comes to worst, we might have to instantiate both XICS and XIVE
> objects, with some flags in each indicating which is active.

That could be a problem with the kernel interrupt controller. We can't
really instantiate both there I think... well, actually ... maybe we
could, though it's a bit messy...

Cheers,
Ben.
