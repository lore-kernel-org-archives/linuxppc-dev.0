Message-ID: <3C055B2E.9020801@humboldt.co.uk>
Date: Wed, 28 Nov 2001 21:46:22 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/
References: <15363.31192.101536.919771@gargle.gargle.HOWL>	<3C2B376F.9070508@embeddededge.com>	<15364.32906.728532.676746@gargle.gargle.HOWL>	<3C04A483.6070206@humboldt.co.uk> <15365.22636.100149.747039@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> Perfectly reasonable - I wish all the platforms used early_serial_setup.
> Would you mind posting your code that does the early_serial_setup calls?



Mangled by Mozilla below. This is a 7400 board with a memory mapped
uart. It is important to zero out the entries for serial ports that
aren't present, otherwise the serial driver will attempt to use the
traditional locations.



static void __init
tpe3_setup_arch(void)
{
	struct serial_struct req;

	...

	memset(&req, 0, sizeof (req));
	req.line = 0;
	req.io_type = SERIAL_IO_MEM;
	req.iomem_base = (void *) (tpe3_uart_base + 0x10);
	req.baud_base = 6144000 / 16;
	req.irq = 3;
	req.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
	early_serial_setup(&req);
	memset(&req, 0, sizeof (req));
	req.line = 1;
	early_serial_setup(&req);
	req.line = 2;
	early_serial_setup(&req);
	req.line = 3;
	early_serial_setup(&req);

	...
}


--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
