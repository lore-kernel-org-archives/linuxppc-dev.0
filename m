Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2900767B19
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 09:18:45 +1000 (EST)
Subject: Re: [PATCH] Make cpufreq_transition_notifier a raw notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.44L0.0605251332260.8473-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0605251332260.8473-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 26 May 2006 09:18:23 +1000
Message-Id: <1148599103.10832.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	johannes@sipsolutions.net, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-25 at 13:53 -0400, Alan Stern wrote:
> The cpufreq code has problems with atomic vs. blocking notifier calls and
> enabling vs. disabling interrupts (show up on pmac).  As a temporary
> band-aid, this patch (as697) makes the cpufreq_transition_notifier_list
> into a raw notifier.

Thanks Alan. That should fix our warning for now, though we'll have to
sync with brodo to get cpufreq right. As I explained separately, I think
part of the problem is bcs cpufreq is a sysdev, it shouldn't have to be,
at least not necessarily. I'm worried that even if they work in atomic
context, some drivers who hook on the cpufreq events might still be
buggy when notified so late in the sleep process.
