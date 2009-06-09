Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C67FEB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 19:26:25 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id C3450DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 19:26:24 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c2so1979085anc.39
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Jun 2009 02:26:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com>
References: <c384c5ea0906080759n24a66d21ob9076518cec41755@mail.gmail.com>
Date: Tue, 9 Jun 2009 11:26:22 +0200
Message-ID: <c384c5ea0906090226t59a2b593neb6c42f3c0d189f7@mail.gmail.com>
Subject: Re: 2.6.30-rc6: Problem with an SSD disk on Freescale PowerPC
	mpc8315e-rdb, works fine on x86
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Linux PPC <linuxppc-dev@ozlabs.org>, Kumar Gala <galak@kernel.crashing.org>,
	linux-ide@vger.kernel.org, Ashish Kalra <ashish.kalra@freescale.com>,
	Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding the sata_fsl.c developers to the recipients:

On Mon, Jun 8, 2009 at 4:59 PM, Leon
Woestenberg<leon.woestenberg@gmail.com> wrote:
> Hello,
>
> using 2.6.30-rc6, I get the following problems when I read from a SSD
> disk, connected to the
> 3.0 Gb SATA controller of the MPC8315E SoC rev 1.0 running Linux 2.6.30-r=
c6.
>
> Below see the output from two dd read runs.
>
> The disk behaves fine on a x86 box.
>
> What I can do to (help) pin-point the problem?
>
> Regards,
>
> Leon.
>
>
> root@mpc8315e-rdb:~# dd if=3D/dev/sda of=3D/dev/null bs=3D4k
> ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd c8/00:3e:1e:e0:01/00:00:00:00:00/e0 tag 0 dma 31744 in
> =A0 =A0 =A0 =A0 res 50/00:3e:e0:df:01/00:00:00:00:00/e0 Emask 0x1 (device=
 error)
> ata2.00: status: { DRDY }
> ata2: hard resetting link
> ata2: Signature Update detected @ 3528 msecs
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> sd 1:0:0:0: [sda] Result: hostbyte=3D0x00 driverbyte=3D0x08
> sd 1:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
> Descriptor sense data with sense descriptors (in hex):
> =A0 =A0 =A0 =A072 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
> =A0 =A0 =A0 =A000 01 df e0
> sd 1:0:0:0: [sda] ASC=3D0x0 ASCQ=3D0x0
> end_request: I/O error, dev sda, sector 122910
> __ratelimit: 52 callbacks suppressed
> Buffer I/O error on device sda, logical block 122910
> Buffer I/O error on device sda, logical block 122911
> Buffer I/O error on device sda, logical block 122912
> Buffer I/O error on device sda, logical block 122913
> Buffer I/O error on device sda, logical block 122914
> Buffer I/O error on device sda, logical block 122915
> Buffer I/O error on device sda, logical block 122916
> Buffer I/O error on device sda, logical block 122917
> Buffer I/O error on device sda, logical block 122918
> Buffer I/O error on device sda, logical block 122919
> ata2: EH complete
> dd: /dev/sda: Input/output error
>
>
> root@mpc8315e-rdb:~# dd if=3D/dev/sda of=3D/dev/null bs=3D4k
> ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: cmd c8/00:32:9a:6e:00/00:00:00:00:00/e0 tag 0 dma 25600 in
> =A0 =A0 =A0 =A0 res 50/00:3e:5c:6e:00/00:00:00:00:00/e0 Emask 0x1 (device=
 error)
> ata2.00: status: { DRDY }
> ata2: hard resetting link
> ata2: Signature Update detected @ 3528 msecs
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: configured for UDMA/133
> sd 1:0:0:0: [sda] Result: hostbyte=3D0x00 driverbyte=3D0x08
> sd 1:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
> Descriptor sense data with sense descriptors (in hex):
> =A0 =A0 =A0 =A072 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
> =A0 =A0 =A0 =A000 00 6e 5c
> sd 1:0:0:0: [sda] ASC=3D0x0 ASCQ=3D0x0
> end_request: I/O error, dev sda, sector 28314
> __ratelimit: 52 callbacks suppressed
> Buffer I/O error on device sda, logical block 28314
> Buffer I/O error on device sda, logical block 28315
> Buffer I/O error on device sda, logical block 28316
> Buffer I/O error on device sda, logical block 28317
> Buffer I/O error on device sda, logical block 28318
> Buffer I/O error on device sda, logical block 28319
> Buffer I/O error on device sda, logical block 28320
> Buffer I/O error on device sda, logical block 28321
> Buffer I/O error on device sda, logical block 28322
> Buffer I/O error on device sda, logical block 28323
> ata2: EH complete
> dd: /dev/sda: Input/output error
>
>
> root@mpc8315e-rdb:~# uname -a
> Linux mpc8315e-rdb 2.6.30-rc6 #1 Mon Jun 8 15:54:00 CEST 2009 ppc unknown
>
> root@mpc8315e-rdb:~# hdparm -i /dev/sda
>
> /dev/sda:
>
> =A0Model=3DSolidata X SSD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0, FwRev=3D0955 =A0 =A0, SerialNo=3D<...>
> =A0Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> =A0RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D0
> =A0BuffType=3Dunknown, BuffSize=3D0kB, MaxMultSect=3D128, MultSect=3D?1?
> =A0CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dno
> =A0IORDY=3Dno, tPIO=3D{min:240,w/IORDY:120}
> =A0PIO modes: =A0pio0 pio3 pio4
> =A0UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5
> =A0AdvancedPM=3Dyes: disabled (255) WriteCache=3Ddisabled
> =A0Drive conforms to: Unspecified: =A0ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6
> ATA/ATAPI-7
>
> =A0* signifies the current active mode
>
>
>
> --
> Leon
>



--=20
Leon
