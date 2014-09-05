Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0A0F1A0791
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 11:57:33 +1000 (EST)
Message-ID: <54091881.7080909@hurleysoftware.com>
Date: Thu, 04 Sep 2014 21:57:21 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: paulmck@linux.vnet.ibm.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>
 <21512.10628.412205.873477@gargle.gargle.HOWL>
 <20140904090952.GW17454@tucnak.redhat.com>
 <540859EC.5000407@hurleysoftware.com>
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>
 <5408C0AB.6050801@hurleysoftware.com> <5408E4A3.2060303@zytor.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
In-Reply-To: <20140905001751.GL5001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Mikael Pettersson <mikpelinux@gmail.com>, linux-alpha@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org,
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

[ +cc linux-alpha ]

Hi Paul,

On 09/04/2014 08:17 PM, Paul E. McKenney wrote:
> On Thu, Sep 04, 2014 at 03:16:03PM -0700, H. Peter Anvin wrote:
>> On 09/04/2014 12:42 PM, Peter Hurley wrote:
>>>
>>> Or we could give up on the Alpha.
>>>
>>
>> If Alpha is turning into Voyager (kept alive only as a museum piece, but
>> actively causing problems) then please let's kill it.
> 
> Sorry for being slow to join this thread, but I propose the following
> patch.  If we can remove support for all CPUs that to not support
> direct access to bytes and shorts (which I would very much like to
> see happen), I will remove the last non-guarantee.
> 
> 							Thanx, Paul

Although I don't mind the patch below, I don't think the bitfield thing
happened because anyone was confused about what the compiler would do;
here, it's more a case of legacy code that came out from under the
Big Kernel Lock and the bitfield was an oversight.

However, my patch to fix it by splitting the bitfield into 4 bytes
was rejected as insufficient to prevent accidental sharing. This is
what spun off the Alpha discussion about non-atomic byte updates.

FWIW, there are a bunch of problems with both the documentation and
kernel code if adjacent bytes can be overwritten by a single byte write.

Documentation/atomic-ops.txt claims that properly aligned chars are
atomic in the same sense that ints are, which is not true on the Alpha
(hopefully not a possible optimization on other arches -- I tried
with the ia64 cross compiler but it stuck with byte-sized writes).

Pretty much any large aggregate kernel structure is bound to have some
byte-size fields that are either lockless or serialized by different
locks, which may be corrupted by concurrent updates to adjacent data.
IOW, ACCESS_ONCE(), spinlocks, whatever, doesn't prevent adjacent
byte-sized data from being overwritten. I haven't bothered to count
how many global bools/chars there are and whether they might be
overwritten by adjacent updates.

Documentation/circular-buffers.txt and any lockless implementation based
on or similar to it for bytes or shorts will be corrupted if the head
nears the tail.

I'm sure there's other interesting outcomes that haven't come to light.

I think that 'naturally aligned scalar writes are atomic' should be the
minimum arch guarantee.

Regards,
Peter Hurley


> ------------------------------------------------------------------------
> 
> documentation: Record limitations of bitfields and small variables
> 
> This commit documents the fact that it is not safe to use bitfields
> as shared variables in synchronization algorithms.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 87be0a8a78de..a28bfe4fd759 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -269,6 +269,26 @@ And there are a number of things that _must_ or _must_not_ be assumed:
>  	STORE *(A + 4) = Y; STORE *A = X;
>  	STORE {*A, *(A + 4) } = {X, Y};
>  
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
> +
>  
>  =========================
>  WHAT ARE MEMORY BARRIERS?
 
