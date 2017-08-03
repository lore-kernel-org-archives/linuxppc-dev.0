Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNT2D3xtJzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 21:52:36 +1000 (AEST)
Message-ID: <1501761126.2664.42.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Aug 2017 21:52:06 +1000
In-Reply-To: <87efstq8qd.fsf@concordia.ellerman.id.au>
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
 <62a8ad99-137f-765c-aa1b-ad5ba22231d0@kaod.org>
 <1501747359.2664.41.camel@kernel.crashing.org>
 <87efstq8qd.fsf@concordia.ellerman.id.au>
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

On Thu, 2017-08-03 at 19:52 +1000, Michael Ellerman wrote:
> What if num is 0?
> 
> Which it would be in the fallback case, if the affinity mask is empty,
> AFAICS.

How can the mask be empty though ? But yes, as I noted there is a
problem if the value is 0. Not sure what to do if we are given an empty
mask though.

Ben.
