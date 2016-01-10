Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0050.hostedemail.com
 [216.40.44.50])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89BBA1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 09:52:26 +1100 (AEDT)
Message-ID: <1452466336.7773.46.camel@perches.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
From: Joe Perches <joe@perches.com>
To: Julian Calaby <julian.calaby@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy
 Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd
 Bergmann <arnd@arndb.de>,  linux-arch@vger.kernel.org, Andrew Cooper
 <andrew.cooper3@citrix.com>,  virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin"
 <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>,
 "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
 linux-metag@vger.kernel.org,  linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar
 <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov
 <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sun, 10 Jan 2016 14:52:16 -0800
In-Reply-To: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com>
 <1452454200-8844-4-git-send-email-mst@redhat.com>
 <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
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

On Mon, 2016-01-11 at 09:13 +1100, Julian Calaby wrote:
> On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Add virt_ barriers to list of barriers to check for
> > presence of a comment.
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -5133,7 +5133,8 @@ sub process {
> >                 }x;
> >                 my $all_barriers = qr{
> >                         $barriers|
> > -                       smp_(?:$smp_barrier_stems)
> > +                       smp_(?:$smp_barrier_stems)|
> > +                       virt_(?:$smp_barrier_stems)
> 
> Sorry I'm late to the party here, but would it make sense to write this as:
> 
> (?:smp|virt)_(?:$smp_barrier_stems)

Yes.  Perhaps the name might be better as barrier_stems.

Also, ideally this would be longest match first or use \b
after the matches so that $all_barriers could work
successfully without a following \s*\(

my $all_barriers = qr{
	(?:smp|virt)_(?:barrier_stems)|
	$barriers)
}x;

or maybe add separate $smp_barriers and $virt_barriers

<shrug>  it doesn't matter much in any case
