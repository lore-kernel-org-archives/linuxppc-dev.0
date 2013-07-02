Return-Path: <michael@ellerman.id.au>
Message-ID: <1372726396.17904.1.camel@concordia>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
From: Michael Ellerman <michael@ellerman.id.au>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 02 Jul 2013 10:53:16 +1000
In-Reply-To: <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
> Until now, the MSI architecture-specific functions could be overloaded
> using a fairly complex set of #define and compile-time
> conditionals. In order to prepare for the introduction of the msi_chip
> infrastructure, it is desirable to switch all those functions to use
> the 'weak' mechanism. This commit converts all the architectures that
> were overidding those MSI functions to use the new strategy.

The MSI code used to use weak functions, until we discovered they were
being miscompiled on some toolchains (11df1f0). I assume these days
we're confident they work correctly.

cheers
