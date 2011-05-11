Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 350621007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:40:50 +1000 (EST)
Received: by iwc10 with SMTP id 10so926948iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:40:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:40:27 +0200
Message-ID: <BANLkTi=XkfREnGaRjv7Pnk4VeJGjC8y+VA@mail.gmail.com>
Subject: Re: [PATCH 00/37] fix paca memory usage and NR_CPU loops, factor ipi
	and simplify irq code
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 7:43 AM, Milton Miller <miltonm@bga.com> wrote:
[...]
> After doing a bunch of grep's on arch/sh, I think the interesting
> parts of super8 interrupt handling that Thomas referred to are in
> drivers/sh/intc. =A0For some reason they populate the radix tree first
> with a descriptor of their common interrupt controler abstraction
> then walk the tree, replacing the tagged elements with the pointer
> to their equivalent to irq_map. =A0I do not yet understand the purpose
> of this two phase allocation.

BTW, you can also write a patch now that eliminates irq_map entirely.
I just talked to tglx today and we agree in principle to move the
hwirq value and irq_domain pointer directly into irq_data (and hence
directly accessible from the irq_desc).  The final form of irq_domain
is still up in the air, but you could do an initial patch that leaves
it as platform defined, and it can be followed up with a patch series
that creates a common irq_domain definition.

g.
