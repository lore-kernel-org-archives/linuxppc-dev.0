Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzWQW43L3zDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 07:26:27 +1000 (AEST)
Message-ID: <1469568378.25630.119.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,  Alessio Igor
 Bogani <alessio.bogani@elettra.eu>, Daniel Axtens <dja@axtens.net>,
 linux-kernel@vger.kernel.org
Date: Tue, 26 Jul 2016 16:26:18 -0500
In-Reply-To: <CAHQ1cqE+-p00PwYCTA8SkAuqmQ+pkuzDfKJir7s+XR3GBzFZ2Q@mail.gmail.com>
References: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
 <1469507114-5788-3-git-send-email-andrew.smirnov@gmail.com>
 <1469519945.25630.105.camel@buserror.net>
 <CAHQ1cqE+-p00PwYCTA8SkAuqmQ+pkuzDfKJir7s+XR3GBzFZ2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] powerpc: Convert fsl_rstcr_restart to a reset handler
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-26 at 14:22 -0700, Andrey Smirnov wrote:
> On Tue, Jul 26, 2016 at 12:59 AM, Scott Wood <oss@buserror.net> wrote:
> > 
> > On Mon, 2016-07-25 at 21:25 -0700, Andrey Smirnov wrote:
> > > 
> > > Convert fsl_rstcr_restart into a function to be registered with
> > > register_reset_handler() API and introduce fls_rstcr_restart_register()
> > > function that can be added as an initcall that would do aforementioned
> > > registration.
> > > 
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Is there a particular motivation for this (e.g. new handlers you plan to
> > register elsewhere)?
> I have a MPC8548 based board that which uses, at least for time being,
> SBC8548's init code(by claiming compatibility in DT) which has an
> external watchdog that implements reset functionality. The driver for
> watchdog is just a generic watchdog driver and having an ability to
> register custom reset handlers is very handy.
> 
> I don't really have any motivation for fixing boards other than
> SBC8548 and even that I can avoid doing by making a new custom board
> file in my tree that would not populate .reset field. I can drop this
> patch from the series if the code of those boards is in "don't touch
> it unless absolutely have to" state.

I'm not saying not to touch it -- I just wanted to understand the context.

-Scott
