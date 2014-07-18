Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F08E1A07C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 20:40:27 +1000 (EST)
Message-ID: <53C8F4DF.8020103@nod.at>
Date: Fri, 18 Jul 2014 12:20:15 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
 <20140718101416.GB1818@arm.com>
In-Reply-To: <20140718101416.GB1818@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@mentor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 18.07.2014 12:14, schrieb Will Deacon:
> On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:
>> On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> The core mm code will provide a default gate area based on
>>> FIXADDR_USER_START and FIXADDR_USER_END if
>>> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
>>>
>>> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
>>> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
>>> 32-bit UML, and x86_64 have gate areas, but they have their own
>>> implementations.
>>>
>>> This gets rid of the default and moves the code into ia64.
>>>
>>> This should save some code on architectures without a gate area: it's
>>> now possible to inline the gate_area functions in the default case.
>>
>> Can one of you pull this somewhere?  Otherwise I can put it somewhere
>> stable and ask for -next inclusion, but that seems like overkill for a
>> single patch.

For the um bits:
Acked-by: Richard Weinberger <richard@nod.at>

> I'd be happy to take the arm64 part, but it doesn't feel right for mm/*
> changes (or changes to other archs) to go via our tree.
> 
> I'm not sure what the best approach is if you want to send this via a single
> tree. Maybe you could ask akpm nicely?

Going though Andrew's tree sounds sane to me.

Thanks,
//richard
