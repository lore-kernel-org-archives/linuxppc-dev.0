Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 0801367B32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Jul 2006 05:55:10 +1000 (EST)
Date: Fri, 21 Jul 2006 12:58:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benoit Lajoie-Dorval <BenoitL@adept.com>
Subject: Re: Boot problem on Sandpoint
Message-ID: <20060721195838.GB8150@mag.az.mvista.com>
References: <D3A60B685BD79544ACA481B73FA81EA02F4F27@COBALT>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D3A60B685BD79544ACA481B73FA81EA02F4F27@COBALT>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jul 21, 2006 at 11:49:14AM -0700, Benoit Lajoie-Dorval wrote:
> Hi all, 
> I have to port Linux on a Sandpoint Board wtih a MPC8241 processor on.

Tell your boss that it'll take 3 months including lots of overtime,
then crack open a beer!  The sandpoint/8241 has been working for years.

> built a kernel using linux 2.6.15 and create an zImage.initrd.elf with a
> ramdisk. All of this (linux and ramdisk) was packaged with ELDK 4.0. I also
> minimized everything in the .config file to only have what is really
> necessary (serial port, 6xx processor, etc). The communication is made with
> the board by its internal serial port and Dink32 is used to do everything
> else. 
> 
> The problem is that when I execute the loaded zImage.initrd.elf, the boot
> sequence just hangs there and I just don't see anything happening. There is
> nothing that is displayed. I know that the elf file as an offset header of
> 0X10000, so the problem is not there. I also put some breakpoints and trace
> using Dink32 to see where it stops and it may have something to do with the
> disable_6xx_mmu in the utils.S file.  
> 
> I just really don't know what's wrong in my config and I hope someone could
> help me on this.  

Well, you did lots of things that could have broken it.  Go back to
square one: default .config with nfs mounted rootfs.  Get that to work
then tune the .config and add a ramdisk.

Also, if you have a bdi2000 or some other jtag/cops debugger, you can
dump __log_buf and see if there is anything there.

Mark
