Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC9D71A0429
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:20:28 +1100 (AEDT)
Message-ID: <1423621215.5891.33.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/boot/wrapper: use the pseries wrapper for
 zImage.epapr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 13:20:15 +1100
In-Reply-To: <54DABB77.1060003@ozlabs.org>
References: <1423570510.218746.573015373614.2.gpush@pablo>
 <1423620754.5891.32.camel@kernel.crashing.org>
 <54DABB77.1060003@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-11 at 10:16 +0800, Jeremy Kerr wrote:
> Hi Ben,
> 
> >> We'll likely be entering the zImage.epapr as BE, so include the pseries
> >> implementation of _zimage_start, which adds the endian fixup magic.
> > 
> > Wont that break embedded epapr stuff ?
> 
> How so? This will just give us the endian fixup trampoline (followed by
> a branch to _zimage_start_lib) as the entry point, rather than directly
> entering _zimage_start_lib. Will that not work on embedded?

Hrm, the trampoline only works on server, so it would have a weird
effect if booting embedded with the wrong endian, but ok.

Ben.
