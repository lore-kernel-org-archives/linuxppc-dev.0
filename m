Date: Fri, 2 Jun 2000 16:40:59 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 7200 & bitkeeper/linuxcare devel?
In-Reply-To: <39379C61.E33FF001@pop.agri.ch>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000602162200.22680A-101000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="114856-390413143-959982059=:22680"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--114856-390413143-959982059=:22680
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Fri, 2 Jun 2000, Andreas Tobler wrote:

> Hi,
> has anyone gotten a bitkeeper 2.4.0test1-ac7 or a linuxcare 2.3.99p9 to
> boot under a 7200?

I think I know why the kernel fails to boot on your machine.  I had to get
around this problem for my current project.  I've sent a patch for it to
Paul about a week ago, but, so far, nothing happened yet.  Just in case,
the same patch is attached here.

In your last post, you had a xmon log which said something like ".....
vector: 700 ....", and I infer that kernel died with program check
exception.

Anyway, in arch/ppc/kernel/time.c, timer_interrupt() and do_gettimeofday()
use "mftb" instruction which is not implemented in PPC 601, hence, the
exception.  The patch workarounds this, but, personally, I feel the
previous implementation which just used DEC register was better than my
patch or the current one when all PPCs are considered.


Takashi Oe

--114856-390413143-959982059=:22680
Content-Type: APPLICATION/octet-stream; name="linux-pmac-devel-mftb.patch.gz"
Content-ID: <Pine.LNX.3.96LJ1.1b7.1000602164059.22680B@ofey.inetnebr.com>
Content-Description: 
Content-Transfer-Encoding: BASE64

H4sICF0cMDkAA2xpbnV4LXBtYWMtZGV2ZWwtbWZ0Yi5wYXRjaACdVl1z2jgU
fbZ/xW06u2sgDjYOSQulkxTYHWYCyfAxyT55jC3AU2N7ZBmS6ea/75UE1DYf
TeOH4Fj3nHt1dHQlz5/NQE/pAAI/TJ/1eOm4ukdWJNADh5GEVf3QDVKPVJ1k
qcexW41p5JIkiejFYg9zKljVdf09SZR+FMJtTKF2CTWjUa83TAtfDEOtVCq/
VYEychj0nReoXYNpNS4/N8y6ZLq5Ad28NM6voMJ/TANublT46JGZHxIFoNN+
HNrt+4d/FcVQqmVoR/GLPnXc71Cu7sU9DnvjrqKYPPCR+ozobEGjdL7IBY8e
hgO7070dKsaz1anz4I7DHOhSGlG49TyKVcOQzP2EEcqhlRx0OG5PONYwLjn2
yjAx2Alg7C8JtIMIa5vEMSJ3FDoP8A4y3Umm+jGmu2j9RqbJI2cy316TUOhw
UZLq7UXtqIoitwXRldCYuJQsSchy0hYA/d5oJJbF2C3L+O4b9P3CihRgo95I
6GjWdrARi6gzJ9ALEULTmOEXh6V5Gu4+y6hz91nG56L7Ot9ux9bdJoV837Lj
f2AVdcjWJeInGeykgC0sRw7b7j9skPgG4snJ0Y6WsUPJYY9Ke2ac+m6PSntm
nPpuj0p7Zpz6fo9Ke2ac+n6PcntufQoZmU8bVXr0p133l+e4W6VRM579Lbd6
vzwxHOouqrz3fic0xJbMUI8Ld79VH447eU4chiiPxBON3bzmR4RRx95+4og4
QpI/HerXDStzOlyZfHvi39onsTvTMPHnIaZ1ozRkNhrGjzzbI2GTq5n7GKZL
qO7FAcrKF2VHFEThHAInYTabNlVQKwlq77uFgOWMTW10mraKfK+kVn6oFSUf
sXICOzgXP2lTreC4FwEPU8QItJAjiakmNlOpuR1IswMTOfAK64UfENAk8kMe
WpLslLCUhqBpkuXLF7CMEvwJxrNryKcE/8mqEPDKMcdnhqtycmYyJZ7tsIrQ
ElicdsaBoPxhnEEDzlr0TJRbAjGDTXESeTy3VuYkJZlaCCFr4emgWlYBysBd
Qm1/tzV0mBOWgOsEAdKsF7ikbEHA2+5b3C3RitBZEK2Tc8Gw9tkCdgQJeH7i
TBF8Ie8fhnl+jfePmnVumsJjijCIslkDzcPCMCWax9VKWGULPD5RjFCwzo/+
DAx8/5U2G4dJfT6SICEo0+YjJtgqIUdD3OzIqfLOIuqBThT+xSAOcJ+4DnMX
aQxTwtZkM3uuBrBIiIVa+UwrycnVr8TkPtV2kyuzFeZ75pFNkQCenp5gjQqK
FAkhS860cFakKGwCyUvooup4ucMdFbzAC2GyxfmzELsctO8Hf/f+sUf9h5PK
ZIXhfS2viuh0RySRXbCV2bBcJbbSv7KVnSbEhQquDw96UzdoCpVqhugyNYs7
QYikZGZtCxAWhAfFsNvvDsZdfimdDMa8IfAKlL1MLZABD91h775jDyb9w7G8
IRViO92BjMUGIcRq7ZoP4rfPK3CxACXWPiTL2N5dt23f4y798TN0++C+spfe
BVrFn1Js69zQlKsLyqv6P+9nY3uQDAAA
--114856-390413143-959982059=:22680--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
