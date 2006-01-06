Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 40385688DC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 23:04:06 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 6 Jan 2006 12:03:55 +0000
References: <OF4583615F.8ED595CE-ON852570ED.00736A17-852570ED.00736A1D@notes.udayton.edu>
In-Reply-To: <OF4583615F.8ED595CE-ON852570ED.00736A17-852570ED.00736A1D@notes.udayton.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601061203.55926.arnd@arndb.de>
Subject: Re: io.h question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 05 January 2006 21:00, mcnernbm@notes.udayton.edu wrote:
> I finally noticed out_8 and in_8 and what not are located in the
> ppc io.h file in the kernel development download.  But when I 
> tried to do a io.h with in my program I added #include <asm/io.h> 
> and it seems to find it with not problems but it can not find the
> functions with in that file.  Am i missing a define I need to set
> or something so I can see the right files with in io.h I am
> compiling for a ppc405 on a xilinx virtex 4 board.      

The definitions in that file are only usable from inside the kernel,
you can not use them in a user space application.

The correct way to solve your problem (which you did not explain, so
I can only guess) would be to write a kernel device driver for
the peripherial you want to drive, at least if it does not exist yet.

For prototyping, you can play with mmap() on /dev/mem in a user
application, but that is often not very reliable.

	Arnd <><
