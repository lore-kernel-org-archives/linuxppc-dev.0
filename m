Return-Path: <Myron.Dixon@L-3com.com>
From: Myron.Dixon@L-3com.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SKB corruption on heavy traffic
Date: Thu, 1 May 2008 16:55:54 -0400
Message-ID: <F83A28966A0FAF41897D75586AFBBF5134A1FC@gns-mail.GNS.L-3COM.COM>
In-Reply-To: <56DEE2D3217CD946B290399093C8FA7C212E48@PTLIEXC001.nsn-intra.net>
To: "Franca, Jose \(NSN - PT/Portugal - MiniMD\)" <jose.franca@nsn.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have experience a very similar problem using a 2.4.18 kernel on an =
8260 ppc processor.
We have a telecomunication product that for some time only used the fec =
for TCP/IP ethernet=20
traffic only and worked just fine.

After we upgraded our product to implement TDM data over IP we started =
to notice an occasional
kernel oops.  We began to evaluate all of our products and determined =
that only some of the units
exhibted this behaviour at various rates of occurrence.  Further =
evaluation revealed that the pointers
located in dpram pointing to the fec's buffer descriptors were some how =
getting corrupted.
Note that the 8260 has 4 internal scc/fccs and we use all four for =
various aspects of our application
and each shares dpram for pointers to buffer descriptors that reside in =
sdram.  However, only the
fec that is used for IP experiences this buffer descriptor corruption =
and, then, apparently, only under=20
heavy traffic load.  We spent about six months evaluating this problem =
including contacting freescale,=20
but never found a solution.  We finally, decided to use an external =
ethernet chip on a daughter card=20
for our IP channel.

It is, however, our belief that our problem relates to a possible bug in =
the 8260 CPM, but have yet to
absolutely prove this.

If we are experiencing the same problem (and potentially others) and =
there is a solution we would be
very interested, as, we are not happy about the daughter card solution.  =



Myron L. Dixon
Sr. Software Engineer
L-3 Communications, GNS
1519 Grundy's Lane
Bristol, PA 19007
Phone:  215 957 3739
Fax:  215 957 3790
email:  Myron.Dixon@L-3Com.com

-----Original Message-----
From: linuxppc-dev-bounces+myron.dixon=3Dl-3com.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+myron.dixon=3Dl-3com.com@ozlabs.org] On =
Behalf Of Franca, Jose (NSN - PT/Portugal - MiniMD)
Sent: Wednesday, April 30, 2008 5:07 AM
To: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: FW: SKB corruption on heavy traffic

>From our latest debugs we found that the problem occurs mainly on skbuff =
code. After some variable time kfree or kalloc result in kernel oops.

-----Original Message-----
From: Franca, Jose (NSN - PT/Portugal - MiniMD)
Sent: quarta-feira, 30 de Abril de 2008 9:44
To: 'ext Scott Wood'
Cc: =09
Subject: RE: SKB corruption on heavy traffic

Hello!

	Thank you for replying!
	It't quite dificult to say if the problem exists without our changes, =
since the all software is dependent on this changes so to work with the =
hardware. I can't answer to that right now on that, but I forgot to add =
one thing: we have ring buffer full problems on our fcc_enet driver from =
time to time. So, I think the problem could be on linux configurations =
(related to hw) because there is a lot of posts on the web related to =
problems similar to this (none of them has really solved the bottom =
problem).=20

Regards,
Filipe=20

-----Original Message-----
From: ext Scott Wood [mailto:scottwood@freescale.com]
Sent: ter=E7a-feira, 29 de Abril de 2008 20:15
To: Franca, Jose (NSN - PT/Portugal - MiniMD)
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: SKB corruption on heavy traffic

On Tue, Apr 29, 2008 at 07:39:07PM +0100, Franca, Jose (NSN - =
PT/Portugal - MiniMD) wrote:
> 	We are developing a MPC8247 based telecom board (512MB), using linux=20
> 2.4 with some proprietary changes on IP stack and we are facing some=20
> problems when we have heavy traffic on our Ethernet interfaces...

Do you see these problems without the proprietary changes, and with a =
current kernel?

-Scott
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
