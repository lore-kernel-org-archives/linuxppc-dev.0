Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 9D6FDB6F19
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 17:12:25 +1000 (EST)
Received: by iwn36 with SMTP id 36so1684093iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 00:12:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
References: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
	<AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
Date: Fri, 16 Jul 2010 00:12:21 -0700
Message-ID: <AANLkTinVSCwvz5KWbvp4UUcTsd-KZQm0pzfy-XXN_ie=@mail.gmail.com>
Subject: Re: cpm_uart_console_write() stuck in waiting for transmitter fifo
	ready
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>, Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Why would the TxBD be filled with all 0xF? Would it be possible that
>> the bdbase actually points somewhere else other than the TxBD?
>
> The virtual address 0xfddfa000 is mapped to 0xfa202000. I suspect that
> the TxBD of my MPC870 may not start at 0xfa202020.
>
> I notice that for adder875, ep88xc and mpc885ads, the muram data's reg
> = <0 0x1c00> but for mgsuvd, its reg = <0x800 0x1800>. How does the
> kernel use muram for 885 family SoCs? How much muram should be
> reserved for data?
>
> My RCCR=0x1, meaning the first 512B is for microcode. So the data and
> the TxBD should really be starting at 0xfa202200? Then my muram data's
> reg should be <0x200 ?>? What size shall I specify?

After the muram data's reg is changed to <0x200 0x1a00>, the cpm_uart
driver works properly and the kernel messages are printed on the
serial port.

-Shawn.
