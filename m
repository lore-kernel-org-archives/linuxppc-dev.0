Date: Mon, 28 Aug 2000 18:42:46 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Richard Seitz <Richard.Seitz@m.dasa.de>
cc: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@linuxcare.com.au>
Subject: Re: the story so far, long ago now good news
In-Reply-To: <39AA6DC0.2CF2C061@m.dasa.de>
Message-ID: <Pine.HPX.4.10.10008281828260.6537-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[cc'ed to linuxppc-dev and Paul-Mackerras to include in official kernel]

> Hello Gabriel,
>
> cat /proc/partitions output looks very good. exactly what we
> have put in.
>

	Hi Richard,

Although this patch probably will not solve your crashes, I have just hit
the same problem as you when running fdisk on a drive transferred from a
PC. Endian conversions were missing when reading the partition table which
confused the get geometry ioctl (the kernel debugging messages gave the
impression that I had about 2 terabytes on this disk, probably using a
novel and patented compression meathod to fit it into 1Gb).

At least fdisk should now work properly.

Here is the patch:

===== drivers/scsi/scsicam.c 1.1 vs edited =====
--- 1.1/drivers/scsi/scsicam.c	Mon Jun  5 15:35:51 2000
+++ edited/drivers/scsi/scsicam.c	Mon Aug 28 18:27:59 2000
@@ -105,7 +105,7 @@
 	unsigned int logical_end, physical_end, ext_physical_end;


-	if (*(unsigned short *) (bh->b_data + 510) == 0xAA55) {
+	if (*(unsigned short *) (bh->b_data + 510) == cpu_to_le16(0xAA55)) {
 		for (largest_cyl = -1, p = (struct partition *)
 		     (0x1BE + bh->b_data), i = 0; i < 4; ++i, ++p) {
 			if (!p->sys_ind)
@@ -138,8 +138,8 @@
 		    end_head * end_sector + end_sector;

 		/* This is the actual _sector_ number at the end */
-		logical_end = get_unaligned(&largest->start_sect)
-		    + get_unaligned(&largest->nr_sects);
+		logical_end = le32_to_cpu(get_unaligned(&largest->start_sect))
+		    + le32_to_cpu(get_unaligned(&largest->nr_sects));

 		/* This is for >1023 cylinders */
 		ext_cyl = (logical_end - (end_head * end_sector + end_sector))


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
