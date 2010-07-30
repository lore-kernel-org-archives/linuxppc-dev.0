Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0836EB70CD
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:52:18 +1000 (EST)
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20100730071922.GQ18378@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
	<1278569285.28659.76.camel@pasglop> <1280473486.2169.2.camel@pasglop>
	<20100730071922.GQ18378@tyan-ft48-01.lab.bos.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Jul 2010 17:52:12 +1000
Message-ID: <1280476332.2169.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-30 at 09:19 +0200, Jakub Jelinek wrote:
> So, in short, I'm afraid "m<>" needs to be used only for GCC 4.6+
> (and, vendors which backported the inline-asm handling changes
> to their older gcc would need to adjust for their gccs too).
> When "m<>" isn't used, it just leads to potential code pessimization
> in inline-asms that are prepared for handling side-effects. 

Ok, so we'll need some kind of macro to "fixup" those constraints ...

Just to make sure I understand things properly, if we don't change them,
the code will still be correct with 4.6 but sub-optimal, right ?

Cheers,
Ben.
