Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 5ADFBDE150
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 23:09:47 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so2486168wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 06:09:46 -0700 (PDT)
Message-ID: <fa686aa40708270609x453092eye6eaf83b65ac2dee@mail.gmail.com>
Date: Mon, 27 Aug 2007 07:09:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: schardt <g.schardt@fz-juelich.de>
Subject: Re: Newbie and linux on virtex-II ppc
In-Reply-To: <46D2C9A5.9030708@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46D2C9A5.9030708@fz-juelich.de>
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

On 8/27/07, schardt <g.schardt@fz-juelich.de> wrote:
> im a student from germany and i try to run linux on a virtex-II with
> integrated powerpc.
> i use the developer board DS-DB-2VP4/7-FG456 from Memec ( i think its
> now avnet)
>
> what is running :
>
>   - Xilinx EDK project (standalone program running fine, and BSP files
> are generated)
>     the project has only one UARTLITE, 82MB SDRAM and a few kByte
> blockram, and the systemace interface
>
>   - crosscompiler toolchain works
>
>   - after modified some defines in the xparameters.h i got a linux 2.4.
> kernel (linuxppc) without compiler errors

I strongly recommend trying to bring up a 2.6 kernel, it's much easier.

>     and yes, the uartlite driver is enabled :)

Don't modify xparams by hand; it's not worth the trouble.  Go into
software setting in your EDK project and select 'linux-2.6' as the OS.
 Generate the libraries and copy the generated xparameters_ml40x.h
into your kernel tree.

>
>
> but, when downloading the zImage.elf via XMD to the SDRAM and starting
> it with the run command nothing happens , or  i think that nothings
> happens because the serial port is quiet.

You can always use System.map in the kernel tree to find out where
__log_buf was linked to.  Look at that location with the debugger to
see if there is a crash message that didn't get printed out.

>
> is it possible to run a kernel that way ? or need i some kind of
> bootloader ?
> or is this complete the wrong way ?

Yes, I use this same method to bring up a kernel on Virtex boards
which don't have a bootloader.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
