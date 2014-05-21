Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C11E1A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 10:19:15 +1000 (EST)
Message-ID: <1400631544.3986.151.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 21 May 2014 10:19:04 +1000
In-Reply-To: <537B5D85.3010305@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <537B4740.6090806@suse.de> <20140520124504.GB28441@shangw>
 <537B5D85.3010305@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-20 at 15:49 +0200, Alexander Graf wrote:
> So how about we just implement this whole thing properly as irqfd? 
> Whether QEMU can actually do anything with the interrupt is a different 
> question - we can leave it be for now. But we could model all the code 
> with the assumption that it should either handle the error itself or 
> trigger and irqfd write.

I don't object to the idea... however this smells of Deja Vu...

You often tend to want to turn something submitted that fills a specific
gap and implements a specific spec/function into some kind of idealized
grand design :-) And that means nothing gets upstream for weeks or monthes
as we churn and churn...

Sometimes it's probably worth it. Here I would argue against it and would
advocate for doing the basic functionality first, as it is used by guests,
and later add the irqfd option. I don't see any emergency here and adding
the irqfd will not cause fundamental design changes:

The "passed" flag (though I'm not fan of the name) is really something
we want in the low level handlers to avoid triggering host side EEH in
various places, regardless of whether we use irqfd or not.

This is totally orthogonal from the mechanism used for notifications.

Even in host, the detection path doesn't always involve interrupts, and
we can detect some things as a result of a host side config space access
for example etc...

So let's keep things nice and separate here. The interrupt notification
is just an "optimization" which will speed up discovery of the error in
*some* cases later on (but adds its own complexity since we have multiple
discovery path in host, so we need to keep track whether we have notified
yet or not etc...) so let's keep it for later.

Cheers,
Ben.
