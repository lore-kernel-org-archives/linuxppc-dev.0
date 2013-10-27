Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 341842C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 21:26:22 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on e500
 cores
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
Date: Sun, 27 Oct 2013 11:25:53 +0100
Message-Id: <20131027102554.06B313811DD@gemini.denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Kumar,

In message <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org> you wrote:
> 
> Fair enough
> > 
> > I'm not too worried as long as we warn and account them.
>
> Than, I'd ask this be under a Kconfig option that is disabled by
> default.  Users should have to explicitly enable this so they know what
> they are doing.

Is this really worth the effort?  Under normal situations (users are
using a user space environment that has been properly buiult for the
processor variant they are using) nobody should ever run into this
situation.  It happens only if you are already doing something wrong -
like using user space that has not been built for an E500 core on such
a machine.

In this situation, it seems more useful to me if a "standard" kernel
just works with a "standard" user space environment, even if this
includes some performance penalty - which actually should be
neglibale.  In my tests (when running standard Debian for PPC on a
E500 only very few programs actually triggered this situation, and
none of them in a time-critical way.  I doubt I would even be able to
measure the performance impact.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...all the  good  computer  designs  are  bootlegged;  the  formally
planned  products,  if  they  are built at all, are dogs!" - David E.
Lundstrom, "A Few Good Men From Univac", MIT Press, 1987
