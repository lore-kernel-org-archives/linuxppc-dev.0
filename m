Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 638C91A04F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 05:42:51 +1000 (EST)
Message-ID: <5408C0AB.6050801@hurleysoftware.com>
Date: Thu, 04 Sep 2014 15:42:35 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	<54079B70.4050200@hurleysoftware.com>	<1409785893.30640.118.camel@pasglop>	<21512.10628.412205.873477@gargle.gargle.HOWL>	<20140904090952.GW17454@tucnak.redhat.com>	<540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
In-Reply-To: <20140904175044.4697aee4@alan.etchedpixels.co.uk>
Content-Type: text/plain; charset=utf-8
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

On 09/04/2014 12:50 PM, One Thousand Gnomes wrote:
>> Besides updating the documentation, it may make sense to do something
>> arch-specific. Just bumping out storage on arches that don't need it
>> seems wasteful, as does generating bus locks on arches that don't need it.
>> Unfortunately, the code churn looks unavoidable.
> 
> The arch specific is pretty much set_bit and friends. Bus locks on a
> locally owned cache line should not be very expensive on anything vaguely
> modern, while uniprocessor boxes usually only have to generate set_bit
> as a single instruction so it is interrupt safe.

Or we could give up on the Alpha.

It's not just the non-atomic bytes; we could do away with the
read_barrier_depends() which hardly any code gets correctly anyway.

Regards,
Peter Hurley
