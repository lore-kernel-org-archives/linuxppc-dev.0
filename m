Date: Tue, 22 Feb 2000 12:50:19 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
cc: Paul Mackerras <paulus@linuxcare.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Patch for optimize context switch
In-Reply-To: <38B27416.5F4280D5@cnet.francetelecom.fr>
Message-ID: <Pine.HPX.4.10.10002221242260.4957-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 22 Feb 2000, FASSINO Jean-Philippe wrote:

> FASSINO Jean-Philippe wrote:
>
> > FASSINO Jean-Philippe wrote:
> >
> >   ------------------------------------------------------------------------
> > Context switching - times in microseconds - smaller is better
> > -------------------------------------------------------------
> > Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
> >                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> > --------- ------------- ----- ------ ------ ------ ------ ------- -------
> > ppc-linux Linux 2.2.15p    1      7     90    26    107      31     222
> > ppc-linux Linux 2.2.15p    1      7     91    26    110      29     257
> > ppc-linux Linux 2.2.15p    1      7     90    25    112      26     233
> > ppc-linux Linux 2.2.15p    1      7     92    25    126      27     243
> > ppc-linux Linux 2.2.15p    1      7    147    26    150      27     245
>
> > ppc-linux Linux 2.2.15p    0      7     92    25    136      28     270
> > ppc-linux Linux 2.2.15p    1      8     90    27    103      27     211
> > ppc-linux Linux 2.2.15p    0      9     90    30    112      32     228
> > ppc-linux Linux 2.2.15p    1      7     91    25    130      29     277
> > ppc-linux Linux 2.2.15p    1      7     90    25    105      26     211
>
> Sorry i forgot to say :
>     - 5 first run is without patch
>     - 5 last run is with path

That's largely in the noise: results with processes which do not pollute
cache are slightly better wit the patch. But I don't consider this a real
life situation. Processes which actually do some work don't see any
practical difference. The 147 microseconds in the 3rd column is very
probably a bogus point due to collision on L2 cache which is only 2 way
set associative.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
