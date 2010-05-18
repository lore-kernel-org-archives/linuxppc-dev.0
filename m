Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id BE801B7D8D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 15:59:20 +1000 (EST)
Received: by wya21 with SMTP id 21so245419wya.15
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 22:59:18 -0700 (PDT)
Date: Tue, 18 May 2010 09:59:13 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5] powerpc: Add hibernation support for FSL BookE
	processors
Message-ID: <20100518055913.GA15998@oksana.dev.rtsoft.ru>
References: <20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com> <4BC77497.9070401@freescale.com>
	<20100416115643.GA3092@oksana.dev.rtsoft.ru>
	<4BC8883C.8050703@freescale.com>
	<20100416190319.GA4104@oksana.dev.rtsoft.ru>
	<4BF18715.8050201@freescale.com>
	<20100517185652.GA11081@oksana.dev.rtsoft.ru>
	<ECFF23B7-26B3-42D1-8609-FB53054BEF06@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ECFF23B7-26B3-42D1-8609-FB53054BEF06@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 17, 2010 at 04:22:37PM -0500, Kumar Gala wrote:
[...]
> > arch/powerpc/kernel/Makefile       |    8 +-
> > arch/powerpc/kernel/swsusp_booke.S |  193 ++++++++++++++++++++++++++++++++++++
> > 2 files changed, 199 insertions(+), 2 deletions(-)
> > create mode 100644 arch/powerpc/kernel/swsusp_booke.S
> 
> Is there board specific code to go along with this?

Nope.

> When I enable I get:
> 
> arch/powerpc/kernel/built-in.o: In function `cpu_idle':
> /home/galak/git/master/powerpc/arch/powerpc/kernel/idle.c:98: undefined reference to `cpu_die'
> make: *** [.tmp_vmlinux1] Error 1

This isn't caused by hibernation or my patch specifically.
Instead, it's a long standing issue, enabling CONFIG_SMP and
CONFIG_SUSPEND is enough to trigger this. Patch exists:

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg27982.html

No idea why it didn't make Linus' tree.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
