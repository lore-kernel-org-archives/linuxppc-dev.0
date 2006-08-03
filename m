Return-Path: <wd@denx.de>
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 10:29:05 CDT."
	<1154618945.5094.6.camel@localhost>
Date: Thu, 03 Aug 2006 22:00:43 +0200
Sender: wd@denx.de
Message-Id: <20060803200043.0EF78352660@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1154618945.5094.6.camel@localhost> you wrote:
>
> > In my understanding, an "uImage" file is a  image  consisting  of  an
> > U-Boot  header (64 bytes) followed by an (compressed or uncompressed)
> > Linux kernel image.
> 
> Yes

OK.

> I mean that the data contained within the uImage is compressed. In this

This is only one option. Some configurations  prefer  to  use  uncom-
pressed images because these canbe booted faster.

> case where the uImage data is compressed I choose to skip compressing
> the kernel section in the zImage (because have it compressed twice was
> wasteful)

We don't use zImage !

> So to clarify. The current method has a zImage with a compressed kernel

No, it does not. We do  not  use  zImage  (which  includes  bootstrap
wrapper  code).  U-Boot  uses  a plain stripped and compressed kernel
image, i. e. something like this:

	objcopy  -O binary vmlinux vmlinux.bin
	gzip -f -9 <vmlinux.bin >vmlinux.gz
	mkimage ... -C gzip -d vmlinux.gz uImage

> section where the actual kernel lives. The zImage uncompressed this code
> to the kernel load address. The 'cuImage' would be packaged in a uImage
> with the entire zImage compressed, except in this case the kernel
> section would not be compressed (to avoid have a compressed image within
> a compressed image)

You would have to create a new image type which has  executable  code
at the start and carries the kernel image as payload, similar to what
zImage does. 

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The shortest unit of time in the multiverse is the News York  Second,
defined  as  the  period  of  time between the traffic lights turning
green and the cab behind you honking.
                                - Terry Pratchett, _Lords and Ladies_
