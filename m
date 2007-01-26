Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A2760DE0A8
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 20:12:05 +1100 (EST)
In-Reply-To: <20070125083417.69895DE3C5@ozlabs.org>
References: <20070125083417.69895DE3C5@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E5D01D01-55B0-4F1E-A32E-BCADD097F077@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
Date: Fri, 26 Jan 2007 10:11:57 +0100
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.

More exactly: it only deals with MSIs that are translated
by some whatever-to-HT bridge into a normal HT interrupt.

> We properly discover the HT magic address by reading the config space.

...config space of that bridge.

> Now we have an irq allocator we can support > 1 MSI, and we don't  
> reuse
> the LSI.

Right, that's what I asked about in the other thread, so
the FIXME in htmsi_alloc() can indeed go.

Why is MSI-X still unsupported?  Simply because of lack
of testing?  (See htmsi_check()).

Looks good,


Segher
