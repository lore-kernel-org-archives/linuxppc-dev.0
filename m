Return-Path: <amodra@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BD872C009F
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Sep 2013 12:31:18 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id y10so4154698pdj.22
 for <linuxppc-dev@ozlabs.org>; Sun, 01 Sep 2013 19:31:16 -0700 (PDT)
Date: Mon, 2 Sep 2013 12:01:10 +0930
From: Alan Modra <amodra@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Work around gcc miscompilation of __pa() on
 64-bit
Message-ID: <20130902023110.GV3430@bubble.grove.modra.org>
References: <20130827060749.GA16462@drongo>
 <20130827071235.GQ3430@bubble.grove.modra.org>
 <1378079952.3978.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378079952.3978.15.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 02, 2013 at 09:59:12AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-27 at 16:42 +0930, Alan Modra wrote:
> > The proper fix is to define a whole slew of new relocations and reloc
> > specifiers, and modify everything to use them, but that seems like too
> > much bother.  I had ideas once upon a time to implement gas and ld
> > options that makes @ha and _HA report overflows, but haven't found one
> > of those round tuits.
> 
> No, if you don't have a reloc that can represent this, then the proper
> fix is to use the existing relocs to load the original symbol address
> into a register, then *generate* the appropriate 64-bit addition on top
> of it.

I already have a gcc fix to do exactly that.  My "proper fix" comment
was more to do with the general case.  For example, when linking a
huge object that overflows _HA relocs right now we silently generate
bad code.

-- 
Alan Modra
Australia Development Lab, IBM
