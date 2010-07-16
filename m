Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 4F7F1B6F18
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 04:13:43 +1000 (EST)
Received: from mail96-va3 (localhost.localdomain [127.0.0.1])	by
	mail96-va3-R.bigfish.com (Postfix) with ESMTP id 821DEB98563	for
	<linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 18:13:39 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.243])	by
	mail96-va3.bigfish.com (Postfix) with ESMTP id 3F237196004F	for
	<linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 18:13:38 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6GIDZaI002028	for
	<linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 11:13:36 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6GIQamg005581	for <linuxppc-dev@ozlabs.org>;
	Fri, 16 Jul 2010 13:26:36 -0500 (CDT)
Date: Fri, 16 Jul 2010 13:13:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: cpm_uart_console_write() stuck in waiting for transmitter fifo
	ready
Message-ID: <20100716131333.0c99a627@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinVSCwvz5KWbvp4UUcTsd-KZQm0pzfy-XXN_ie=@mail.gmail.com>
References: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
	<AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
	<AANLkTinVSCwvz5KWbvp4UUcTsd-KZQm0pzfy-XXN_ie=@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Jul 2010 00:12:21 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> Why would the TxBD be filled with all 0xF? Would it be possible that
> >> the bdbase actually points somewhere else other than the TxBD?
> >
> > The virtual address 0xfddfa000 is mapped to 0xfa202000. I suspect that
> > the TxBD of my MPC870 may not start at 0xfa202020.
> >
> > I notice that for adder875, ep88xc and mpc885ads, the muram data's reg
> > = <0 0x1c00> but for mgsuvd, its reg = <0x800 0x1800>. How does the
> > kernel use muram for 885 family SoCs? How much muram should be
> > reserved for data?
> >
> > My RCCR=0x1, meaning the first 512B is for microcode. So the data and
> > the TxBD should really be starting at 0xfa202200? Then my muram data's
> > reg should be <0x200 ?>? What size shall I specify?
> 
> After the muram data's reg is changed to <0x200 0x1a00>, the cpm_uart
> driver works properly and the kernel messages are printed on the
> serial port.

The muram node is supposed to show the portions of DPRAM that are
usable by the OS.  If some portion has been taken up by microcode (or
anything else not under the OS's control) before the OS has started,
then it must be excluded from the muram node.

-Scott
