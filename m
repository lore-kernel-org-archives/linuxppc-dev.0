Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4E728DDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:22:20 +1100 (EST)
Date: Tue, 16 Dec 2008 19:22:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] Kexec for PPC32 (6xx) machines
Message-ID: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is Kexec part of the larger series[1] posted few months ago.
I eliminated Kdump part in this resend (will post it as a separate
entity later).

Milton Miller hinted that current PPC32 Kexec implementation may
not work on SMP hardware. I don't have any multi-core machines
handy to actually try and/or fix it, but support for SMP should be
straightforward: just need to bring the secondary CPUs down before
Kexec'ing (the code is already in the machine_kexec_64.c, just
needs to be factored out).

The arch/powerpc/Kconfig already states that the Kexec support
is experimental and may not work on certain hardware, so I don't
see any reason to add !SMP dependency.

Anyway, the majority of boards are UP and they don't need any fancy
care to work. So let's support them.

[1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061161.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
