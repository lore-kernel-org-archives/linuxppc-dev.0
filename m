Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B60C1A007B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jul 2014 22:31:29 +1000 (EST)
Date: Sun, 13 Jul 2014 14:29:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: bit fields && data tearing
Message-ID: <20140713122950.GA16995@redhat.com>
References: <20140712181328.GA8738@redhat.com>
 <20140712205130.GA16437@redhat.com> <1405208082.20996.54.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405208082.20996.54.camel@pasglop>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Dan <opendtv@yahoo.com>,
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

On 07/13, Benjamin Herrenschmidt wrote:
>
> On Sat, 2014-07-12 at 22:51 +0200, Oleg Nesterov wrote:
> > OK, looks like this is compiler bug,
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080
> >
> > Thanks to Dan who informed me privately.
>
> So yes, there's is this compiler bug which means a bitfield
> access can cause a r-m-w access to a neighbouring field

Thanks. So I can forward this all back to bugzilla.

> but
> in general, I would be weary of bitfields anyway since accessing
> them isn't going to be atomic anyway... it's too easy to get things
> wrong and in most cases the benefit is yet to be demonstrated.

Sure, bit fields should be used with care. But the same arguments apply
to bitmasks, they are often used without "atomic" set/clear_bit.

> In your example, I don't see the point of the bitfield.

This is just test-case. The real code has more adjacent bit fields, only
the tracee can modify them, and only debugger can change ->freeze_stop.

Thanks,

Oleg.
