Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD73DB7D20
	for <linuxppc-dev@ozlabs.org>; Fri,  7 May 2010 16:50:59 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/kexec: Add support for FSL-BookE
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
Date: Fri, 7 May 2010 01:50:29 -0500
Message-Id: <42CE8E3E-E536-402C-970B-C4BBC036BEB9@kernel.crashing.org>
References: <1270412343-19334-1-git-send-email-sebastian@breakpoint.cc>
	<1270412343-19334-4-git-send-email-sebastian@breakpoint.cc>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 4, 2010, at 3:19 PM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> This adds support kexec on FSL-BookE where the MMU can not be simply
> switched off. The code borrows the initial MMU-setup code to create =
the
> identical mapping mapping. The only difference to the original boot =
code
> is the size of the mapping(s) and the executeable address.
> The kexec code maps the first 2 GiB of memory in 256 MiB steps. This
> should work also on e500v1 boxes.
> SMP support is still not available.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/Kconfig                          |    2 +-
> arch/powerpc/include/asm/kexec.h              |   13 +++++++++
> arch/powerpc/kernel/fsl_booke_entry_mapping.S |   37 =
+++++++++++++++++++++++++
> arch/powerpc/kernel/head_fsl_booke.S          |    2 +
> arch/powerpc/kernel/misc_32.S                 |   17 +++++++++++
> 5 files changed, 70 insertions(+), 1 deletions(-)

Can you explain this a bit more.  Mostly would like to have a brief =
description of the sequence of events as part of the commit message.

Something like:

* Running kernel calls machine_kexec()
* machine_kexec_32()
* jump to relocate code
* relocate clears out TLBs and sets up 2g mapping
...

what I have above might not be quite right.

- k=
