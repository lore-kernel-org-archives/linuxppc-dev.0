Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'linuxppc-embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: question on PPC performance
Date: Fri, 30 Jan 2004 18:22:24 +0800
Message-ID: <000001c3e71a$f4d68010$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <001b01c3e70d$3654e3f0$0100a8c0@pc002>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I have an question on PPC performance:

I have linux running based on mpc8250 with 200/166/66 clock configuration. But, I found that every CPU instruction used about 5 ns when accessing SDRAM, otherwise, every CPU instruction used about 15 ns when accessing other devices such as port A/B/C/D, immr, etc, except accessing SDRAM.

Thanks any help!

John
=================================================
The function I used is:
void performance_test(void)
{
					unsigned long i, d1, d2;
					static unsigned long kkk;
					unsigned short time;
					volatile unsigned long* portC = ( volatile unsigned long*)0xF0010D50;

					volatile unsigned long * tmp = &kkk;
					*(volatile unsigned char*)0xF0010D80 &= ~0xB0;
					*(volatile unsigned short*)0xF0010D92 = 0x0002;
					*(volatile unsigned char*)0xF0010D80 |= 0x10;

 					*(volatile unsigned long*)0xF0010D44 &= ~0x00000002;
					d1 = *(volatile unsigned long*)0xF0010D50;
					d1 &= ~0x00000003;
					d2 = d1 | 0x00000002;
					d1 |= 0x00000001;

					*(volatile unsigned short*)0xF0010D9E = 0;
					for (i=0; i<1000; i++)
					{

						*portC = d1;
						*portC = d2;
					}
					time = *(volatile unsigned short*)0xF0010D9E;
					printk ("#test2: 2 access loop 1000 times use %dns\r\n", time*15);

					*(volatile unsigned short*)0xF0010D9E = 0;
					for (i=0; i<1000; i++)
					{

						*tmp = d1;
						*tmp = d2;
					}
					time = *(volatile unsigned short*)0xF0010D9E;
					printk ("#test3: 2 access loop 1000 times use %dns\r\n", time*15);
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
