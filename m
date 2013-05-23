Return-Path: <B21989@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26C502C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 16:03:45 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Subject: RE: SATA hang on 8315E triggered by heavy flash write?
Date: Thu, 23 May 2013 06:04:15 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C90B1E0FFA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1369172643.1374.15@scott-Lenovo-G560>
 <gppwj3ayu.fsf@dworkin.scrye.com>
 <ED492CCEAF882048BC2237DE806547C90B1DFA93@039-SN2MPN1-013.039d.mgd.msft.net>
 <g8v362qg8.fsf@dworkin.scrye.com>
In-Reply-To: <g8v362qg8.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Anthony Foiani,

Thanks for the confirmation.=20

So it seems the NOR write break the signal Integrity of SATA.
I don't have schematic and board right now, could you please measure signal=
s related to NOR write to see if anything abnormal? Is the board use FPGA o=
r CPLD to control signal?

If stop NOR write, could the SATA recover and work?

Best Regards,=20
Shaohui Xie


> -----Original Message-----
> From: Anthony Foiani [mailto:tkil@scrye.com]
> Sent: Thursday, May 23, 2013 1:52 PM
> To: Xie Shaohui-B21989
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org
> Subject: Re: SATA hang on 8315E triggered by heavy flash write?
>=20
>=20
> Shaohui --
>=20
> Thanks for the quick reply!  Please find my investigation and results
> below.
>=20
> Xie Shaohui-B21989 <B21989@freescale.com> writes:
>=20
> > 1. only update NOR for a long enough time, for ex. tens of seconds,
> >    see if error happens;
>=20
> It seems that I can do this without any errors:
>=20
>   / # flash_erase /dev/mtd1 0 0
>   Erasing 64 Kibyte @ 7f0000 -- 100 % complete
>   / # dd if=3D/dev/zero of=3D/dev/mtd1
>   dd: writing '/dev/mtd1': No space left on device
>   16385+0 records in
>   16384+0 records out
>   8388608 bytes (8.0MB) copied, 62.399439 seconds, 131.3KB/s
>=20
> > 2. only r/w SSD without NOR operation, see if error happens;
>=20
> Again, no problem:
>=20
>   /ssd # ls -al biggie.bin
>   -rw-r--r--    1 root     root     2330607084 May 22 19:34 biggie.bin
>   /ssd # ls -alh biggie.bin
>   -rw-r--r--    1 root     root        2.2G May 22 19:34 biggie.bin
>   /ssd # time cp biggie.bin biggie2.bin
>   real    3m 27.55s
>   user    0m 2.60s
>   sys     2m 16.13s
>=20
> > 3. r/w SSD first and keep it run, then start to read NOR, if no
> >    error for a long time, then start to write NOR, see how long the
> >    error will happen.
>=20
> Doing a NOR read during heavy SATA r/w seems to succeed, with no errors
> on the console:
>=20
>   [window 1]
>   /ssd # time cp biggie.bin biggie2.bin
>=20
>   [window 2]
>   / # dd if=3D/dev/mtd1 of=3D/dev/null
>   16384+0 records in
>   16384+0 records out
>   8388608 bytes (8.0MB) copied, 6.380613 seconds, 1.3MB/s
>=20
> Doing a NOR write fails almost instantly (within a second):
>=20
>   [window 1]
>   /ssd # time cp biggie.bin biggie2.bin
>=20
>   [window 2]
>   / # dd if=3D/dev/zero of=3D/dev/mtd1
>=20
>   [console]
>   [ 5160.269106] ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x0 action
> 0x6 frozen
>   [ 5160.276387] ata2.00: failed command: READ DMA
>   [ 5160.280905] ata2.00: cmd c8/00:00:60:f3:01/00:00:00:00:00/e0 tag 0
> dma 131072 in
>   [ 5160.280928]          res 50/00:00:f0:c0:48/00:00:00:00:00/e0 Emask
> 0x10 (ATA bus error)
>   [ 5160.296386] ata2.00: status: { DRDY }
>   [ 5160.300195] ata2: hard resetting link
>   [ 5160.347858] ata2: setting speed (in hard reset)
>   [ 5170.439981] ata2: No Signature Update
>   [ 5170.611901] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>   [ 5170.618204] ata2.00: link online but device misclassified
>   [ 5175.623918] ata2.00: qc timeout (cmd 0xec)
>   [ 5175.628147] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
>   [ 5175.634347] ata2.00: revalidation failed (errno=3D-5)
>   [ 5175.639373] ata2: hard resetting link
>   [ 5176.143847] ata2: Hardreset failed, not off-lined 0
>   [ 5176.155867] ata2: setting speed (in hard reset)
>   [ 5185.743871] ata2: No Signature Update
>   [ 5185.915900] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>   [ 5185.922203] ata2.00: link online but device misclassified
>   [ 5195.927910] ata2.00: qc timeout (cmd 0xec)
>   [ 5195.932140] ata2.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
>   [ 5195.938342] ata2.00: revalidation failed (errno=3D-5)
>   [ 5195.943430] ata2: hard resetting link
>   [ 5196.443885] ata2: Hardreset failed, not off-lined 0
>   ...
>=20
> At this point, a hard reset / full power cycle is needed to recover.
>=20
> The board is an MPC8315ERDB derivative, and I'm running a patched
> 3.4.36 kernel.
>=20
> I've uploaded some (possibly) relevant files to:
>=20
>   http://foiani.home.dyndns.org/~tony/linux/ppc-sata-issues-201305/
>=20
> There is a diff from 3.4.36, a devtree, and a kernel config.
>=20
> Please let me know if there is any more information that I can contribute=
.
>=20
> Best regards,
> Anthony Foiani
