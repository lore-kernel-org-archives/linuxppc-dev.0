Message-ID: <B25E2E5A003CD311B61E00902778AF2A02BBDAA7@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Jerry Van Baren'" <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Corrupted ramdisk image
Date: Thu, 3 Jan 2002 15:21:18 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the reply, Jerry.   The decompression phase was ok, the kernel
was decompressed to 0x0 (up to about 0x100000), and the ramdisk image
remained at 0x4b2000.

I just found the problem.  In fact the corruption was happening even earlier
- in the bootrom.  The bootrom replaces the pointer to the bootrom_cmdline.
If the image isn't loaded at its link address, there are problems.  The
image is not yet relocated to its link address, so the bootrom tweaks memory
in the wrong place.  Sure enough I found four bytes in my ramdisk that were
always corrupted in the same location...

Changing the mktree.c file to put the entry point at 0x400000 instead of
0x500000 fixes the problem for me.

Regards,
Brian


-----Original Message-----
From: Jerry Van Baren [mailto:vanbaren_gerald@si.com]
Sent: Thursday, January 03, 2002 2:56 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Corrupted ramdisk image



Since nobody with real knowledge of the problem has responded, I'll take a
WAG.

This looks like a variation on a PPCBoot FAQ...

If I'm reading your numbers correctly, your linux kernel is loading from
00400000 to 00A72890, but your initrd image is initially loaded at
00405200.  If you do the math :-), you will see that, during the
decompression/relocation of your kernel, you overwrite your initrd
image.  The boot code then tries to decompress/relocate your initrd and it
is no more.  Panic city.

You need to load your initrd where the decompressed/relocated kernel won't
overwrite it.

gvb


At 12:28 PM 1/3/2002 -0800, Brian Kuschak wrote:

>I'm upgrading from 2.4.3 to 2.4.17 (rsync from mvista) on a Walnut-variant
>board.  The initrd seems to be getting corrupted.  The kernel crashes
during
>the decompress or prints "crc error" or "invalid compressed format"
>messages.  I have allocated enough space by using the 'ramdisk=32000'
>command line option.  The same ramdisk works fine on a 2.4.3 kernel.
>
>I've used my BDI to dump the initrd image back onto my workstation, and
>gunzip also complains about the file format.  So it really is getting
>corrupted.  The beginning of the file looks ok in a hex editor.  Also the
>loader addresses look ok, no overlaps.  Any ideas?
>
>Thanks,
>Brian
>
>
>loaded at:     00500000 00B72890
>relocated to:  00400000 00A72890
>board data at: 00A6F7C0 00A6F800
>relocated to:  00A6F780 00A6F7C0
>zimage at:     00405200 004B16F2
>initrd at:     004B2000 00A6EF0C
>avail ram:     00A73000 04000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
