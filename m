Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 8EA691A0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 12:21:41 +1000 (EST)
Message-ID: <1409883098.5078.14.camel@jarvis.lan>
Subject: Re: bit fields && data tearing
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: paulmck@linux.vnet.ibm.com
Date: Thu, 04 Sep 2014 19:11:38 -0700
In-Reply-To: <20140905001751.GL5001@linux.vnet.ibm.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-arch@vger.kernel.org,
 linux-ia64@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-04 at 17:17 -0700, Paul E. McKenney wrote:
> +And there are anti-guarantees:
> +
> + (*) These guarantees do not apply to bitfields, because compilers often
> +     generate code to modify these using non-atomic read-modify-write
> +     sequences.  Do not attempt to use bitfields to synchronize parallel
> +     algorithms.
> +
> + (*) Even in cases where bitfields are protected by locks, all fields
> +     in a given bitfield must be protected by one lock.  If two fields
> +     in a given bitfield are protected by different locks, the compiler's
> +     non-atomic read-modify-write sequences can cause an update to one
> +     field to corrupt the value of an adjacent field.
> +
> + (*) These guarantees apply only to properly aligned and sized scalar
> +     variables.  "Properly sized" currently means "int" and "long",
> +     because some CPU families do not support loads and stores of
> +     other sizes.  ("Some CPU families" is currently believed to
> +     be only Alpha 21064.  If this is actually the case, a different
> +     non-guarantee is likely to be formulated.)

This is a bit unclear.  Presumably you're talking about definiteness of
the outcome (as in what's seen after multiple stores to the same
variable).  The guarantees are only for natural width on Parisc as well,
so you would get a mess if you did byte stores to adjacent memory
locations.  But multiple 32 bit stores guarantees to see one of the
stored values as the final outcome.

James
