Return-Path: <dedekind1@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7482B6F5F
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2011 15:39:30 +1000 (EST)
Received: by iwn36 with SMTP id 36so3065572iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2011 22:39:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] mtd/nand : don't free the global data
	fsl_lbc_ctrl_dev->nand in fsl_elbc_chip_remove()
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 01 Jul 2011 08:40:21 +0300
In-Reply-To: <20110630112656.3257116a@schlenkerla.am.freescale.net>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309328435.23597.104.camel@sauron>
	<20110629114558.13975519@schlenkerla.am.freescale.net>
	<1309434797.23597.178.camel@sauron>
	<20110630112656.3257116a@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309498826.23597.200.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, b35362@freescale.com, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-06-30 at 11:26 -0500, Scott Wood wrote:
> If the NULL assignment is dropped, consider what happens if the
> fsl_elbc_nand module is removed then reinserted.  On reinsertion, it
> will
> see a non-NULL fsl_lbc_ctrl_dev->nand, and will skip allocating a new
> one.
> Then you're referencing freed memory.

Oh, then this sounds like a separate bug. Removing the module should
kill everything, and re-inserging the module should have zero
dependencies on the previous states...

Anyway, if you think the original patch is OK, I can put it to my tree.

-- 
Best Regards,
Artem Bityutskiy
