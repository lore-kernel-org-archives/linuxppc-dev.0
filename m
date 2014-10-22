Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 171EE1A0074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 17:11:00 +1100 (AEDT)
Message-ID: <1413958248.364.11.camel@pasglop>
Subject: Re: [PATCH] powernv: Use _GLOBAL_TOC for opal wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 22 Oct 2014 17:10:48 +1100
In-Reply-To: <1413955870.9754.3.camel@concordia>
References: <1413948772.62479.492398078454.1.gpush@pablo>
 <1413955870.9754.3.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-22 at 16:31 +1100, Michael Ellerman wrote:
> On Wed, 2014-10-22 at 11:32 +0800, Jeremy Kerr wrote:
> > Currently, we can't call opal wrappers from modules when using the LE
> > ABIv2, which requires a TOC init.
> 
> What happens if we try? Build failure or run time bug?

Kaboom.

> > This change uses the _GLOBAL_TOC() macro (rather than _GLOBAL) for the
> > opal wrappers, so that we can do non-local calls to them.
> 
> Are we doing that now, or we would like to?

We do now for a test module (the one that test using the invalid
OPAL call), but we would like to use it for real for the new IPMI
driver among others.

Cheers,
Ben.
