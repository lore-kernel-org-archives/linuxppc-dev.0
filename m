Return-Path: <scottwood@freescale.com>
Date: Mon, 21 Apr 2008 12:34:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?utf-8?B?5byg5LiW5LmQ?= <slzhang1980@gmail.com>
Subject: Re: Help! mpc8247 porting kernel 2.6.25 problem.
Message-ID: <20080421173450.GC4134@ld0162-tx32.am.freescale.net>
References: <8d59c9040804202006m607fe15bre29288240b73081d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <8d59c9040804202006m607fe15bre29288240b73081d@mail.gmail.com>
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

On Mon, Apr 21, 2008 at 11:06:28AM +0800, 张世乐 wrote:
> Uncompressing Kernel Image ... OK
> Booting using the fdt at 0x600000
> 
> [nothing output and hanging here]
> 
> I use the led on the board to trace the kernel fund it stop in the function
> 
> setup_common_caches  in arch/powerpc/kernel/cpu_setup_6xx.S
> 
> Can you give me some ideas?

That's probably not where it's actually stopping, but rather where caches
are enabled without the MMU, thus making it difficult to access devices. 
You can try placing a dcbf after each write to the LED register, though
this may perturb nearby registers.

Have you tried enabling early debug printk?

-Scott
