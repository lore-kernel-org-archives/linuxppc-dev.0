Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com
 [216.40.44.40])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD341A0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 03:15:23 +1100 (AEDT)
Message-ID: <1451924114.4334.85.camel@perches.com>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
From: Joe Perches <joe@perches.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Cc
 : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra
 <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
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
 <andreyknvl@google.com>
Date: Mon, 04 Jan 2016 08:15:14 -0800
In-Reply-To: <20160104161123.GJ19062@n2100.arm.linux.org.uk>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
 <20160104161123.GJ19062@n2100.arm.linux.org.uk>
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

On Mon, 2016-01-04 at 16:11 +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > +		my $all_barriers = join('|', (@barriers, @smp_barriers));
> > > +
> > > +		if ($line =~ /\b($all_barriers)\(/) {
> > 
> > It would be better to use /\b$all_barriers\s*\(/
> > as there's no reason for the capture and there
> > could be a space between the function and the
> > open parenthesis.
> 
> I think you mean
> 
> 	/\b(?:$all_barriers)\s*\(/
> 
> as 'all_barriers' will be:
> 
> 	mb|wmb|rmb|smp_mb|smp_wmb|smp_rmb
> 
> and putting that into your suggestion results in:
> 
> 	/\bmb|wmb|rmb|smp_mb|smp_wmb|smp_rmb\s*\(/
> 
> which is clearly wrong - the \b only applies to 'mb' and the \s*\( only
> applies to smp_rmb.

right, thanks.
