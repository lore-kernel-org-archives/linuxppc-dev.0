Return-Path: <oss@buserror.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7Qk60QYPzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 13:22:06 +1000 (AEST)
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r7Qk55L93z9ssP
 for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2016 13:22:05 +1000 (AEST)
Message-ID: <1463366780.16584.118.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Walker
 <danielwa@cisco.com>,  linuxppc-dev@ozlabs.org,
 "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>, Kumar Gala
 <galak@kernel.crashing.org>
Date: Sun, 15 May 2016 21:46:20 -0500
In-Reply-To: <1463362819.5704.8.camel@ellerman.id.au>
References: <57367455.5060306@cisco.com>
 <1463362819.5704.8.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: udgb on fsl booke?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-16 at 11:40 +1000, Michael Ellerman wrote:
> On Fri, 2016-05-13 at 17:41 -0700, Daniel Walker wrote:
> 
> > Hi,
> > 
> > I noticed that udbg is missing for fsl booke , or at least it doesn't 
> > appear to be implemented. I don't know a great deal about fsl book. I'm 
> > working on an MCP85XX at the moment , and I was looking into the udbg 
> > system to get prints. It looks like fsl booke might be similar enough to 
> > 44x to use the already implemented udbg routines for that.
> > 
> > Does anyone have suggestion on this ? Is fsl booke missing because it's 
> > not possible to have this, or no one ever needed it ?
> 
> Yeah I noticed this recently too.
> 
> I don't know the history of why there isn't one, I suspect probably it just
> was
> never merged upstream. Hopefully someone from Freescale can chime in.
> 
> On my machine (p5020ds) there is a real UART, so it should just be a matter
> of
> creating a mapping for it and then using the existing udbg_16550 code.

We don't have udbg support for these chips anywhere.  I usually just dump the
logbuffer from an external debugger (or bisect with a branch-to-self using the
external debugger to see if it was reached, if the logbuffer is empty) when
there's a boot problem.  It'd be nice to have; it just never got done.

-Scott
