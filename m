Message-ID: <3C63EC39.ACEECA08@ardistech.com>
Date: Fri, 08 Feb 2002 16:18:17 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: MPC823: i2c-algo-8xx read interrupt?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

When testing with i2c reading an eeprom on a MPC823e I get the message "IIC
read; complete but rbuf empty". IMHO this is because the interrupt in the TX
buffer is enabled intead of the the interrupt of the RX buffer. Is this a bug
or is there a reason behind this?

Best regards,
		Bart Thissen,	Ardis Technologies bv


i2c-algo-8xx.c: cpm_iic_read

Original (with TX interrupt and warning)

	tbdf->cbd_datlen = count + 1;
	tbdf->cbd_sc =
		BD_SC_READY | BD_SC_INTRPT | BD_SC_LAST |
		BD_SC_WRAP | BD_IIC_START;

	rbdf->cbd_datlen = 0;
	rbdf->cbd_bufaddr = __pa(buf);
	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP;



With RX interrupt (without warning):

	tbdf->cbd_datlen = count + 1;
	tbdf->cbd_sc =
		BD_SC_READY | BD_SC_LAST |
		BD_SC_WRAP | BD_IIC_START;

	rbdf->cbd_datlen = 0;
	rbdf->cbd_bufaddr = __pa(buf);
	rbdf->cbd_sc = BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
