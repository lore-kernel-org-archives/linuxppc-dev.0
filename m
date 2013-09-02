Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D5602C0079
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Sep 2013 15:06:26 +1000 (EST)
Message-ID: <1378098376.3978.17.camel@pasglop>
Subject: Re: [PATCH] powerpc: Work around gcc miscompilation of __pa() on
 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Modra <amodra@gmail.com>
Date: Mon, 02 Sep 2013 15:06:16 +1000
In-Reply-To: <20130902023110.GV3430@bubble.grove.modra.org>
References: <20130827060749.GA16462@drongo>
 <20130827071235.GQ3430@bubble.grove.modra.org>
 <1378079952.3978.15.camel@pasglop>
 <20130902023110.GV3430@bubble.grove.modra.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-02 at 12:01 +0930, Alan Modra wrote:
> > No, if you don't have a reloc that can represent this, then the proper
> > fix is to use the existing relocs to load the original symbol address
> > into a register, then *generate* the appropriate 64-bit addition on top
> > of it.
> 
> I already have a gcc fix to do exactly that.  My "proper fix" comment
> was more to do with the general case.  For example, when linking a
> huge object that overflows _HA relocs right now we silently generate
> bad code.

Ah that is nice indeed :-) In that case I assume we can't have the offset
itself be part of the TOC :-) Chicken or egg ?

Not sure what's the right fix here is, we don't want to always reserve
enough instructions "space" to do a full 64-bit offset load...

Ben.
