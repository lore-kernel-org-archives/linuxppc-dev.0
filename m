Message-ID: <397F0006.24762F7@mvista.com>
Date: Wed, 26 Jul 2000 08:13:10 -0700
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Mike Flynn <mflynn@enerdyne.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmem_grow: Called nonatomically from int - size-32?
References: <67505026E29DD311A9AA00508B7315F33B735B@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mike,
You are trying to get a new piece of cache. The message occurs when
there is not one available. After the message appears the system goes
into a spinlock and tries again. This continues until the request is satisfied.

This could be an indication that you have a memory leak somewhere and
are not returning memory.
Cal

Mike Flynn wrote:

> We have been hacking away on a TI  16C554 quad UART driver based on
> serial.c. The driver supports the TI chip on our motherboard which hosts an
> Embedded Planet CLLF with an MOT 860T processor. We have all four ports
> working with interrupts, but we are seeing this message several times before
> the system hangs: "kmem_grow: Called nonatomically from int - size-32." It
> is issued from linux/mm/slab.c and obviously has something to do with shared
> memory. Does anyone have insight as to what we are (or are not doing) to
> upset slab.c?
>
> Thanks,
>
> Mike Flynn
> Principal Software Engineer
> Enerdyne Technologies
> 8402 Magnolia Ave.
> Suite C
> Santee, CA 92041
> Voice: 619-562-3061
> Fax: 619-562-8802
> MFlynn@Enerdyne.com
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Customer Support Engineer    490 Potrero Avenue
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         e-mail cal_erickson@mvista.com
Pager 877-566-2012           support 1-800-759-8888 pin 202-7489
web http://www.mvista.com    support e-mail: support@mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
