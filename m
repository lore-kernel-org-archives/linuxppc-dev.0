Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7Gnp1Bc1zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 10:26:05 +1000 (AEST)
Message-ID: <1499905553.2865.49.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/powernv: Enable PCI peer-to-peer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 brking@linux.vnet.ibm.com, clsoto@linux.vnet.ibm.com
Date: Thu, 13 Jul 2017 10:25:53 +1000
In-Reply-To: <040bff3c-6afd-0e20-2d3c-d26716137eeb@linux.vnet.ibm.com>
References: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
 <1499899179.2865.42.camel@kernel.crashing.org>
 <040bff3c-6afd-0e20-2d3c-d26716137eeb@linux.vnet.ibm.com>
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

On Wed, 2017-07-12 at 18:01 -0500, Frederic Barrat wrote:
> > So you have the initiator refcounting in Linux and the target
> > refcounting in OPAL ... any reason for that ?
> 
> The initiator refcount is per PE and skiboot doesn't track PEs. Also 
> when the initiator refcount falls back to 0, we should restore the 
> default bypass setting for the TVE, and that's more easily done from 
> linux, since it knows the start and end address of the memory. So for 
> those reasons, I don't really have the choice, the initiator refcount 
> seems better suited in linux.
> 
> The target refcount is per PHB and it just seemed easier to keep it in opal.
> 
> Does the lack of symmetry bother you?

Only mildly. I would have put the whole refcount in Linux...

Cheers,
Ben.
