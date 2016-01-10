Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0183.hostedemail.com
 [216.40.44.183])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EDFE1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 02:17:41 +1100 (AEDT)
Message-ID: <1452439051.7773.27.camel@perches.com>
Subject: Re: [PATCH v2 1/3] checkpatch.pl: add missing memory barriers
From: Joe Perches <joe@perches.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Peter Zijlstra
 <peterz@infradead.org>,  Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,  Stefano Stabellini
 <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@elte.hu>,  "H. Peter Anvin" <hpa@zytor.com>, David
 Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar
 <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov
 <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 10 Jan 2016 07:17:31 -0800
In-Reply-To: <1452438425.7773.21.camel@perches.com>
References: <1452427000-4520-1-git-send-email-mst@redhat.com>
 <1452427000-4520-2-git-send-email-mst@redhat.com>
 <1452438425.7773.21.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-01-10 at 07:07 -0800, Joe Perches wrote:
> On Sun, 2016-01-10 at 13:56 +0200, Michael S. Tsirkin wrote:
> > SMP-only barriers were missing in checkpatch.pl
> > 
> > Refactor code slightly to make adding more variants easier.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> If I use a variable called $smp_barriers, I'd expect
> it to actually be the smp_barriers, not to have to
> prefix it with smp_ before using it.
> 
> 		my $smp_barriers = qr{
> 			smp_store_release|
> 			smp_load_acquire|
> 			smp_store_mb|
> 			smp_read_barrier_depends

That's missing (?:barriers) too.

btw: shouldn't this also have
	smp_mb__(?:before|after)_atomic
?
