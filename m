Subject: Re: Disabling interrupts
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Fri, 24 Mar 2000 09:31:15 +1100 (EST)
In-Reply-To: <Pine.LNX.4.21.0003231654120.31863-100000@sunapee.transcept.com> from "Pavel Roskin" at Mar 23, 2000 04:58:52 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000323223115.B0179355D8@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why don't you just use DMA? Have a couple of buffers and flip between
them writing the data to disk while the DMA controller handles the
reads. Again, this will mean writing a module.

Greg.

Quoth Pavel Roskin:
> > Does it have to be a user mode piece of code?  You're going to have real
> > trouble figuring that out if so.  Could you put that small portion of code
> > into a kernel module and just load it from your user program to do what it
> > needs to?
>
> Well, this code needs to read some data continously. Then the data must
> be processed and written to a file.
>
> If you expect problems, I could create a new syscall and pass a buffer to
> it. Probably this should be Ok. But the buffer can be huge (comparable
> with the RAM size), so I would like to avoid copying data. This means that
> the kernel needs to write to the userspace buffer directly.

--
+----------------------------------------------------+
| Do you want to know more?                          |
|               --== Greg Johnson ==--               |
| HW/SW Engineer      gjohnson@research.canon.com.au |
| Canon   Information  Systems   Research  Australia |
| 1 Thomas Holt Dr, North Ryde, NSW, 2113, Australia |
| "I FLEXed my BISON and it went YACC!" - me.        |
+----------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
