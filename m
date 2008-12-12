Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83505.mail.sp1.yahoo.com (web83505.mail.sp1.yahoo.com
	[216.252.120.161]) by ozlabs.org (Postfix) with SMTP id 76FDFDDF82
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 11:29:00 +1100 (EST)
Date: Thu, 11 Dec 2008 16:28:58 -0800 (PST)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Problem building kernel
To: Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <454690.60670.qm@web83505.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you.  That took care of it.  I knew it was something small.

Ron



----- Original Message ----
> From: Kumar Gala <galak@kernel.crashing.org>
> To: Ron Madrid <ron_madrid@sbcglobal.net>
> Cc: linuxppc-dev@ozlabs.org
> Sent: Thursday, December 11, 2008 4:21:26 PM
> Subject: Re: Problem building kernel
> 
> 
> On Dec 11, 2008, at 5:48 PM, Ron Madrid wrote:
> 
> > Hello all,
> >
> > I got the latest kernel from git://git.denx.de/linux-2.6-denx.git  
> > and after
> > configuring with menuconfig I am seeing these errors.  I feel like  
> > this
> > could be something simple that I am just unaware of, but I'm not sure
> > and haven't been able to find anything useful when doing a web search.
> >
> > Any ideas?  What other information would be helpful?
> >
> >  BOOTCC  arch/powerpc/boot/redboot-83xx.o
> >  BOOTCC  arch/powerpc/boot/cuboot-sam440ep.o
> >  BOOTCC  arch/powerpc/boot/cuboot-acadia.o
> > {standard input}: Assembler messages:
> > {standard input}:278: Error: Unrecognized opcode: `mtdcr'
> > {standard input}:282: Error: Unrecognized opcode: `mfdcr'
> > {standard input}:289: Error: Unrecognized opcode: `mtdcr'
> > {standard input}:293: Error: Unrecognized opcode: `mfdcr'
> > {standard input}:312: Error: Unrecognized opcode: `mtdcr'
> > {standard input}:316: Error: Unrecognized opcode: `mfdcr'
> > make[2]: *** [arch/powerpc/boot/cuboot-acadia.o] Error 1
> > make[1]: *** [zImage] Error 2
> > make: *** [sub-make] Error 2
> >
> > Ron
> 
> Try the following patch:
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 8fc6d72..483f78d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -39,6 +39,7 @@ DTS_FLAGS     ?= -p 1024
> 
>   $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
>   $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
> +$(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
>   $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
>   $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
>   $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
