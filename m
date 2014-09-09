Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6EF31A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 11:59:39 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 8 Sep 2014 19:59:37 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9F0CAC40001
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 19:59:33 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s88NtWWo65601590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 01:55:32 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s89240li020181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Sep 2014 20:04:01 -0600
Date: Mon, 8 Sep 2014 18:59:33 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140909015933.GA4704@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
 <540DEE6C.2060904@zytor.com> <540E3207.7090007@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540E3207.7090007@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 08, 2014 at 06:47:35PM -0400, Peter Hurley wrote:
> On 09/08/2014 01:59 PM, H. Peter Anvin wrote:
> > On 09/08/2014 10:52 AM, One Thousand Gnomes wrote:
> >> On Fri, 05 Sep 2014 08:41:52 -0700
> >> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >>
> >>> On 09/05/2014 08:31 AM, Peter Hurley wrote:
> >>>>
> >>>> Which is a bit ironic because I remember when Digital had a team
> >>>> working on emulating native x86 apps on Alpha/NT.
> >>>>
> >>>
> >>> Right, because the x86 architecture was obsolete and would never scale...
> >>
> >> Talking about "not scaling" can anyone explain how a "you need to use
> >> set_bit() and friends" bug report scaled into a hundred message plus
> >> discussion about ambiguous properties of processors (and nobody has
> >> audited all the embedded platforms we support yet, or the weirder ARMs)
> >> and a propsal to remove Alpha support.
> >>
> >> Wouldn't it be *much* simpler to do what I suggested in the first place
> >> and use the existing intended for purpose, deliberately put there,
> >> functions for atomic bitops, because they are fast on sane processors and
> >> they work on everything else.
> >>
> >> I think the whole "removing Alpha EV5" support is basically bonkers. Just
> >> use set_bit in the tty layer. Alpha will continue to work as well as it
> >> always has done and you won't design out support for any future processor
> >> that turns out not to do byte aligned stores.
> >>
> >> Alan
> >>
> > 
> > Is *that* what we are talking about?  I was added to this conversation
> > in the middle where it had already generalized, so I had no idea.
> 
> No, this is just what brought this craziness to my attention.
> 
> For example, byte- and short-sized circular buffers could not possibly
> be safe either, when the head nears the tail.
> 
> Who has audited global storage and ensured that _every_ byte-sized write
> doesn't happen to be adjacent to some other storage that may not happen
> to be protected by the same (or any) lock?

This was my concern as well.

							Thanx, Paul
