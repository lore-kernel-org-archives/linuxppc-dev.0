In-Reply-To: <199902171250.HAA00182@darkstar.prodigy.com>
Date: Wed, 17 Feb 1999 18:27:16 +0100
To: Bill Davidsen <davidsen@prodigy.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [ppc-dev] Re: Restructuring Efforts
Message-Id: <19990217182716.027588@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 17, 1999, Bill Davidsen <davidsen@prodigy.com> wrote:

>Well, you can preserve readability if you are willing to put the
>machine types in an enum and make use of "pointer to function
>returning" arrays. So instead of doing something like init_mem() you
>would use (*init_mem[_machine])() instead.

What we are trying to do here is a HAL ;-) 

I like the function pointers idea but I don't like indexing by machines
each time the table is accessed. I beleive we should define a structure
of function pointers for each subsystem (setup, mm, irq, ...) at have
some boot logic fill the kernel static tables with pointers from the
subsystem exported tables. The decision based on the architecure must be
done only once.

Eventually, those tables could be "optimised" so that they are all in the
same page, each table beeing aligned on a cache line boundary.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
