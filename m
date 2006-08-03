Return-Path: <wd@denx.de>
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 11:24:06 CDT."
	<1154622246.5094.18.camel@localhost>
Date: Thu, 03 Aug 2006 22:14:41 +0200
Sender: wd@denx.de
Message-Id: <20060803201441.C8A89352660@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1154622246.5094.18.camel@localhost> you wrote:
>
> I'm not sure that is correct. Let me walk through the steps to verify.
> 
> 1) Load cuImage at a load address 
> 2) Extract zImage at an address and begin execution
> 3) Copy kernel to load address and fixup DTB, etc.
> 4) Start kernel execution
> 
> versus...
> 
> 1) Load cuImage at a load address
> 2) Copy zImage to an address and begin execution
> 3) Extract kernel to load address and fixup DTB, etc.
> 4) Start kernel execution

Both approaches seem broken to me.

You should make sure that  your  bootstrap  code  comes  *after*  the
kernel  image,  so  you  can  load  the  whole blob at address 0x0000
(mkimage option "-a 0") while starting  it  at  the  bootstrap  entry
point (mkimage option "-e <your_address>").

This way U-Boot will load (and if necessary  uncompress)  the  kernel
image plus your attached bootstrap code to it's normal start address.
Then  it starts your bootstrap code which can fixup DTB and then just
start the kernel.

Please avoid any aditional memory copy. It's not necessary.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"In Christianity neither morality nor religion come into contact with
reality at any point."                          - Friedrich Nietzsche
