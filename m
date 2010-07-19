Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140]) by ozlabs.org (Postfix) with ESMTP id 9A52BB6EF7
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 01:54:00 +1000 (EST)
Received: from mail76-db3 (localhost.localdomain [127.0.0.1])	by
	mail76-db3-R.bigfish.com (Postfix) with ESMTP id 69D4FDE00D6	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 15:38:46 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.248])	by
	mail76-db3.bigfish.com (Postfix) with ESMTP id 163271068051	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 15:36:29 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6JFaPi3014037	for
	<linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 08:36:25 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6JFnV9G020864	for <linuxppc-dev@ozlabs.org>;
	Mon, 19 Jul 2010 10:49:31 -0500 (CDT)
Date: Mon, 19 Jul 2010 10:36:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: cpm_uart_console_write() stuck in waiting for transmitter fifo
	ready
Message-ID: <20100719103622.54158697@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikyHvocHW6YzBPtxDrC9M5mih4ZpSoqo0mg6M1E@mail.gmail.com>
References: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
	<AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
	<AANLkTinVSCwvz5KWbvp4UUcTsd-KZQm0pzfy-XXN_ie=@mail.gmail.com>
	<20100716131333.0c99a627@schlenkerla.am.freescale.net>
	<AANLkTikyHvocHW6YzBPtxDrC9M5mih4ZpSoqo0mg6M1E@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jul 2010 17:30:01 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> > My RCCR=3D0x1, meaning the first 512B is for microcode. So the data =
and
> >> > the TxBD should really be starting at 0xfa202200? Then my muram data=
's
> >> > reg should be <0x200 ?>? What size shall I specify?
> >>
> >> After the muram data's reg is changed to <0x200 0x1a00>, the cpm_uart
> >> driver works properly and the kernel messages are printed on the
> >> serial port.
> >
> > The muram node is supposed to show the portions of DPRAM that are
> > usable by the OS. =A0If some portion has been taken up by microcode (or
> > anything else not under the OS's control) before the OS has started,
> > then it must be excluded from the muram node.
>=20
> It would be nicer that the initialization code could query the RCCR
> value and adjust the base address.

Is that the only thing that could possibly conflict with OS usage of
DPRAM?  It seemed simpler to just specify the usable chunks.

Before the kernel supported allocating CPM2 SMC parameter RAM, that was
another thing that firmware allocated that had to be kept out of the
muram node.

> It took me quite a while to understand the design.

Sorry...

This constraint is described in the MURAM section of
Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt, though.

-Scott
