Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060802223302.9667135360F@atlas.denx.de>
References: <20060802223302.9667135360F@atlas.denx.de>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:29:05 -0500
Message-Id: <1154618945.5094.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 00:33 +0200, Wolfgang Denk wrote:
> 
> In my understanding, an "uImage" file is a  image  consisting  of  an
> U-Boot  header (64 bytes) followed by an (compressed or uncompressed)
> Linux kernel image.

Yes

> 
> So what do you mean by "compressed uImage"? If you take  an  "uImage"
> file  according  to  above definition and compress it, it will not be
> recognized by U-Boot.

I mean that the data contained within the uImage is compressed. In this
case where the uImage data is compressed I choose to skip compressing
the kernel section in the zImage (because have it compressed twice was
wasteful)

> 
> And why do you need a second, "UNcompressed  kernel  image"  in  your
> setup?  I  must  be missing something, because including *two* kernel
> images makes no sense to me, and I don't  understand  why  you  would
> want to insist of an "UNcompressed" image...

So to clarify. The current method has a zImage with a compressed kernel
section where the actual kernel lives. The zImage uncompressed this code
to the kernel load address. The 'cuImage' would be packaged in a uImage
with the entire zImage compressed, except in this case the kernel
section would not be compressed (to avoid have a compressed image within
a compressed image)

-Matthew
