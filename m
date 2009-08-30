Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2C683B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 05:36:29 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A9442DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 05:36:28 +1000 (EST)
Date: Sun, 30 Aug 2009 23:36:25 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 0/5] Suspend/resume support for some 83xx/85xx/86xx boards
Message-ID: <20090830193625.GA14693@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 12:38:51AM -0500, Kumar Gala wrote:
> >This patch adds suspend/resume support for MPC8540-compatible and
> >MPC8569 CPUs.
[...] 
> I'd also like to get Scott's Ack on this and the device tree patches
> before accepting them.

Heh, I didn't notice that the PMC bindings for 85xx describe devdisr
registers (and thus sleep = <> properties).

So here are updated patches that should comply with the bindings.
Plus,

- It appears that 86xx PMCs registers-compatible with 85xx, so we
  can support both. Thus move 85xx/suspend.c to sysdev/fsl_pmc.c;
- New patch that adds suspend/resume for MPC8610HPCD;
- New patch that adds suspend/resume for 83xx QE boards;
- Some fixes in "Make qe_reset() code path safe for repeated
  invocation" patch.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
