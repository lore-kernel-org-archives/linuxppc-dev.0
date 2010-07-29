Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C4D9EB70B4
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 18:49:46 +1000 (EST)
Date: Thu, 29 Jul 2010 10:49:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ian Campbell <ian.campbell@citrix.com>
Subject: Re: [PATCH 1/4] irq: rename IRQF_TIMER to IRQF_NO_SUSPEND
In-Reply-To: <1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
Message-ID: <alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
	<1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com,
	devicetree-discuss@lists.ozlabs.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Jul 2010, Ian Campbell wrote:

> Continue to provide IRQF_TIMER as an alias to IRQF_NO_SUSPEND since I
> think it is worth preserving the nice self-documenting name (where it
> is used appropriately). It also avoid needing to patch all the many
> users who are using the flag for an actual timer interrupt.

I'm not happy about the alias. What about:

#define __IRQF_TIMER		0x00000200
#define IRQF_NO_SUSPEND		0x00000400

#define IRQF_TIMER    (__IRQF_TIMER | IRQF_NO_SUSPEND)

Thanks,

	tglx
