Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id EDD9B68155
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 04:19:36 +1000 (EST)
Message-ID: <4540FC2D.6000403@freescale.com>
Date: Thu, 26 Oct 2006 13:19:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: wei.li4@elf.mcgill.ca
Subject: Re: Kernel hangs in console_init()
References: <20061025173304.c57o9tf3go000wc0@webmail.mcgill.ca>
In-Reply-To: <20061025173304.c57o9tf3go000wc0@webmail.mcgill.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

wei.li4@elf.mcgill.ca wrote:
> Hi All,
> 
> I am working on linux 2.6.18-rc2 with my mpc875 demo board, I used 
> Debugger LEDs to find that kernel stopped in:
> 	while (call < __con_initcall_end) {
> 		(*call)();
> 		call++;
>         }
> which is in console_init() of tty_io.c, what kind of problem could be?
> What's the means of 'bctrl' instruction that I found in its assembler?

It's an indirect function call (i.e. the (*call)(); line) to the address 
specified in the CTR register.  You need to find out the value of *call 
in order to figure out which function is failing.  There are probably 
only a small number of possibilities that are actually configured into 
your kernel (look for console_initcall in files that get built for your 
target).

-Scott
