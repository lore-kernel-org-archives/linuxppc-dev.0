Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D72D71A007F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 14:06:53 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 4 Sep 2014 22:06:51 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0DFE03E40030
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 22:06:48 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8544tfW46530602
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 06:04:55 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s854BC5r022814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Sep 2014 22:11:13 -0600
Date: Thu, 4 Sep 2014 21:06:45 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905040645.GO5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
 <1409883098.5078.14.camel@jarvis.lan>
 <5409243C.4080704@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5409243C.4080704@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-arch@vger.kernel.org,
 linux-ia64@vger.kernel.org, Mikael Pettersson <mikpelinux@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Tony Luck <tony.luck@intel.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 10:47:24PM -0400, Peter Hurley wrote:
> Hi James,
> 
> On 09/04/2014 10:11 PM, James Bottomley wrote:
> > On Thu, 2014-09-04 at 17:17 -0700, Paul E. McKenney wrote:
> >> +And there are anti-guarantees:
> >> +
> >> + (*) These guarantees do not apply to bitfields, because compilers often
> >> +     generate code to modify these using non-atomic read-modify-write
> >> +     sequences.  Do not attempt to use bitfields to synchronize parallel
> >> +     algorithms.
> >> +
> >> + (*) Even in cases where bitfields are protected by locks, all fields
> >> +     in a given bitfield must be protected by one lock.  If two fields
> >> +     in a given bitfield are protected by different locks, the compiler's
> >> +     non-atomic read-modify-write sequences can cause an update to one
> >> +     field to corrupt the value of an adjacent field.
> >> +
> >> + (*) These guarantees apply only to properly aligned and sized scalar
> >> +     variables.  "Properly sized" currently means "int" and "long",
> >> +     because some CPU families do not support loads and stores of
> >> +     other sizes.  ("Some CPU families" is currently believed to
> >> +     be only Alpha 21064.  If this is actually the case, a different
> >> +     non-guarantee is likely to be formulated.)
> > 
> > This is a bit unclear.  Presumably you're talking about definiteness of
> > the outcome (as in what's seen after multiple stores to the same
> > variable).
> 
> No, the last conditions refers to adjacent byte stores from different
> cpu contexts (either interrupt or SMP).
> 
> > The guarantees are only for natural width on Parisc as well,
> > so you would get a mess if you did byte stores to adjacent memory
> > locations.
> 
> For a simple test like:
> 
> struct x {
> 	long a;
> 	char b;
> 	char c;
> 	char d;
> 	char e;
> };
> 
> void store_bc(struct x *p) {
> 	p->b = 1;
> 	p->c = 2;
> }
> 
> on parisc, gcc generates separate byte stores
> 
> void store_bc(struct x *p) {
>    0:	34 1c 00 02 	ldi 1,ret0
>    4:	0f 5c 12 08 	stb ret0,4(r26)
>    8:	34 1c 00 04 	ldi 2,ret0
>    c:	e8 40 c0 00 	bv r0(rp)
>   10:	0f 5c 12 0a 	stb ret0,5(r26)
> 
> which appears to confirm that on parisc adjacent byte data
> is safe from corruption by concurrent cpu updates; that is,
> 
> CPU 0                | CPU 1
>                      |
> p->b = 1             | p->c = 2
>                      |
> 
> will result in p->b == 1 && p->c == 2 (assume both values
> were 0 before the call to store_bc()).

What Peter said.  I would ask for suggestions for better wording, but
I would much rather be able to say that single-byte reads and writes
are atomic and that aligned-short reads and writes are also atomic.

Thus far, it looks like we lose only very old Alpha systems, so unless
I hear otherwise, I update my patch to outlaw these very old systems.

						Thanx, Paul
