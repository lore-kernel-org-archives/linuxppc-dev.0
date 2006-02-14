Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 32ECD67B27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 03:50:55 +1100 (EST)
Date: Tue, 14 Feb 2006 19:42:34 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: Gianfar is slower than fcc_enet on MPC8541 ???
Message-ID: <20060214194234.792429fe@vitb.ru.mvista.com>
In-Reply-To: <449c76a00602140817k4cf1af22w6d6c930a9d847ba@mail.gmail.com>
References: <449c76a00602140728g3a9eb46sd70f23b894c4b96@mail.gmail.com>
	<000201c63181$cf2c3180$5201a8c0@GEG2400>
	<449c76a00602140817k4cf1af22w6d6c930a9d847ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laurent, 
btw, have you gived netperf test a try? 
It is a commonly-used tool to measure network performance, and has dozens of settings to test...

On Tue, 14 Feb 2006 11:17:46 -0500
Pantelis Antoniou <pantelis.antoniou@gmail.com> wrote:

> Can you provide some more information?
> 
> Actual timings, and a tcpdump fragment?
> 
> On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:
> >
> > Hi Pantelis,
> >
> > Thanks for the express reply.
> >
> > I know that what I say seems incredible. But I don't understand what NAPI
> > does.
> > My measure is very simple. I display a message on the client when 1000
> > exchanges are done.
> > I already check the ifconfig stats on the board after some seconds.
> > The measures seems the same with or without NAPI.
> >
> > More details ?
> > Thanks again
> > Laurent
> >
> >
> >
> > -----Message d'origine-----
> > *De :* Pantelis Antoniou [mailto:pantelis.antoniou@gmail.com]
> > *Envoyé :* mar. 14 février 2006 16:29
> > *À :* Laurent Lagrange
> > *Cc :* linuxppc-embedded@ozlabs.org
> > *Objet :* Re: Gianfar is slower than fcc_enet on MPC8541 ???
> >
> > Hi Laurent,
> >
> > I found that pretty hard to believe.
> >
> > What are you measuring exactly?
> >
> > Speed of replies? If so it's explainable since the TSECs use
> > NAPI.
> >
> > Regards
> >
> > Pantelis
> >
> > On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:
> > >
> > >
> > > Hello,
> > >
> > > I work on a cutom MPC8541 board with Linux 2.6.9.
> > > The kernel activates the L1 cache (instructions and data)
> > > and the L2 cache (entirely used as cache and not as sram).
> > >
> > > I configure
> > > 1 FCC (FCC1),
> > > 2 TSECs with or without NAPI (no effect) but without stashing in L2
> > > sram.
> > > All PHYs are automatically configured in 100MB full duplex.
> > >
> > >         eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e0
> > >         eth0: Running with NAPI disabled
> > >         eth0: 64/64 RX/TX BD ring size
> > >         eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1
> > >         eth1: Running with NAPI disabled
> > >         eth1: 64/64 RX/TX BD ring size
> > >         eth2: FCC ENET Version custom, 00:10:cd:48:48:e2
> > >
> > > Then I launch 3 simple TCP servers, one on each ports.
> > >
> > > From remote machines I runs 3 TCP clients.
> > > The client sends messages of 1000 bytes,
> > > The server receives and echoes the message
> > > The client receives the echoed message, check the content
> > > and sends a new message again.
> > >
> > > The result is that the 2 TSECs are 2 times slower than the FCC.
> > >
> > > If I run a "top" application on the board, I use less than 10% of the
> > > CPU
> > > Each port consumes about 1/3 of the CPU.
> > >
> > > Any idea on how to configure the gianfar driver ?
> > >
> > > Thanks
> > > Laurent
> > >
> > >
> > > _______________________________________________
> > > Linuxppc-embedded mailing list
> > > Linuxppc-embedded@ozlabs.org
> > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >
> >
> >


-- 
Sincerely, 
Vitaly
