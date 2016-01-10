Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB5CC1A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 22:42:44 +1100 (AEDT)
Date: Sun, 10 Jan 2016 13:42:28 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, "Cc : Andy Whitcroft" <apw@canonical.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] checkpatch.pl: add missing memory barriers
Message-ID: <20160110134133-mutt-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
 <1451907395-15978-2-git-send-email-mst@redhat.com>
 <1451923660.4334.83.camel@perches.com>
 <20160104224415-mutt-send-email-mst@redhat.com>
 <1451945750.4334.111.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1451945750.4334.111.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 04, 2016 at 02:15:50PM -0800, Joe Perches wrote:
> On Mon, 2016-01-04 at 22:45 +0200, Michael S. Tsirkin wrote:
> > On Mon, Jan 04, 2016 at 08:07:40AM -0800, Joe Perches wrote:
> > > On Mon, 2016-01-04 at 13:36 +0200, Michael S. Tsirkin wrote:
> > > > SMP-only barriers were missing in checkpatch.pl
> > > > 
> > > > Refactor code slightly to make adding more variants easier.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  scripts/checkpatch.pl | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index 2b3c228..0245bbe 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -5116,7 +5116,14 @@ sub process {
> > > >  			}
> > > >  		}
> > > >  # check for memory barriers without a comment.
> > > > -		if ($line =~ /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/) {
> > > > +
> > > > +		my @barriers = ('mb', 'rmb', 'wmb', 'read_barrier_depends');
> > > > +		my @smp_barriers = ('smp_store_release', 'smp_load_acquire', 'smp_store_mb');
> > > > +
> > > > +		@smp_barriers = (@smp_barriers, map {"smp_" . $_} @barriers);
> > > 
> > > I think using map, which so far checkpatch doesn't use,
> > > makes smp_barriers harder to understand and it'd be
> > > better to enumerate them.
> > 
> > Okay - I'll rewrite using foreach.
> > 
> 
> I think using the qr form (like 'our $Attribute' and
> a bunch of others) is the general style that should
> be used for checkpatch.

Thanks - that's what I did in the new version (included in
v3 of the arch cleanup patchset now).
