To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Oct 2001 23:37:34 +0200."
             <20011015213734.24146@smtp.adsl.oleane.com>
Date: Tue, 16 Oct 2001 00:04:24 +0200
Message-Id: <20011015220429.3AD8B10887@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Ben,

in message <20011015213734.24146@smtp.adsl.oleane.com> you wrote:
>
> No, I want to get rid of bt_t. There will be a bi_rec for clocks,
> one for cmd line, etc... and possibly all sort of custom bi_recs
> you want for your boards.
>
> Any bit of kernel can then do a find_birec(type) type call to get
> the bi_rec it wants at any time.

OK. Sounds fine to me.

> Ok, time to write things down ;) I'm not sure we even all have the
> same ideas in mind as the bi_rec scheme constructed on the result of
> numerous discussions on mailing lists and irc.

Thanks - I apologize that I'm insisting on some "formal" description,
but I feel it's important enough to make sure everybody  has  exactly
the same understanding.

> But we don't want kernels & bootloader to rely on it. The bootloader
> must behave as if it was talking to a wrapper (which does the unzip
> operation in most cases) so that any interface chance we may want
> to add can go to that wrapper.

I would like to ask to make the unzip part optional.

> non native ways (that is a firmware not doing bi_recs). The goal is
> to have the code for converting the firmware interface to bi_recs
> be kept in the wrapper and not in the kernel.

Agreed.

> >- which functions are _required_ in all cases by the wrapper?
>
> Any knowledge specific to the low level firmware interface should stay
> there. We eventually wanted to have the unzipping function there as
> well, which also implies the relocating in cases the kernel can be
> loaded at a different address than 0.

Please do NOT make  the  unzip  part  a  required  operation  in  the
wrapper!  This  may  be  a  convenient thing to do in many cases, but
there are other  situations;  in  some  embedded  systems  which  are
optimized  for  minimal  boot time after power-on I don't have enough
time to uncompress an image - I must be able to boot an  uncompressed
kernel as well.

And if the firmware knows how to uncompress an image - why  should  I
duplicate the code in the wrapper?


Also, the design should NOT require that the wrapper and  the  kernel
are linked against each other in any way.

> I think the point isn't clear for everybody about the embedded case
> as we mostly deal with evil firmwares ;) The above is my view of it,
> and what I intend to code in the 2.5 timeframe. Other people may have
> other views I didn't understood or didn't agree with ;) Ultimately,
> Paulus will decide what will get in.

Well, you can count on my vote for your  proposal  if  it  should  be
asked for. It makes sense to me.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
      Bugs are by far the largest and  most successful class of
      entity, with nearly a million known species. In this res-
      pect they outnumber all the other  known  creatures about
      four to one.  -- Professor Snope's Encyclopedia of Animal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
