Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D40952C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 05:13:33 +1100 (EST)
Subject: Re: [PATCH] powerpc/qe_lib: Share the qe_lib for the others
 architecture
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20131015131606.GA2700@book.gsilab.sittig.org>
Date: Wed, 16 Oct 2013 13:12:59 -0500
Message-Id: <385E3F55-85BB-4E28-A396-FA54DEE1B1AB@kernel.crashing.org>
References: <1381750622-1150-1-git-send-email-X.Xie@freescale.com>
 <8559CF98-88E4-4271-A873-1409359EFE5C@kernel.crashing.org>
 <3F4D4A39-3063-45F5-8B0E-3CD5F36B4035@kernel.crashing.org>
 <20131014200952.GA20517@kroah.com>
 <20131015131606.GA2700@book.gsilab.sittig.org>
To: Gerhard Sittig <gsi@denx.de>
Cc: Scott Wood <scottwood@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 15, 2013, at 8:16 AM, Gerhard Sittig wrote:

> On Mon, Oct 14, 2013 at 13:09 -0700, Greg Kroah-Hartman wrote:
>>=20
>> On Mon, Oct 14, 2013 at 02:40:44PM -0500, Kumar Gala wrote:
>>>=20
>>> Greg,
>>>=20
>>> Wondering your thoughts on drivers/qe vs something like
>>> drivers/soc/fsl/qe.  The QuiccEngine (qe) is a communication core on
>>> some of the Freescale networking SoCs that provides the ability to =
do
>>> various networking/communication functionality.  "Channels" on the =
QE
>>> can be used for various different things from ethernet, ATM, UART, =
or
>>> other functions.
>>=20
>> What makes the code "QE" specific?  Are these devices that live on =
the
>> QE "bus", or are they controlling the QE controller?
>=20
> You may think of the QUICC as a "programmable bitbang machine" if
> you like.  The very same component runs arbitrary and rather
> different protocols depending on how you setup its parameters.
>=20
> There have been serial controllers capable of different protocols
> like UART or SPI or I2S, but all of them are "serial
> communication".  There have been memory controllers which could
> bitbang different protocols (NAND, NOR/SRAM, DRAM), but all of
> them are "memory".
>=20
> The QUICC is just a little more versatile, and appears to cover
> cases which reside in different Linux kernel subsystems (like:
> it's neither serial nor network exclusively, but can be either
> and potentially more).
>=20
> IIUC the question which Kumar Gala was asking is where to put
> code for the component which is neither a strict subset of any
> subsystem.  Please correct me if I'm wrong.

Thanks for the description.

Yeah, the actual ethernet, usb, serial drivers that exist with QE live =
today in proper drivers/ dirs.  This is the infrastructure that those =
drivers utilize that isn't quite related to an existing subsystem.  =
Mostly set up of channel state/cfg/etc.

- k=
