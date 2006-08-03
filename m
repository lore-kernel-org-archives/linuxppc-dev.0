Return-Path: <linuxppcleo@gmail.com>
Message-ID: <a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
Date: Thu, 3 Aug 2006 23:56:52 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Matthew McClintock" <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
In-Reply-To: <1154618945.5094.6.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060802223302.9667135360F@atlas.denx.de>
	<1154618945.5094.6.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/3/06, Matthew McClintock <msm@freescale.com> wrote:
> On Thu, 2006-08-03 at 00:33 +0200, Wolfgang Denk wrote:
> >
> > In my understanding, an "uImage" file is a  image  consisting  of  an
> > U-Boot  header (64 bytes) followed by an (compressed or uncompressed)
> > Linux kernel image.
>
> Yes

If U-boot supports uncompressed kernel image in uImage, I think it
will be better to use this scheme:

u-boot header + wrapper + FDT + compressed kernel image

As kernel image will be uncompressed to its loading address directly.
While in your proposal, it needs to be moved one more time.

>
> >
> > So what do you mean by "compressed uImage"? If you take  an  "uImage"
> > file  according  to  above definition and compress it, it will not be
> > recognized by U-Boot.
>
> I mean that the data contained within the uImage is compressed. In this
> case where the uImage data is compressed I choose to skip compressing
> the kernel section in the zImage (because have it compressed twice was
> wasteful)
>
> >
> > And why do you need a second, "UNcompressed  kernel  image"  in  your
> > setup?  I  must  be missing something, because including *two* kernel
> > images makes no sense to me, and I don't  understand  why  you  would
> > want to insist of an "UNcompressed" image...
>
> So to clarify. The current method has a zImage with a compressed kernel
> section where the actual kernel lives. The zImage uncompressed this code
> to the kernel load address. The 'cuImage' would be packaged in a uImage
> with the entire zImage compressed, except in this case the kernel
> section would not be compressed (to avoid have a compressed image within
> a compressed image)
>
> -Matthew
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
