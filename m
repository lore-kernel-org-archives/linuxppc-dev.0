Message-ID: <3BE6E2B6.3010401@mvista.com>
Date: Mon, 05 Nov 2001 14:04:22 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Dag Nygren <dag@newtech.fi>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC 8259 handling suggestion and MPC107 in openpic
References: <20011102112155.3436.qmail@dag.newtech.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dag Nygren wrote:


> Seems like everyone having an i8259 wants to use it ;-)

You often must use it.  If device interrupts are wired to
it, you don't have a choice.

> for ( i =i8259_pic.irq_offset  ; i < i8259_pic.irq_offset +
> NUM_8259_INTERRUPTS  ; i++ )
>         irq_desc[i].handler = &i8259_pic;

Argh....you are just implementing what we had many years ago
when we attempted a multi-level interrupt controller design.

We have recently been discussing this on the embedded ppc list
as well.  IMHO, we should have a properly designed multi-level
interrupt controller software structure that maps to a hardware
design.  All interrupt controllers start numbering their interrupts
from zero, to some maximum number supported.  We should have
software objects and functions that understand and support this,
along with cascading controllers to any arbitrary interrupt at
a higher level.  Once we have this in place, we can place a "virtual"
layer (or anything else) on top to provide the useful abstractions
we need when using interrupts in the system.

>From our experience, by trying to merge these virtual abstractions
into the lowest level (irq_offset + NUM_INTERRUPTS kind of thing)
gives us a solution (hack :-) for one board but doesn't provide any
design flexibility that will be useful in a subsequent board port.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
