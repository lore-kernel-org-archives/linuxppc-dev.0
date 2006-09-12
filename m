Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B2B167B53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 03:27:03 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k8CHQuxZ012348
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Sep 2006 19:26:56 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4506EDE0.2000706@246tNt.com>
Date: Tue, 12 Sep 2006 19:26:56 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: a.llano@usyscom.com
Subject: Re: MPC5200 fec frame corruption
References: <000d01c689f4$281750c0$4129320a@telxsi.com>
	<20060607120252.qjekdh5yzyrs4s0g@webmail.bluenox.com>
	<1158078812.5297.92.camel@usys-sw-server>
In-Reply-To: <1158078812.5297.92.camel@usys-sw-server>
Content-Type: text/plain; charset=windows-1252
Cc: a.arzuaga@usyscom.com, m.alvarez@ziv.es, t.arzuaga@usyscom.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Asier,
> We have been working with the MPC5200 fec and a linux-2.6.10 with some
> patches extracted from Sylvain's bitkeeper repository. We have 3
> different boards that worked properly with that kernel.
>
> We upgraded to the new MPC5200B and it still worked properly with the
> 2.6.10 kernel.
>
> We upgraded to the new code of the Sylvain's git repository and the FEC
> transmitted frames are corrupted. This corruption only happens with the
> current git repository and the MPC5200B.
>
>                 MPC5200   MPC5200B
> linux-2.6.10:     OK         OK
> Sylvain's git:    OK       CORRUPT
>   
I must admit I don't have bitkeeper anymore installed on my machine so I
don't
remeber exactly what in there.

Could you put somewhere on line the diff between 2.6.10 and you tree,
eventually minus all the irrelevant/confidential stuff ?
What would be needed woud be the arch/ppc/syslib/bestcomm ,
drivers/net/fec_mpc52xx
and the board setup code.
> The problem is that the lite5200 and the lite5200b work flawlessly, but
> our architecture is essentialy the same but with different PHYs (Marvell
> 88E6095F and 88E6060). Our architecture works properly with the
> linux-2.6.10, so we don't think that it is a hardware related problem.
> We have been watching the MII bus by osciloscope and the errors are
> clearly transmitted by the MPC5200B (no noise or distortion).
>
> We have inserted traces in the functions of the FEC driver with the
> buffer information that is sent to the DMA and the frames are correct.
>
>
> [... logs stripped ...]
> The corrupted bytes are sometimes correct, sometimes overwriten
> by the byte that is 0x20 bytes before, and sometimes changed
> by the bytes that is 0x40 bytes before. About 50% of the time
> the marked bytes are worong.
>
> I'd like to know if anything here makes any sense to you, so
> that I can understand the origin of the problem, or any
> additional test to perform.
>   
Any sense not really. But I would check first the options in the board
setup.
Things like cache snooping, comm bus prefetching, xlb priority settings and
pipelining, ...

Then the microcode of the task themselves and the options wich are used when
loading them.

Finally compare the driver code itself.


        Sylvain
