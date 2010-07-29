Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.citrix.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E6AC0B70C6
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 19:03:41 +1000 (EST)
Subject: Re: [PATCH 1/4] irq: rename IRQF_TIMER to IRQF_NO_SUSPEND
From: Ian Campbell <Ian.Campbell@eu.citrix.com>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
References: <1280314445.24292.90.camel@zakaz.uk.xensource.com>
	<1280314467-5637-1-git-send-email-ian.campbell@citrix.com>
	<alpine.LFD.2.00.1007291045060.2471@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Jul 2010 10:03:34 +0100
Message-ID: <1280394214.24292.1594.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-29 at 09:49 +0100, Thomas Gleixner wrote:
> On Wed, 28 Jul 2010, Ian Campbell wrote:
> 
> > Continue to provide IRQF_TIMER as an alias to IRQF_NO_SUSPEND since I
> > think it is worth preserving the nice self-documenting name (where it
> > is used appropriately). It also avoid needing to patch all the many
> > users who are using the flag for an actual timer interrupt.
> 
> I'm not happy about the alias. What about:
> 
> #define __IRQF_TIMER		0x00000200
> #define IRQF_NO_SUSPEND		0x00000400
> 
> #define IRQF_TIMER    (__IRQF_TIMER | IRQF_NO_SUSPEND)

Sure, I'll rework along those lines.

Ian.
