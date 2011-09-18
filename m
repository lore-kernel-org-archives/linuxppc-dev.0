Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 34B82B6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Sep 2011 06:06:43 +1000 (EST)
Received: by iabn5 with SMTP id n5so5288749iab.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 18 Sep 2011 13:06:40 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4E7644C9.4070802@ameritech.net>
References: <4E7644C9.4070802@ameritech.net>
Date: Sun, 18 Sep 2011 22:06:40 +0200
Message-ID: <CAMuHMdU=RRynbFsRgXwZvmm4_ZSxv=E3bgDFd92CnRgLv6XgFA@mail.gmail.com>
Subject: Re: mount file system using offset.
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "F. Heitkamp" <heitkamp@ameritech.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 18, 2011 at 21:21, F. Heitkamp <heitkamp@ameritech.net> wrote:
> First of all please accept my apologies for posting to this list on this
> particular topic, but it was the closest match I could find.
>
> I pulled the harddisk out of my ps3, because I have forgotten the root
> password on the linux partition.
>
> After spending some time googling I see that the harddisk is encrypted an=
d
> there are no linux utilities that can read/write it.
>
> However I did find that the "testdisk" program finds the linux partitions=
 on
> the disk (see below.).
>
> It seems I should be able to mount the partitions on my linux pc box some=
how
> since I now know their location on the disk.
>
> Does anyone know how one might go about that?

Now you know the offset of the Linux "partition" on the disk (i.e. the
part of the
disk that was visible to Linux), you can use dm-linear to map this part ont=
o a
new block device.
After that you can use kpartx to create block devices representing the
individual
partitions on the above new block device.

> TestDisk 6.12, Data Recovery Utility, May 2011
> Christophe GRENIER <grenier@cgsecurity.org>
> http://www.cgsecurity.org
>
> Disk /dev/sdc - 80 GB / 74 GiB - CHS 9729 255 63
>
> The harddisk (80 GB / 74 GiB) seems too small! (< 13 TB / 11 TiB)
> Check the harddisk size: HD jumpers settings, BIOS detection...
>
> The following partition can't be recovered:
> =C2=A0 =C2=A0 Partition =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Start =C2=A0 =C2=A0 =C2=A0 =C2=A0End =C2=A0 =C2=A0Size in sectors
>> =C2=A0Linux SWAP 2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09675 127 42 1593896=
 192 =C2=A05 25450514424
>
>
> TestDisk 6.12, Data Recovery Utility, May 2011
> Christophe GRENIER <grenier@cgsecurity.org>
> http://www.cgsecurity.org
>
> Disk /dev/sdc - 80 GB / 74 GiB - CHS 9729 255 63
> =C2=A0 =C2=A0 Partition =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Start =C2=A0 =C2=A0 =C2=A0 =C2=A0End =C2=A0 =C2=A0Size in sectors
>>P ext3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01566=
 128 42 =C2=A01579 127 35 =C2=A0 =C2=A0 208776 [/boot]
> =C2=A0P ext3 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A01579 127 42 =C2=A09675 127 41 =C2=A0130062240 [/]

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
