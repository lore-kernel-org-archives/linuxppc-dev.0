To: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System crash in kernel_thread 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 03 Jun 2003 12:12:54 +0200."
             <742AC4678EF8464697DDDFE3B40F6ECD07E2CE@srv-mailrnd.azisa.co.za>
Date: Tue, 03 Jun 2003 13:18:27 +0200
Message-Id: <20030603111832.7D90BC5492@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Flavio,

in message <742AC4678EF8464697DDDFE3B40F6ECD07E2CE@srv-mailrnd.azisa.co.za> you wrote:
>
> >One pretty common reason is that your SDRAM initialization sequence
> >may be buggy and/or incomplete, and you experience memory errors. Re-
> >member that more is required than just adapting the UPM tables.
>
> Hmmm, that is interesting. Does Linux require that burst mode access be
> enabled, right now I have the BI bit set in the OR register. I also

It is most likely that the RAM errors happen when you use  bust  mode
accesses - which happens a lot when Linux starts working.

> ported SD-RAM tests into u-boot, the tests the entire memory range with
> pattern and address and this looks good. I've obviously had to change

I guess you know that there are already pretty extensive memory tests
available in U-Boot (see the post/ code).

The problem is, all these tests will not exercise burts mode accesses
the same way as Linux will do it, especially when Linux starts moving
lot's of data over the network (DMA).

> the UPM config, OR, BR registers, MCR register, MAMR register. I can't
> think of anything else that would require some attention. Could this in
> any way be related to cache?

It has nothing to do with cache. As I  wrote  befor,  there  is  more
things  necessary  to  initialize  the  RAM  correctly. Read the chip
manufacturers documentation and  follow  the  init  sequence  TO  THE
LETTER.  This  may include certain delays, dummy accesses, etc. It is
_NOT_ sufficient to just program the UPM tables,  OR,  BR,  MCR,  and
MAMR registers.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You see things; and you say ``Why?'' But I dream  things  that  never
were; and I say ``Why not?''
       - George Bernard Shaw _Back to Methuselah_ (1921) pt. 1, act 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
