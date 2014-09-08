Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 740671A0214
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 04:13:44 +1000 (EST)
Message-ID: <1410200020.2027.48.camel@jarvis.lan>
Subject: Re: bit fields && data tearing
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Date: Mon, 08 Sep 2014 11:13:40 -0700
In-Reply-To: <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>
 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.7080100@zytor.com>
 <5409D76D.2070203@hurleysoftware.com> <5409D9C0.7030403@zytor.com>
 <20140908185240.21f52ca0@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>, linux-alpha@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>,
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

On Mon, 2014-09-08 at 18:52 +0100, One Thousand Gnomes wrote:
> On Fri, 05 Sep 2014 08:41:52 -0700
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
> > On 09/05/2014 08:31 AM, Peter Hurley wrote:
> > > 
> > > Which is a bit ironic because I remember when Digital had a team
> > > working on emulating native x86 apps on Alpha/NT.
> > > 
> > 
> > Right, because the x86 architecture was obsolete and would never scale...
> 
> Talking about "not scaling" can anyone explain how a "you need to use
> set_bit() and friends" bug report scaled into a hundred message plus
> discussion about ambiguous properties of processors (and nobody has
> audited all the embedded platforms we support yet, or the weirder ARMs)
> and a propsal to remove Alpha support.
> 
> Wouldn't it be *much* simpler to do what I suggested in the first place
> and use the existing intended for purpose, deliberately put there,
> functions for atomic bitops, because they are fast on sane processors and
> they work on everything else.
> 
> I think the whole "removing Alpha EV5" support is basically bonkers. Just
> use set_bit in the tty layer. Alpha will continue to work as well as it
> always has done and you won't design out support for any future processor
> that turns out not to do byte aligned stores.

Seconded.  We implement via hashed spinlocks on PA ... but hey, we're
not the fastest architecture anyway and semantically it just works.

James
