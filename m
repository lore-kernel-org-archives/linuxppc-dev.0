Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'linuxppc-embedded'" <linuxppc-embedded@lists.linuxppc.org>
Cc: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>
Subject: RE: question on PPC performance
Date: Mon, 2 Feb 2004 13:17:46 +0800
Message-ID: <000301c3e94b$e52d5c00$b702a8c0@newrock2>
MIME-Version: 1.0
In-Reply-To: <8039970AF146314597457D3B51A68B382E048F@cossmgmbx02.email.corp.tld>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now, I have another question to be answered.

In Linux Kernel 2.4.x, where to configure cacheable or uncacheable area of
SDRAM? ( I used Kernel 2.4.1 )

Thanks any help!
John

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
VanBaren, Gerald (AGRE)
Sent: Friday, January 30, 2004 9:33 PM
To: linuxppc-embedded
Subject: RE: question on PPC performance



...because you are NOT accessing SDRAM when you are accessing SDRAM.  You
are accessing the processor's internal cache, which is running at 200MHz.
In fact, you probably are not even accessing internal cache -- IIRC, the
82xx has a write posting queue so, when you do a write, it gets queued but
does not wait for the write to complete.  When you do a read of the same
location, the bus interface goes gets the value out of the write queue, so
you are only reading and writing a hidden internal register in the 82xx,
not SDRAM and probably not even the internal cache.

Turn off the data cache and run your test again, you will be astounded at
how slow it is.

When you are accessing a port, you need a bus transaction.  As your
benchmark showed, it takes more time to access a built-in port via the
82xx internal bus.  Since your bus is clocked at 66MHz and you are
measuring 15nS, it appears that accessing the built-in 82xx ports is
running at the bus speed.

Your benchmark is very, very simplistic and you are getting
correspondingly simplistic measurements.  I don't see any calculation or
compensation in your benchmark for the overhead of the loop.  As pointed
out above, it is not measuring what you think it is measuring.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of John
> Zhou
> Sent: Friday, January 30, 2004 6:32 AM
> To: 'linuxppc-embedded'
> Subject: RE: question on PPC performance
>
>
>
> my questions is:
>
> why is it 15 ns when accessing other devices such as port
> A/B/C/D, immr, etc, except accessing SDRAM, but about 5 ns
> when accessing SDRAM?
>
> Thanks in advance!
> John
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of John
> Zhou
> Sent: Friday, January 30, 2004 6:22 PM
> To: 'linuxppc-embedded'
> Subject: question on PPC performance
>
>
>
> Dear all,
>
> I have an question on PPC performance:
>
> I have linux running based on mpc8250 with 200/166/66 clock
> configuration. But, I found that every CPU instruction used
> about 5 ns when accessing SDRAM, otherwise, every CPU
> instruction used about 15 ns when accessing other devices
> such as port A/B/C/D, immr, etc, except accessing SDRAM.
>
> Thanks any help!
>
> John
> =================================================
> The function I used is:
> void performance_test(void)
> {
> 					unsigned long i, d1, d2;
> 					static unsigned long kkk;
> 					unsigned short time;
> 					volatile unsigned long*
> portC = ( volatile unsigned long*)0xF0010D50;
>
> 					volatile unsigned long
> * tmp = &kkk;
> 					*(volatile unsigned
> char*)0xF0010D80 &= ~0xB0;
> 					*(volatile unsigned
> short*)0xF0010D92 = 0x0002;
> 					*(volatile unsigned
> char*)0xF0010D80 |= 0x10;
>
>  					*(volatile unsigned
> long*)0xF0010D44 &= ~0x00000002;
> 					d1 = *(volatile
> unsigned long*)0xF0010D50;
> 					d1 &= ~0x00000003;
> 					d2 = d1 | 0x00000002;
> 					d1 |= 0x00000001;
>
> 					*(volatile unsigned
> short*)0xF0010D9E = 0;
> 					for (i=0; i<1000; i++)
> 					{
>
> 						*portC = d1;
> 						*portC = d2;
> 					}
> 					time = *(volatile
> unsigned short*)0xF0010D9E;
> 					printk ("#test2: 2
> access loop 1000 times use %dns\r\n", time*15);
>
> 					*(volatile unsigned
> short*)0xF0010D9E = 0;
> 					for (i=0; i<1000; i++)
> 					{
>
> 						*tmp = d1;
> 						*tmp = d2;
> 					}
> 					time = *(volatile
> unsigned short*)0xF0010D9E;
> 					printk ("#test3: 2
> access loop 1000 times use %dns\r\n", time*15);
> }
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
