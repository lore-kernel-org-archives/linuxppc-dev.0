Return-Path: <scottwood@freescale.com>
Date: Tue, 22 Apr 2008 12:19:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?utf-8?B?5byg5LiW5LmQ?= <slzhang1980@gmail.com>
Subject: Re: Help! mpc8247 porting kernel 2.6.25 problem.
Message-ID: <20080422171912.GC17643@ld0162-tx32.am.freescale.net>
References: <8d59c9040804202006m607fe15bre29288240b73081d@mail.gmail.com>
	<20080421173450.GC4134@ld0162-tx32.am.freescale.net>
	<8d59c9040804212210y6abe755frba0d2c2ef0e12cd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8d59c9040804212210y6abe755frba0d2c2ef0e12cd4@mail.gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 01:10:54PM +0800, 张世乐 wrote:
> Thank you, Doctor Scott. I'm very grateful to you for you kindly help.
> 
> I'll try the way you suggested soon.
> 
> And, my code for light the led run as follows:
> 
> void set_led_a_red(void)
> {
> 	/*PDIRC: 0xfc010d40*/
> 	/*PPARC: 0xfc010d44*/
> 	/*PODRC: 0xfc010d4c*/
> 	/*PDATC: 0xfc010d50*/
> 	*((unsigned long *)(0xfb010d40)) |= 0x000000d4;
> 	*((unsigned long *)(0xfb010d44)) &= ~0x000000d4;
> 	*((unsigned long *)(0xfb010d4c)) &= ~0x000000d4;
> 	*((unsigned long *)(0xfb010d50)) |= 0x00000004;
> 	*((unsigned long *)(0xfb010d50)) &= ~0x00000010;
> }

Use out_be32(), and put a dcbf at the end.  If the dcbf doesn't help, try
not accessing any I/O until after the MMU is set up, and use a
cache-inhibited BAT mapping.  It's usually not between enabling caches
and enabling the MMU that something goes wrong, but it is a rather
annoying debug barrier.

As for early debug output not working, another possibility besides the
descriptor address is that ppc_md.probe is failing, or that your board
file doesn't set ppc_md.progress to udbg_progress.

-Scott
