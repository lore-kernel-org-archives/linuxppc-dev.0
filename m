Date: Wed, 27 Dec 2000 15:37:13 -0800
From: Richard Henderson <rth@redhat.com>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: sailer@ife.ee.ethz.ch, Kaoru Fukui <k_fukui@highway.ne.jp>,
        linuxppc-dev@lists.linuxppc.org, gcc@gcc.gnu.org
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
Message-ID: <20001227153713.A30728@redhat.com>
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp> <or66kazecj.fsf@guarana.lsd.ic.unicamp.br> <3A4613FB.384BAD24@ife.ee.ethz.ch> <orsnnd3d6f.fsf@guarana.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <orsnnd3d6f.fsf@guarana.lsd.ic.unicamp.br>; from Alexandre Oliva on Sun, Dec 24, 2000 at 04:08:08PM -0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Dec 24, 2000 at 04:08:08PM -0200, Alexandre Oliva wrote:
> > Which is not backward compatible, unfortunately.
>
> Indeed.  I wish we had maintained the old syntax for
> backward-compatibility, even if with a deprecation warning.

We *have* maintained the old syntax.

But there are some quirky differences from the old behaviour wrt
initialization and sizeof that need to be resolved.  To wit:

 * The linux net/ code insists on initializing a zero-length array
   member with an empty initializer.  We should silently drop the
   initialization in this case.

 * Several places in the linux kernel expect sizeof of a zero-length
   array to be zero.  Typically this happens in some edge case like

	long stuff[N_WORDS-1]

   where a flexible array member isn't really wanted, but N_WORDS
   happens to be 1 for some configuration.

Fixing this compatibility stuff is on my to-do list.


r~

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
