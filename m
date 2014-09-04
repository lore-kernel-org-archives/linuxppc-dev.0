Return-Path: <gnomes@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk
 (7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:bf32:7069:230:18ff:fea2:8c37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B7ADB1A0068
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 02:51:22 +1000 (EST)
Date: Thu, 4 Sep 2014 17:50:44 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140904175044.4697aee4@alan.etchedpixels.co.uk>
In-Reply-To: <540859EC.5000407@hurleysoftware.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jakub Jelinek <jakub@redhat.com>, Mikael Pettersson <mikpelinux@gmail.com>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Besides updating the documentation, it may make sense to do something
> arch-specific. Just bumping out storage on arches that don't need it
> seems wasteful, as does generating bus locks on arches that don't need it.
> Unfortunately, the code churn looks unavoidable.

The arch specific is pretty much set_bit and friends. Bus locks on a
locally owned cache line should not be very expensive on anything vaguely
modern, while uniprocessor boxes usually only have to generate set_bit
as a single instruction so it is interrupt safe.

Alan
