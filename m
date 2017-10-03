Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5sVL6JY3zDqhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 19:23:06 +1100 (AEDT)
Message-ID: <1507018960.25065.52.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?=
 Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 nikunj@linux.vnet.ibm.com
Date: Tue, 03 Oct 2017 10:22:40 +0200
In-Reply-To: <20171003065858.GL3260@umbus.fritz.box>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <20171003033615.GA3260@umbus.fritz.box>
 <7f2081f1-415a-85ca-29ed-3ab1467220a7@kaod.org>
 <20171003065858.GL3260@umbus.fritz.box>
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

On Tue, 2017-10-03 at 17:58 +1100, David Gibson wrote:
> 
> Ok.. why do you think this isn't of use?  I'm pretty sure this is
> necessary for the TCG case, since MSR is checked in cpu_has_work(),
> which could otherwise wake up the "dead" cpu.

Ony if it's not in a PM state, in that case we check the corresponding
LPCR:PECE* bit. At least on P7 and later.

Cheers,
Ben.
