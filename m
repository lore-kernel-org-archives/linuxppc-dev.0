Message-ID: <39B4D9CF.FEED2CB8@agelectronics.co.uk>
Date: Tue, 05 Sep 2000 12:32:31 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: improved processor config for G3s
References: <Pine.HPX.4.10.10009041309060.15438-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> So you need at least 3 writes, or to have one store buffer busy with a
> previous write, to trigger the store gathering mechanism. This makes it
> impossible to predict whether it will be used or not, and IMO not worth
> the potential trouble since it will actually happen quite infrequently.

This condition should be satisfied by memcpy_toio(). It won't be
satisfied by fb_memmove(), which is the function that makes large
virtual consoles on PowerPC so slow.

It might be more interesting to try an implementation of memcpy_toio()
using the DMA engines of the 106/7.

- Adrian Cox, AG Electronics

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
