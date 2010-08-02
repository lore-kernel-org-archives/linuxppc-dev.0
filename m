Return-Path: <cbouatmailru@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by ozlabs.org (Postfix) with ESMTP id CDF78B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 03:59:56 +1000 (EST)
Received: by bwz4 with SMTP id 4so2006390bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 02 Aug 2010 10:59:54 -0700 (PDT)
Date: Mon, 2 Aug 2010 21:59:52 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Atul Deshmukh <atulsdeshmukh@gmail.com>
Subject: Re: Issues to access Compact Flash Card on MPC8360E
Message-ID: <20100802175952.GA27967@oksana.dev.rtsoft.ru>
References: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
	<AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
	<20100802134857.GA8689@oksana.dev.rtsoft.ru>
	<AANLkTikRq95=4Pbhne9CikR-gEHOOp7tETdV0Lnr0Chh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikRq95=4Pbhne9CikR-gEHOOp7tETdV0Lnr0Chh@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 02, 2010 at 07:44:22PM +0530, Atul Deshmukh wrote:
> Thanks a lot Anton,
> From the dts entry given below,
> 
> localbus@e0005000 {
>          #address-cells = <2>;
>                #size-cells = <1>;
>                compatible = "fsl,mpc8349e-localbus",
>                             "fsl,pq2pro-localbus";
>                reg = <0xe0005000 0xd8>;
>                ranges = <0x3 0x0 0xf0000000 0x210>;
>                pata@3,0 {
>                        compatible = "fsl,mpc8349emitx-pata",
> "ata-generic";
>                        reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
>                        reg-shift = <1>;
>                        pio-mode = <6>;
>                        interrupts = <23 0x8>;
>                       interrupt-parent = <&ipic>;
>                };
>        };
> 
> 
> we can conclude that it uses ata-generic SATA/PATA controlelr driver which

How did you come to this conclusion? From the node above it's IMHO
pretty clear that IDE (PATA) is on the localbus.

The driver is drivers/ata/pata_of_platform.c.

> controls PCI-based IDE-controller where we can plug in our CF card...Am I
> right???

Nope, no PCI involved. CF is almost* directly connected to
the localbus.

> But in our design we don't use any controller we directly connects CF card
> to local bus where UPM controls it..

Yes, that's exactly how CF is done on MPC8349EmITX boards.

> Can you please explain how the interface is implemented in MPC8349..

Via localbus + UPM.

* 'almost' is because there are some buffers and inverters, see
  schematics:
  http://www.freescale.com/files/32bit/hardware_tools/schematics/MPC8349EMITXESCH.pdf

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
