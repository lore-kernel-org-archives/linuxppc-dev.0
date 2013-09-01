Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 500382C0099
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Sep 2013 09:59:26 +1000 (EST)
Message-ID: <1378079952.3978.15.camel@pasglop>
Subject: Re: [PATCH] powerpc: Work around gcc miscompilation of __pa() on
 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Modra <amodra@gmail.com>
Date: Mon, 02 Sep 2013 09:59:12 +1000
In-Reply-To: <20130827071235.GQ3430@bubble.grove.modra.org>
References: <20130827060749.GA16462@drongo>
 <20130827071235.GQ3430@bubble.grove.modra.org>
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

On Tue, 2013-08-27 at 16:42 +0930, Alan Modra wrote:
> The proper fix is to define a whole slew of new relocations and reloc
> specifiers, and modify everything to use them, but that seems like too
> much bother.  I had ideas once upon a time to implement gas and ld
> options that makes @ha and _HA report overflows, but haven't found one
> of those round tuits.

No, if you don't have a reloc that can represent this, then the proper
fix is to use the existing relocs to load the original symbol address
into a register, then *generate* the appropriate 64-bit addition on top
of it.

The pointer has been cast to an integer before the addition, it's no
longer an object pointer and gcc shouldn't treat it as such, at which
point we are in the domain of normal integer arithmetics.

Cheers,
Ben.
