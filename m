Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86F371A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 18:19:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Date: Tue, 09 Sep 2014 10:11:39 +0200
Message-ID: <2998968.X0xyWHN7fU@wuerfel>
In-Reply-To: <540E6582.9020403@zytor.com>
References: <21512.10628.412205.873477@gargle.gargle.HOWL>
 <1410216228.2027.88.camel@jarvis.lan> <540E6582.9020403@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 08 September 2014 19:27:14 H. Peter Anvin wrote:
> On 09/08/2014 03:43 PM, James Bottomley wrote:
> > 
> > This was years ago (possibly decades).  We had to implement in-kernel
> > unaligned traps for the networking layer because it could access short
> > and int fields that weren't of the correct alignment when processing
> > packets.  It that's all corrected now, we wouldn't really notice (except
> > a bit of a speed up since an unaligned trap effectively places the
> > broken out instructions into the bit stream).

I believe the current line of thinking is to consider it a bug in
the device driver. Those bugs may still exist in some rare legacy
drivers, but anything you'd see in practice should not require unaligned
access any more.

> Well, ARM doesn't trap, it just silently gives garbage on unaligned
> memory references.

ARMv6/v7 (anything that really matters these days) has efficient unaligned
accesses that work. Older CPUs are normally set to trap on unaligned
access, originally for the reason James mentions above, but there are
some even older machines that rely on abusing unaligned accesses to do
byte swapping.

	Arnd
