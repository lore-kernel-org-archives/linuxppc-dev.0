Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD7D4B7195
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:59:50 +1000 (EST)
Date: Thu, 19 May 2011 10:59:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/e5500: set non-base IVORs
Message-ID: <20110519105943.646db1b1@schlenkerla.am.freescale.net>
In-Reply-To: <B794A6BF-1B01-4764-92BA-A486A0166EB8@kernel.crashing.org>
References: <20110509212600.GA29190@schlenkerla.am.freescale.net>
	<B794A6BF-1B01-4764-92BA-A486A0166EB8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 May 2011 00:41:29 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On May 9, 2011, at 4:26 PM, Scott Wood wrote:
> 
> > Without this, we attempt to use doorbells for IPIs, and end up
> > branching to some bad address.  Plus, even for the exceptions
> > we don't implement, it's good to handle it and get a message out.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> > arch/powerpc/include/asm/reg_booke.h      |    4 ++
> > arch/powerpc/kernel/cpu_setup_fsl_booke.S |    3 ++
> > arch/powerpc/kernel/exceptions-64e.S      |   47 +++++++++++++++++++++++++++++
> > 3 files changed, 54 insertions(+), 0 deletions(-)
> 
> applied to next

It's actually not quite right, as I misused MASKABLE_EXCEPTION and some of
those ivors are critical/guest rather than normal.  I'll send a followup.

-Scott
