Message-Id: <5.1.0.14.2.20020103174803.020d01d8@falcon.si.com>
Date: Thu, 03 Jan 2002 17:55:55 -0500
To: <linuxppc-embedded@lists.linuxppc.org>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Corrupted ramdisk image
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02BBDAA6@SERVER1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Since nobody with real knowledge of the problem has responded, I'll take a WAG.

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
>board.  The initrd seems to be getting corrupted.  The kernel crashes during
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
