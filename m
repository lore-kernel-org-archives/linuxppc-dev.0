Date: Thu, 6 Jul 2000 19:17:46 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org, aeb@veritas.com
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <qphfa3ie20.fsf@erbium.epact.se>
Message-ID: <Pine.HPX.4.10.10007061912350.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 6 Jul 2000, Michael Lundkvist wrote:

>
> Hi!
>
> I'm trying to go from 2.2.12 to 2.2.17pre10 on an MVME 2400.
>
> A few problems:
>
> The Motorola SROM bug-patch lacks one row in de4x5.c:
>
> --- de4x5.c~    Thu Jul  6 16:01:32 2000
> +++ de4x5.c     Thu Jul  6 16:14:18 2000
> @@ -4829,6 +4829,7 @@
>      } else if ((lp->media == INIT) && (lp->timeout < 0)) {
>          lp->ibn = 3;
>         lp->active = *p;
> +       if (MOTO_SROM_BUG) lp->active = 0;
>         lp->infoblock_csr6 = OMR_MII_100;
>         lp->useMII = TRUE;
>         lp->infoblock_media = ANS;
>
> This one was easy. Now for the hard one. :)
>
> I'm using a PMC-harddisk based on the CMD-646 chipset (Ramix 233).
>
> I installed my system under 2.2.12 with Debian.
>
> When I come to the partition check in 2.2.17pre10 it fails with
> "hda: unknown partition table"
>
> I added a printout in drivers/block/genhd.c in msdos_partition()
>
> --- genhd.c~    Thu Jul  6 16:01:31 2000
> +++ genhd.c     Thu Jul  6 16:48:02 2000
> @@ -522,7 +522,8 @@
>  #endif
>         if (*(unsigned short *)  (0x1fe + data) != cpu_to_le16(MSDOS_LABEL_MAGIC)) {
>                 brelse(bh);
> -               return 0;
> +               printk("Data: %x LABEL:%x\n",(*(unsigned short *)  (0x1fe + data)), cpu_to_le16(MSDOS_LABEL_MAGIC) );
> +               return 0;
>         }
>         p = (struct partition *) (0x1be + data);
>
>
> With this I get the following printout:
> hda:Data: aa55 LABEL:55aa
>
> So it seems like the byte order is wrong. Does anyone know why this
> happens?
>
> Please don't tell me my 2.2.12 partitioned disk is wrong. :)

What's your version of fdisk ?

Under 2.2.12 dd if=/dev/hda of=xxx bs=512 count=1 and see what comes out.
Can PPCBUG actually boot from these disks ?

>
> Where do I go for the best LinuxPPC 2.4 kernel for MVME-boards? Is it
> fsmlabs Bitkeeper repository?

I have 2.4.0-test2 running on an MVME2600, look at:

	ftp://vlab1.iram.es/pub/linux-2.4

did not try the MVME2400 yet (they are all in use for real tasks, I'm
waiting for more and have to develop on the 16Mb MVME2600 :-(). But I
only have SCSI disks or NFSRoot.

I have a 2.2.16 kernel compiled but never booted, I could give you R/O
access to my BK trees if you want (but the machine on which they are is
not up 100% of the time).

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
