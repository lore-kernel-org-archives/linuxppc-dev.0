Message-ID: <20011105191454.25617.qmail@dag.newtech.fi>
To: Dan Malek <dan@mvista.com>
Cc: Dag Nygren <dag@newtech.fi>, linuxppc-dev@lists.linuxppc.org,
	dag@newtech.fi
Subject: Re: RFC 8259 handling suggestion and MPC107 in openpic 
In-Reply-To: Message from Dan Malek <dan@mvista.com>
   of "Mon, 05 Nov 2001 14:04:22 EST." <3BE6E2B6.3010401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Nov 2001 21:14:54 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Dag Nygren wrote:
>
>
> > Seems like everyone having an i8259 wants to use it ;-)
>
> You often must use it.  If device interrupts are wired to
> it, you don't have a choice.
>
> > for ( i =i8259_pic.irq_offset  ; i < i8259_pic.irq_offset +
> > NUM_8259_INTERRUPTS  ; i++ )
> >         irq_desc[i].handler = &i8259_pic;
>
> Argh....you are just implementing what we had many years ago
> when we attempted a multi-level interrupt controller design.

Just hate to see the same code duplicated 5-10 times in the different
xxxx_setup.c files.

> We have recently been discussing this on the embedded ppc list
> as well.  IMHO, we should have a properly designed multi-level
> interrupt controller software structure that maps to a hardware
> design.  All interrupt controllers start numbering their interrupts
> from zero, to some maximum number supported.  We should have
> software objects and functions that understand and support this,
> along with cascading controllers to any arbitrary interrupt at
> a higher level.  Once we have this in place, we can place a "virtual"
> layer (or anything else) on top to provide the useful abstractions
> we need when using interrupts in the system.

You are quite right, but until we have this abstraction we could have
the above code in the i8259 "module".
Thus saving the porting guys some code duplication.

> From our experience, by trying to merge these virtual abstractions
> into the lowest level (irq_offset + NUM_INTERRUPTS kind of thing)
> gives us a solution (hack :-) for one board but doesn't provide any
> design flexibility that will be useful in a subsequent board port.

Would my revised open_pic be a starting point ?
Even if I did not think as far as you suggest now.



Dag


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
