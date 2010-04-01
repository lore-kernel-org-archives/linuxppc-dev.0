Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51A8DB7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 13:56:36 +1100 (EST)
Subject: Re: spin_lock_irqsave and multi-core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gshan <Gavin.Shan@alcatel-lucent.com>
In-Reply-To: <4BB407F6.3070106@alcatel-lucent.com>
References: <4BB3FE05.6040800@alcatel-lucent.com>
	<1270089545.7101.84.camel@pasglop>
	<4BB407F6.3070106@alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Apr 2010 13:56:29 +1100
Message-ID: <1270090589.7101.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-01 at 10:41 +0800, gshan wrote:

> One of my private driver need it. I don't know how to do it.

Then your driver is most certainly doing something wrong :-) No driver
needs that. Ever.

What is it trying to do more precisely ? I might be able to explain what
the right approach is if you can tell me what the driver is trying to
disable all system IRQs for ? Keep in mind that local_irq_save() does a
lot more than just masking external interrupts from your device. It
masks them from -all- devices, including timer interrupts, perfmon
interrupts, etc... Doing so on all cores is generally a big no-no and
almost never really necessary.

Cheers,
Ben.
