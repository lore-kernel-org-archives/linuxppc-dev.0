To: "aa aaa" <linux_powerpc@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to solve the problem!! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 23 May 2004 09:15:02 +0800."
             <BAY13-F27y1LuihVliK00020d6e@hotmail.com>
Date: Sun, 23 May 2004 15:11:24 +0200
Message-Id: <20040523131129.CEADCC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <BAY13-F27y1LuihVliK00020d6e@hotmail.com> you wrote:
>
> I have created jffs2 ,run flash_self:
> the message is flowing:ot>run flash_self
> Unknown command 'root=/dev/mtdblock3' - try 'help'

Well, there is a pretty clear message from U-Boot: it complains about
an "unknown command". Obviously  the  settings  in  your  envrionment
variables are broken.

...
> mice: PS/2 mouse device common for all mice

I think your kernel configuration is a bit strange,  too.  You  don;t
have a PS/2 mouse connected to your RPXlite biard, or do you?

...
> jffs_scan_flash(): Did not find even a single chunk of free space. This is
> BAD!
> jffs_scan_falsh():Free size accounting screwed
> jfffs_scan_flash():free_chunk_size1 == 0xe00000, free_chunk_size2 == 0x0,
> fmc->free_size == 0x0
> JFFS: Failed to mount device 1f:03.

Disable JFFS in your kernel config if you don't intend to use it.

> jffs2_scan_empty(): Empty block at 0x0000fffc ends at 0x00010000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0001fffc ends at 0x00020000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0002ffec ends at 0x00030000 (with
> 0x1985e001)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0004ff90 ends at 0x00050000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0005fffc ends at 0x00060000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0006fffc ends at 0x00070000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0008fffc ends at 0x00090000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0009fffc ends at 0x000a0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000afffc ends at 0x000b0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000cfffc ends at 0x000d0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000dfffc ends at 0x000e0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x000efffc ends at 0x000f0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0010fffc ends at 0x00110000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0011fffc ends at 0x00120000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0012fffc ends at 0x00130000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0014fffc ends at 0x00150000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x0019fffc ends at 0x001a0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001afffc ends at 0x001b0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001cfffc ends at 0x001d0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001dfffc ends at 0x001e0000 (with
> 0x1985e002)! Marking dirty
> jffs2_scan_empty(): Empty block at 0x001efffc ends at 0x001f0000 (with
> 0x1985e002)! Marking dirty

Seems you didn't initialize your root filesystem properly...

> VFS: Mounted root (jffs2 filesystem) readonly.
> Freeing unused kernel memory: 52k init
> Warning: unable to open an initial console.
>
> This is why?

Because you didn't install a proper root filesystem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Condense soup, not books!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
