Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm0Fg0k5nzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 22:23:35 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qm0Ff2hW7z9sC3
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2016 22:23:34 +1000 (AEST)
Date: Thu, 14 Apr 2016 14:23:29 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 3/5] powerpc/livepatch: Add livepatch header
In-Reply-To: <alpine.LNX.2.00.1604141417310.10605@pobox.suse.cz>
Message-ID: <alpine.LNX.2.00.1604141422220.10605@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <1460552003-15409-4-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604141417310.10605@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Apr 2016, Miroslav Benes wrote:

> On Wed, 13 Apr 2016, Michael Ellerman wrote:
> 
> > Add the powerpc specific livepatch definitions. In particular we provide
> > a non-default implementation of klp_get_ftrace_location().
> > 
> > This is required because the location of the mcount call is not constant
> > when using -mprofile-kernel (which we always do for live patching).
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  arch/powerpc/include/asm/livepatch.h | 54 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 arch/powerpc/include/asm/livepatch.h
> > 
> > diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> > new file mode 100644
> > index 000000000000..ad36e8e34fa1
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/livepatch.h
> > @@ -0,0 +1,54 @@
> > +/*
> > + * livepatch.h - powerpc-specific Kernel Live Patching Core
> > + *
> > + * Copyright (C) 2015-2016, SUSE, IBM Corp.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#ifndef _ASM_POWERPC_LIVEPATCH_H
> > +#define _ASM_POWERPC_LIVEPATCH_H
> > +
> > +#include <linux/module.h>
> > +#include <linux/ftrace.h>
> > +
> > +#ifdef CONFIG_LIVEPATCH
> 
> We don't use these guards in our header files since 335e073faacc ("klp: 
> remove CONFIG_LIVEPATCH dependency from klp headers").

...but you're gonna need it in the next patch...
