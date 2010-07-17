Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 2D82BB6F0C
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 10:30:02 +1000 (EST)
Received: by iwn36 with SMTP id 36so2459940iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 17:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100716131333.0c99a627@schlenkerla.am.freescale.net>
References: <AANLkTik9n_UkLKdmKT7PHiOL1-EW_TlMJFOGvWCU44xb@mail.gmail.com>
	<AANLkTin7nqaxDyXjkFhdJGEaazEL-oSMXnhkG0dblAUb@mail.gmail.com>
	<AANLkTinVSCwvz5KWbvp4UUcTsd-KZQm0pzfy-XXN_ie=@mail.gmail.com>
	<20100716131333.0c99a627@schlenkerla.am.freescale.net>
Date: Fri, 16 Jul 2010 17:30:01 -0700
Message-ID: <AANLkTikyHvocHW6YzBPtxDrC9M5mih4ZpSoqo0mg6M1E@mail.gmail.com>
Subject: Re: cpm_uart_console_write() stuck in waiting for transmitter fifo
	ready
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> > My RCCR=3D0x1, meaning the first 512B is for microcode. So the data an=
d
>> > the TxBD should really be starting at 0xfa202200? Then my muram data's
>> > reg should be <0x200 ?>? What size shall I specify?
>>
>> After the muram data's reg is changed to <0x200 0x1a00>, the cpm_uart
>> driver works properly and the kernel messages are printed on the
>> serial port.
>
> The muram node is supposed to show the portions of DPRAM that are
> usable by the OS. =A0If some portion has been taken up by microcode (or
> anything else not under the OS's control) before the OS has started,
> then it must be excluded from the muram node.

It would be nicer that the initialization code could query the RCCR
value and adjust the base address. It took me quite a while to
understand the design. Without your help it could take much much
longer. So thanks a lot for your help. My project hasn't been done
yet, so I may bother you again. :)

Thanks again,
-Shawn.
