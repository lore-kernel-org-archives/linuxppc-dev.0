Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 940CA1A015A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Nov 2014 17:41:05 +1100 (AEDT)
Message-ID: <54605E00.1050704@ozlabs.org>
Date: Mon, 10 Nov 2014 14:41:04 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
References: <1415245107.292153.444216242273.0.gpush@pablo>	
 <545B826F.7050501@acm.org> <5460307C.9060502@ozlabs.org>
 <1415598090.5769.15.camel@kernel.crashing.org>
In-Reply-To: <1415598090.5769.15.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> Our OPAL interface can only do one at a time ? Because our underlying
> FW driver already has a queue ..

The Linux driver needs to match responses to their requests, so the
driver needs to keep a reference to the requests that we've sent. The
current implementation is very simple: we just keep one pointer, and
require that there's only one outstanding request.

To have multiple outstanding requests, our options here are that we either:

1) duplicate the si_intf's queuing code in the powernv driver; or

2) move the queuing code from the si_intf component to the generic
   IPMI msghander, and use that (so all drivers can assume a single
   outstanding request)

Corey has suggested the latter, which will only require a minimal change
to the powerpv IPMI driver.

Cheers,


Jeremy
