Date: Thu, 19 Apr 2001 22:43:32 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] gettimeofday stability
Message-ID: <20010419224332.A1021@ibrium.se>
References: <20010412010756.A668@ibrium.se> <Pine.HPX.4.10.10104161316490.1891-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10104161316490.1891-100000@gra-ux1.iram.es>; from paubert@iram.es on Mon, Apr 16, 2001 at 01:25:56PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 16, 2001 at 01:25:56PM +0200, Gabriel Paubert wrote:
> > Ideally, TB should not be touched. Indeed, MOL can run without
> > touching TB (but DEC is essential). However, TB needs to be
> > modified for 'save session' feature to work. Basically, the RAM
> > and cpu state of MacOS is flushed to disk. At a later time,
> > MacOS can be restarted instantly. The problem is that MacOS can't
> > deal with the TB skip that occurs if the timebase is not restored
> > (no big surprise there).
>
> By touching the TB, you'll also break all other Linux applications which
> may have a valid use for the TB.

The only noticeable effect is a small clock drift originating from
the loading and restoring of the timebase (and of course, only when
MOL is running). Whatever MOL puts into TB/DEC is completely
invisible to other processes.

Anyway, I'll see if I can locate and patch away the use of
the timebase register in MacOS - that would allow the
save-session feature to work without having to touch the TB.

> BTW: how do you handle multiple MOL sessions ?

Mutli-session support was actually added a few days ago -
a matter of making sure the MOL kernel module keeps session
specific data in a single struct, passed as a parameter.

> > Anyway, the negative offset check is desirable even if it is
> > only the DEC that is touched.
>
> No, it is not, is is a textbook case of curing the symptom instead of the
> cause.

Well, what I was looking for was a change to remove the assumption
that the timer code was the sole user of the DEC register. Pauls
change seems fix that neatly.


Regards,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
