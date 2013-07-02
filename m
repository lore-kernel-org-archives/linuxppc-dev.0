Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-x22e.google.com (mail-oa0-x22e.google.com
 [IPv6:2607:f8b0:4003:c02::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A1B9B2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 03:14:25 +1000 (EST)
Received: by mail-oa0-f46.google.com with SMTP id h1so6703319oag.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2013 10:14:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130702073037.55a53642@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372726396.17904.1.camel@concordia> <20130702073037.55a53642@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Jul 2013 11:14:01 -0600
Message-ID: <CAErSpo5NuwC5cWiWxOb0c3tO47SPBcbW3Vx5vMu=cCu2m4vYLw@mail.gmail.com>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Jason Cooper <jason@lakedaemon.net>,
 Rob Herring <rob.herring@calxeda.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 Maen Suleiman <maen@marvell.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 1, 2013 at 11:30 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Michael Ellerman,
>
> On Tue, 02 Jul 2013 10:53:16 +1000, Michael Ellerman wrote:
>> On Mon, 2013-07-01 at 15:42 +0200, Thomas Petazzoni wrote:
>> > Until now, the MSI architecture-specific functions could be overloaded
>> > using a fairly complex set of #define and compile-time
>> > conditionals. In order to prepare for the introduction of the msi_chip
>> > infrastructure, it is desirable to switch all those functions to use
>> > the 'weak' mechanism. This commit converts all the architectures that
>> > were overidding those MSI functions to use the new strategy.
>>
>> The MSI code used to use weak functions, until we discovered they were
>> being miscompiled on some toolchains (11df1f0). I assume these days
>> we're confident they work correctly.
>
> Hum, interesting. I see from your commit that gcc 4.3.2 was apparently
> affected, and gcc 4.3.x is not /that/ old. Bjorn, what's your point of
> view on this?

There *were* compilation issues with weak functions, but AFAIK they've
been resolved and there's no reason to avoid them.  Commit f9d142500
addressed this.

Bjorn
