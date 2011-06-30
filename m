Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43F6AB6F53
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 02:28:38 +1000 (EST)
Date: Thu, 30 Jun 2011 11:26:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: <dedekind1@gmail.com>
Subject: Re: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
Message-ID: <20110630112656.3257116a@schlenkerla.am.freescale.net>
In-Reply-To: <1309434797.23597.178.camel@sauron>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309328435.23597.104.camel@sauron>
	<20110629114558.13975519@schlenkerla.am.freescale.net>
	<1309434797.23597.178.camel@sauron>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Jun 2011 14:53:13 +0300
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> On Wed, 2011-06-29 at 11:45 -0500, Scott Wood wrote:
> > If we're freeing fsl_lbc_ctrl, we'd better get rid of references to it...
> 
> Yes, on the one hand this is a good defensive programming practice, on
> the other hand it hides double-free bugs. Like this patch fixes a
> double-free bug, and why it was noticed before? I thought may be because
> of this NULL assignment?

I'm not sure how the NULL assignment was hiding anything here.  It was
probably hidden only because nobody tested it with suitable debug options
enabled since the code was last reorganized.

If the NULL assignment is dropped, consider what happens if the
fsl_elbc_nand module is removed then reinserted.  On reinsertion, it will
see a non-NULL fsl_lbc_ctrl_dev->nand, and will skip allocating a new one.
Then you're referencing freed memory.

Looking more closely, the MAX_BANKS loop should be removed.  Since the
reorganization, the platform device represents one chip, not the
controller, so we should only be removing that one chip.

-Scott
