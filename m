Return-Path: <peter@hurleysoftware.com>
Received: from n23.mail01.mtsvc.net (mailout32.mail01.mtsvc.net [216.70.64.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 539881A0016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 23:54:27 +1000 (EST)
Message-ID: <53C53288.0@hurleysoftware.com>
Date: Tue, 15 Jul 2014 09:54:16 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oleg Nesterov <oleg@redhat.com>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	
 <20140712205130.GA16437@redhat.com> <1405208082.20996.54.camel@pasglop>	
 <53C2865B.5040200@hurleysoftware.com> <1405290324.20996.71.camel@pasglop>
In-Reply-To: <1405290324.20996.71.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 07/13/2014 06:25 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2014-07-13 at 09:15 -0400, Peter Hurley wrote:
>>
>> I'm not sure I understand your point here, Ben.
>>
>> Suppose that two different spinlocks are used independently to
>> protect r-m-w access to adjacent data. In Oleg's example,
>> suppose spinlock 1 is used for access to the bitfield and
>> spinlock 2 is used for access to freeze_stop.
>>
>> What would prevent an accidental write to freeze_stop from the
>> kt_1 thread?
>
> My point was to be weary of bitfields in general because access
> to them is always R-M-W, never atomic and that seem to escape
> people regularily :-) (Among other problems such as endian etc...)
>
> As for Oleg's example, it *should* have worked because the bitfield and
> the adjacent freeze_stop should have been accessed using load/stores
> that don't actually overlap, but the compiler bug causes the bitfield
> access to not properly use the basic type of the bitfield, but escalate
> to a full 64-bit R-M-W instead, thus incorrectly R-M-W'ing the field
> next door.

Yeah, ok, so just a generic heads-up about non-atomicity of bitfields,
and not something specific to Oleg's example. Thanks.

Jonathan Corbet wrote a LWN article about this back in 2012:
http://lwn.net/Articles/478657/

I guess it's fixed in gcc 4.8, but too bad there's not a workaround for
earlier compilers (akin to -fstrict_volatile_bitfields without requiring
the volatile keyword).

Regards,
Peter Hurley
