Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 06B13679F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 09:58:30 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id E5F0FA4025
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 01:58:27 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 25 May 2005 01:58:33 +0200
References: <200505242119.29197.niklaus.giger@member.fsf.org>
In-Reply-To: <200505242119.29197.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505250158.33459.roger.larsson@norran.net>
Subject: Re: Newbie question about accessing memory in kernel space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 24 May 2005 21.19, Niklaus Giger wrote:
> Hi
>
> I am working on a custom PPC405 board where I have a 2.6.10 kernel with
> RTAI patches (fusion) running.
>
> I am trying to access some custom CPLD chip hanging at 0x7D000000. In my
> intial board (hcu3_map_io) I added a corresponding io_block_mapping.
>
> I can see the CPLD when I access the address via my Abatron BDI debugger.
>
> In a user space test program I did a
>     map_base = mmap((void *)target, nSize, PROT_READ | PROT_WRITE,
> MAP_SHARED, fd, target);
> and was able to access the CPLD, too.

Via 'map_base' I guess?

For kernel try
virt_base=ioremap(target, nSize)

>
> In user and kernel space the procedure looks like this:
> void sys_set_tick_control_register_value(uint16 value)
> {
>     static uint16    *tickControlRegister       = (uint16*)
> 					HCU_TICK_CONTROL_REGISTER_ADDRESS;

This indicates that you tries to read directly from an adress (no virt_base?)
You might want to use __raw_readl instead (depending on bus endianess).

/RogerL
