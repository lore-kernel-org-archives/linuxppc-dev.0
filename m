Return-Path: <B07421@freescale.com>
Received: from CH1EHSOBE009.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 756E5B6F18
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 09:14:17 +1000 (EST)
Received: from mail33-ch1 (localhost.localdomain [127.0.0.1])	by
	mail33-ch1-R.bigfish.com (Postfix) with ESMTP id 6B8D217180FF	for
	<linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 23:14:13 +0000 (UTC)
Received: from CH1EHSMHS034.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.248])	by mail33-ch1.bigfish.com (Postfix) with ESMTP id
	082A312F004E	for <linuxppc-dev@ozlabs.org>;
	Tue, 14 Jun 2011 23:14:13 +0000 (UTC)
Date: Tue, 14 Jun 2011 18:14:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under
	the hypervisor
Message-ID: <20110614181406.294cdf5f@schlenkerla.am.freescale.net>
In-Reply-To: <1308092673-13045-1-git-send-email-timur@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Jun 2011 18:04:33 -0500
Timur Tabi <timur@freescale.com> wrote:

> The Freescale hypervisor does not allow guests to write to the timebase
> registers (virtualizing the timebase register was deemed too complicated),
> so don't try to synchronize the timebase registers when we're running
> under the hypervisor.
> 
> This typically happens when kexec support is enabled.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

FWIW, it's not supported under KVM either -- though we don't support an SMP
guest under KVM yet, and KVM silently ignores it rather than logs errors as
the FSL HV does.

-Scott
