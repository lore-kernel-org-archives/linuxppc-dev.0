Reply-To: <zjhzou@newrocktech.com>
From: "John Zhou" <zjhzou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel memory mapping problem
Date: Thu, 7 Feb 2002 12:24:42 +0800
Message-ID: <OOEJKGLHOBHLNAIEBLEFAEMGKJAA.zjhzou@newrocktech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <OOEJKGLHOBHLNAIEBLEFAEMFKJAA.zjhzou@newrocktech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Another strange problem:

in my driver moduler, I can directly access cpu's registers such as port A, B,C,D( my IMMR = 0xF0000000 ), but I can't directly read the SDRAM's value. for example:

int func()
{
	unsigned char tmp[10];
	unsigned char * p;
	unsigned long val;

	val = *( unsigned long * ) 0xF0010D0C; /* Port Open-Drain Registers (PODRA) */
	p = __pa(tmp);
	...
	pI2cRxBD -> bd_addr = p;
	...
	...
}

Thanks in advance!

John

-----Original Message-----
From: ZhongJun Zhou [mailto:zjhzou@newrocktech.com]
Sent: Thursday, February 07, 2002 11:21 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: kernel memory mapping problem


Dear all,

I have a problem that :

the function is :

int func()
{
	unsigned char tmp[10];
	unsigned char * p;

	p = __pa(tmp);
	...
	pI2cRxBD -> bd_addr = p;
	...
	...
}
when run this module( lsmod mymodule.o ), kernel is always dead. Are there any errors of this function ?

Any help is appreciated!

John Zhou

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
