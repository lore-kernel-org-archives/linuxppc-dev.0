Return-Path: <mikpelinux@gmail.com>
Received: from mail-la0-x232.google.com (mail-la0-x232.google.com
 [IPv6:2a00:1450:4010:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 353F01A093E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:57:47 +1000 (EST)
Received: by mail-la0-f50.google.com with SMTP id mc6so11325888lab.23
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Sep 2014 01:57:43 -0700 (PDT)
From: Mikael Pettersson <mikpelinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <21512.10628.412205.873477@gargle.gargle.HOWL>
Date: Thu, 4 Sep 2014 10:57:40 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: bit fields && data tearing
In-Reply-To: <1409785893.30640.118.camel@pasglop>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com>
 <1409785893.30640.118.camel@pasglop>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-arch@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Hurley <peter@hurleysoftware.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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

Benjamin Herrenschmidt writes:
 > On Wed, 2014-09-03 at 18:51 -0400, Peter Hurley wrote:
 > 
 > > Apologies for hijacking this thread but I need to extend this discussion
 > > somewhat regarding what a compiler might do with adjacent fields in a structure.
 > > 
 > > The tty subsystem defines a large aggregate structure, struct tty_struct.
 > > Importantly, several different locks apply to different fields within that
 > > structure; ie., a specific spinlock will be claimed before updating or accessing
 > > certain fields while a different spinlock will be claimed before updating or
 > > accessing certain _adjacent_ fields.
 > > 
 > > What is necessary and sufficient to prevent accidental false-sharing?
 > > The patch below was flagged as insufficient on ia64, and possibly ARM.
 > 
 > We expect native aligned scalar types to be accessed atomically (the
 > read/modify/write of a larger quantity that gcc does on some bitfield
 > cases has been flagged as a gcc bug, but shouldn't happen on normal
 > scalar types).
 > 
 > I am not 100% certain of "bool" here, I assume it's treated as a normal
 > scalar and thus atomic but if unsure, you can always use int.

Please use an aligned int or long.  Some machines cannot do atomic
accesses on sub-int/long quantities, so 'bool' may cause unexpected
rmw cycles on adjacent fields.

/Mikael

 > 
 > Another option is to use the atomic bitops and make these bits in a
 > bitmask but that is probably unnecessary if you have locks already.
 > 
 > Cheers,
 > Ben.
 > 
 > 
 > > Regards,
 > > Peter Hurley
 > > 
 > > --- >% ---
 > > Subject: [PATCH 21/26] tty: Convert tty_struct bitfield to bools
 > > 
 > > The stopped, hw_stopped, flow_stopped and packet bits are smp-unsafe
 > > and interrupt-unsafe. For example,
 > > 
 > > CPU 0                         | CPU 1
 > >                               |
 > > tty->flow_stopped = 1         | tty->hw_stopped = 0
 > > 
 > > One of these updates will be corrupted, as the bitwise operation
 > > on the bitfield is non-atomic.
 > > 
 > > Ensure each flag has a separate memory location, so concurrent
 > > updates do not corrupt orthogonal states.
 > > 
 > > Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
 > > ---
 > >  include/linux/tty.h | 5 ++++-
 > >  1 file changed, 4 insertions(+), 1 deletion(-)
 > > 
 > > diff --git a/include/linux/tty.h b/include/linux/tty.h
 > > index 1c3316a..7cf61cb 100644
 > > --- a/include/linux/tty.h
 > > +++ b/include/linux/tty.h
 > > @@ -261,7 +261,10 @@ struct tty_struct {
 > >  	unsigned long flags;
 > >  	int count;
 > >  	struct winsize winsize;		/* winsize_mutex */
 > > -	unsigned char stopped:1, hw_stopped:1, flow_stopped:1, packet:1;
 > > +	bool stopped;
 > > +	bool hw_stopped;
 > > +	bool flow_stopped;
 > > +	bool packet;
 > >  	unsigned char ctrl_status;	/* ctrl_lock */
 > >  	unsigned int receive_room;	/* Bytes free for queue */
 > >  	int flow_change;
 > 
 > 
 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/

-- 
