Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C81312C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 11:51:25 +1100 (EST)
Message-ID: <1360630273.2035.2.camel@pasglop>
Subject: Re: [BUG] irq_dispose_mapping after irq request failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Feb 2013 11:51:13 +1100
In-Reply-To: <20130211205255.72B513E3530@localhost>
References: <20130211053100.GB18462@sapphire.tkos.co.il>
 <20130211061949.GA5561@concordia> <20130211205255.72B513E3530@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Baruch Siach <baruch@tkos.co.il>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-02-11 at 20:52 +0000, Grant Likely wrote:
> Really the irq mappings should be using reference counting. The existing
> code is naive on this count and just releases the irq on the first call
> to irq_dispose_mapping().  I've not gotten around to fixing that. Anyone
> want to take that task on?

Is this the best approach ?

The original idea was that there was no point disposing of mappings in most
cases and keeping the mapping around would provide a bit of stability of
interrupt numbers which might come in handy for debugging etc...

The few cases where disposing of a mapping might be useful is if the underlying
physical interrupts completely disappear, as in a cascaded controller gets
removed or that sort of thing, which is a very rare case... And even then...

Could you just make irq_dispose_mapping() check if the irq desc is
active and fail/WARN/BUG if it is ? I don't see the point of adding a refcount,
that feels overkill.

Cheers,
Ben.
