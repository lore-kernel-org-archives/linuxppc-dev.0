Return-Path: <srs0=+fsc=mc=kernel.crashing.org=segher@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GKMY0TkJzDr6q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 00:47:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42GKMX6nw4z8sfp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 00:47:36 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42GKMX1S5bz9sBv
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2018 00:47:35 +1000 (AEST)
Date: Thu, 20 Sep 2018 09:47:15 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 maddy@linux.ibm.com, paulus@samba.org
Subject: Re: [PATCH] powerpc/perf: Add missing break in
 power7_marked_instr_event()
Message-ID: <20180920144715.GA23155@gate.crashing.org>
References: <20180920094111.4125-1-mpe@ellerman.id.au>
 <e1868207-7dd4-e6cc-0fce-04e0fd1e5edc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1868207-7dd4-e6cc-0fce-04e0fd1e5edc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2018 at 03:29:22PM +0530, Madhavan Srinivasan wrote:
> On Thursday 20 September 2018 03:11 PM, Michael Ellerman wrote:
> >In power7_marked_instr_event() there is a switch case that is missing
> >a break or an explicit fallthrough, it's not immediately clear which
> >it should be.

> Just curious to know, how did you find this. Static code checker compiled
> or any specific compiler warnings or just by code read?

Newer GCC warns about suspicious fallthroughs (-Wimplicit-fallthrough,
which is in -Wextra).


Segher
