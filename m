Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id 9AF161A0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 19:39:48 +1000 (EST)
Date: Tue, 1 Jul 2014 10:23:46 +0100
From: Will Deacon <will.deacon@arm.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 09/10] arm64,ia64,ppc,s390,sh,tile,um,x86,mm: Remove
 default gate area
Message-ID: <20140701092345.GH28164@arm.com>
References: <cover.1404164803.git.luto@amacapital.net>
 <e1656ab2adfd1891f62610abe3e85ad992ee0cbf.1404164803.git.luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e1656ab2adfd1891f62610abe3e85ad992ee0cbf.1404164803.git.luto@amacapital.net>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>, "x86@kernel.org" <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@mentor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hpa@zytor.org" <hpa@zytor.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
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

On Mon, Jun 30, 2014 at 10:53:20PM +0100, Andy Lutomirski wrote:
> The core mm code will provide a default gate area based on
> FIXADDR_USER_START and FIXADDR_USER_END if
> !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
> 
> This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
> 64-bit UML, and x86_32 have their own code just to disable it.  arm,
> 32-bit UML, and x86_64 have gate areas, but they have their own
> implementations.
> 
> This gets rid of the default and moves the code into ia64.
> 
> This should save some code on architectures without a gate area: it's
> now possible to inline the gate_area functions in the default case.

For the arm64 bit:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
