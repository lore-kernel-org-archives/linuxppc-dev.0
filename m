Return-Path: <jose.franca@nsn.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SKB corruption on heavy traffic
Date: Mon, 5 May 2008 09:54:47 +0100
Message-ID: <56DEE2D3217CD946B290399093C8FA7C2131DD@PTLIEXC001.nsn-intra.net>
In-Reply-To: <8496f91a0805030707q136a7d5cv6e9472997c041cff@mail.gmail.com>
From: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
To: <matvejchikov@gmail.com>, <Myron.Dixon@l-3com.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

  Thanks for your contribution! We will try it right away! :))
  As for patches, we also installed some patches provided by freescale =
and nothing so far... Still the same problems.
  I will post the results as soon as I can...

Thanks U ALL!
Filipe.

-----Original Message-----
From: ext Matvejchikov Ilya [mailto:matvejchikov@gmail.com]=20
Sent: s=E1bado, 3 de Maio de 2008 15:08
To: Myron.Dixon@l-3com.com
Cc: Franca, Jose (NSN - PT/Portugal - MiniMD); linuxppc-dev@ozlabs.org; =
linuxppc-embedded@ozlabs.org
Subject: Re: SKB corruption on heavy traffic

Hi all!

The same problem! I've tried 2.4.xx and 2.6.xx kernels. Nothing changed!
BUT. After many days of fucking with fs_enet driver I've found a
stable (as I see) solution. The bugs I've had:
 - kernel oopses
 - SKB data corruption
 - BDs status corruption
 - SKB ring full message
 - too many RX errors
 - may be something else :)

For now I have a 2.4.35 fs_enet driver that works on heavy load
24/7... I don't know what happens with my 8260 board, but with this
code it be very stable. I supposed that there are some errors in 8260
CPM core, but errata don't know about it :)

I've append an attachment with my 2.4.35 kernel patch. Sorry for a big
file and not for only fs_enet file. Moreover I've used CPM111 errata
microcode and NAPI in fs_enet driver.

If you have any questions I'm glad to hear it.

2008/5/2  <Myron.Dixon@l-3com.com>:
> We have experience a very similar problem using a 2.4.18 kernel on an =
8260 ppc processor.
>  We have a telecomunication product that for some time only used the =
fec for TCP/IP ethernet
>  traffic only and worked just fine.
>
>  After we upgraded our product to implement TDM data over IP we =
started to notice an occasional
>  kernel oops.  We began to evaluate all of our products and determined =
that only some of the units
>  exhibted this behaviour at various rates of occurrence.  Further =
evaluation revealed that the pointers
>  located in dpram pointing to the fec's buffer descriptors were some =
how getting corrupted.
>  Note that the 8260 has 4 internal scc/fccs and we use all four for =
various aspects of our application
>  and each shares dpram for pointers to buffer descriptors that reside =
in sdram.  However, only the
>  fec that is used for IP experiences this buffer descriptor corruption =
and, then, apparently, only under
>  heavy traffic load.  We spent about six months evaluating this =
problem including contacting freescale,
>  but never found a solution.  We finally, decided to use an external =
ethernet chip on a daughter card
>  for our IP channel.
>
>  It is, however, our belief that our problem relates to a possible bug =
in the 8260 CPM, but have yet to
>  absolutely prove this.
>
>  If we are experiencing the same problem (and potentially others) and =
there is a solution we would be
>  very interested, as, we are not happy about the daughter card =
solution.
>
>
>  Myron L. Dixon
>  Sr. Software Engineer
>  L-3 Communications, GNS
>  1519 Grundy's Lane
>  Bristol, PA 19007
>  Phone:  215 957 3739
>  Fax:  215 957 3790
>  email:  Myron.Dixon@L-3Com.com
>
>  -----Original Message-----
>  From: linuxppc-dev-bounces+myron.dixon=3Dl-3com.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+myron.dixon=3Dl-3com.com@ozlabs.org] On =
Behalf Of Franca, Jose (NSN - PT/Portugal - MiniMD)
>  Sent: Wednesday, April 30, 2008 5:07 AM
>  To: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
>  Subject: FW: SKB corruption on heavy traffic
>
>  From our latest debugs we found that the problem occurs mainly on =
skbuff code. After some variable time kfree or kalloc result in kernel =
oops.
>
>  -----Original Message-----
>  From: Franca, Jose (NSN - PT/Portugal - MiniMD)
>  Sent: quarta-feira, 30 de Abril de 2008 9:44
>  To: 'ext Scott Wood'
>  Cc:
>  Subject: RE: SKB corruption on heavy traffic
>
>  Hello!
>
>         Thank you for replying!
>         It't quite dificult to say if the problem exists without our =
changes, since the all software is dependent on this changes so to work =
with the hardware. I can't answer to that right now on that, but I =
forgot to add one thing: we have ring buffer full problems on our =
fcc_enet driver from time to time. So, I think the problem could be on =
linux configurations (related to hw) because there is a lot of posts on =
the web related to problems similar to this (none of them has really =
solved the bottom problem).
>
>  Regards,
>  Filipe
>
>  -----Original Message-----
>  From: ext Scott Wood [mailto:scottwood@freescale.com]
>  Sent: ter=E7a-feira, 29 de Abril de 2008 20:15
>  To: Franca, Jose (NSN - PT/Portugal - MiniMD)
>  Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
>  Subject: Re: SKB corruption on heavy traffic
>
>  On Tue, Apr 29, 2008 at 07:39:07PM +0100, Franca, Jose (NSN - =
PT/Portugal - MiniMD) wrote:
>  >       We are developing a MPC8247 based telecom board (512MB), =
using linux
>  > 2.4 with some proprietary changes on IP stack and we are facing =
some
>  > problems when we have heavy traffic on our Ethernet interfaces...
>
>  Do you see these problems without the proprietary changes, and with a =
current kernel?
>
>  -Scott
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>  _______________________________________________
>  Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
