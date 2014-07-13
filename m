Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C3731A0149
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 08:25:44 +1000 (EST)
Message-ID: <1405290324.20996.71.camel@pasglop>
Subject: Re: bit fields && data tearing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Hurley <peter@hurleysoftware.com>
Date: Mon, 14 Jul 2014 08:25:24 +1000
In-Reply-To: <53C2865B.5040200@hurleysoftware.com>
References: <20140712181328.GA8738@redhat.com>
 <20140712205130.GA16437@redhat.com> <1405208082.20996.54.camel@pasglop>
 <53C2865B.5040200@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Dan <opendtv@yahoo.com>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-07-13 at 09:15 -0400, Peter Hurley wrote:
> 
> I'm not sure I understand your point here, Ben.
> 
> Suppose that two different spinlocks are used independently to
> protect r-m-w access to adjacent data. In Oleg's example,
> suppose spinlock 1 is used for access to the bitfield and
> spinlock 2 is used for access to freeze_stop.
> 
> What would prevent an accidental write to freeze_stop from the
> kt_1 thread?

My point was to be weary of bitfields in general because access
to them is always R-M-W, never atomic and that seem to escape
people regularily :-) (Among other problems such as endian etc...)

As for Oleg's example, it *should* have worked because the bitfield and
the adjacent freeze_stop should have been accessed using load/stores
that don't actually overlap, but the compiler bug causes the bitfield
access to not properly use the basic type of the bitfield, but escalate
to a full 64-bit R-M-W instead, thus incorrectly R-M-W'ing the field
next door.

Cheers,
Ben.
