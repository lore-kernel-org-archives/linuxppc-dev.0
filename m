Return-Path: <thomas.petazzoni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [94.23.35.102])
 by ozlabs.org (Postfix) with ESMTP id CD1902C016F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 15:30:42 +1000 (EST)
Date: Tue, 2 Jul 2013 07:30:37 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130702073037.55a53642@skate>
In-Reply-To: <1372726396.17904.1.camel@concordia>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-pci@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Rob Herring <rob.herring@calxeda.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Michael Ellerman,

On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
> On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> > Until now, the MSI architecture-specific functions could be overloaded
> > using a fairly complex set of #define and compile-time
> > conditionals. In order to prepare for the introduction of the msi_chip
> > infrastructure, it is desirable to switch all those functions to use
> > the 'weak' mechanism. This commit converts all the architectures that
> > were overidding those MSI functions to use the new strategy.
> 
> The MSI code used to use weak functions, until we discovered they were
> being miscompiled on some toolchains (11df1f0). I assume these days
> we're confident they work correctly.

Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
view on this?

Another option would be to have architecture register some msi_arch_ops
structure, with a set of operations, which I believe is a pattern that
is more widespread in the kernel than weak functions.

Thoughts?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
