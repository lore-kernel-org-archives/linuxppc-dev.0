Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 39F29687DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 23:57:43 +1100 (EST)
Message-ID: <1133531801.4390529995cfa@webmail.televes.com:443>
Date: Fri,  2 Dec 2005 14:56:41 +0100
From: Alex BASTOS <alebas@televes.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
References: <1133520697.4390273987a6a@webmail.televes.com:443>
	<4390223C.8060103@ru.mvista.com>
In-Reply-To: <4390223C.8060103@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,

> >
> There are 2 indirect_read_config(), one for PCI9 case, and one for not.
> I guess you should have CONFIG_8260_PCI9 disabled.
>
> If config seems OK, pleas submit backtrace. As long as I can see, "proper"
> setup_indirect_pci has been moved over to arch/powerpc/sysdev/indirect_pci.c.
> Check it it is compiled/used.
>

Config file seems OK to me:

# CONFIG_CPCI690 is not set
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_8260=y
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_NET_PCI is not set

and indirect_pci from arch/powerpc is compiled and used ...

I have tested a bit more. The call trace would be:

[c01db170] m8260_setup_arch
[c01db87c] pq2_find_bridges
[c01dbfa0] pciauto_bus_scan
[c000a754] early_read_config_byte
[c00c8f54] pci_bus_read_config_byte
[c0011424] indirect_read_config

I have done manually, since GDB only reports last two,
and I couldn't get it from log_buf.

(gdb) bt
#0  indirect_read_config (bus=0x0, devfn=3223241436,
                          offset=8, len=14, val=0x1032)
    at arch/powerpc/sysdev/indirect_pci.c:32

#1  0xc00c8fb4 in pci_bus_read_config_byte (bus=0xc01ec2dc,
                       devfn=8, pos=14, value=0xc01d1f3a "")
    at drivers/pci/access.c:52

Now I have check indirect_read_config, and I have seen
the call ends itself, but after that it returns to

   pci_bus_read_config_dword

executes some asm and then hangs.

Any idea?

Thanks,

Alex BASTOS
