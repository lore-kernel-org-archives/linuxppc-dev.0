Message-Id: <37D8F922.67F18F1F@ssl.co.uk>
Date: Fri, 10 Sep 1999 13:27:14 +0100
From: Sacha Varma <sacha@ssl.co.uk>
Mime-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
References: <19990910135935.015493@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Fri, Sep 10, 1999, Sacha Varma <sacha@ssl.co.uk> wrote:
> 
> >In the meantime to learn more about Altivec I've been working on a 
> >library to emulate the instructions [...] (It'll
> >be C++ I'm afraid - the vector types lend themselves nicely to a
> >template class, and a lot of the vec_* instructions are
> >overloaded).
> 
> If your library can be turned into plain C, then we should be able 
> to implement the same emulation mecanism in Linux, but is it really
> interesting ? It will be way too slow to be useful for anything but
> developers prototyping Altivec code on G3s.

The main reason I'm doing it is to learn about what's available in Altivec. But
I guess it would also be useful (some of these are pretty far-fetched but hey)
for:

1. (as you say) People who don't yet have a G4
We outside the US are subject to its export laws. Who knows when we'll see them
here in the UK.

2. Those who don't yet have an Altivec compiler
I don't want to develop under MacOS (MPW, MrC) and, as a hobbyist, can't justify
$375 for CodeWarrior, and I don't have the knowledge to patch up gcc and the
Linux kernel.

3. People who want code that's optimised for G4 but also builds on G3
You could use the altivec API when coding and then have a header (as I do) with:

  #ifndef __VEC__
    /* software emulation */
  #else
    /* use native instructions */
  #endif

Granted, maybe my library - which isn't written with performance considerations
in mind - will be much slower than ditching the altivec API and re-writing your
code, but the principle seems sound: portability with virtually no code changes.

4. People who like the Altivec API
Maybe you dig the Altivec API but code for another platform. You could even dive
in and replace the core of the library with MMX or whatever where possible.

5. People who want to know what a particular instruction does
They could browse the library source code. I'm not saying that my library will
be correct (I admit I don't fully understand what some of the instructions do,
e.g. the saturated ones) but hopefully it would eventually be. And the code
might be clearer than the sometimes terse descriptions in the Altivec
documentation.

6. If Altivec is extended in the a future incarnation
Ok I'm clutching at straws here, but maybe new instructions will be added down
the line; if a library exists which is easily extended, people would be able to
get start using them pretty much right away.


--
sacha varma : system simulation ltd : sacha@ssl.co.uk

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
