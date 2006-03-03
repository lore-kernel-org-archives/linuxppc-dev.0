Return-Path: <mathieu.deschamps@com2gether.net>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by ozlabs.org (Postfix) with ESMTP id 85122679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 20:06:37 +1100 (EST)
From: Mathieu Deschamps <mathieu.deschamps@com2gether.net>
To: David Jander <david.jander@protonic.nl>
Subject: Re: How to quickly write cleanmarkers to jffs2 partitions?
Date: Fri, 3 Mar 2006 10:08:20 +0100
References: <200603021706.14618.david.jander@protonic.nl>
In-Reply-To: <200603021706.14618.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603031008.20075.mathieu.deschamps@com2gether.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 02 March 2006 17:06, David Jander wrote:
> Hi,
>
> I was wondering if there is a trick or common technique I am ignoring to
> make this more efficient:
>
> This is for a 2.4 kernel based system.
> In production we use either u-boot or a NFS mounted linux system to erase
> flash and write jffs2 partitions to it. The jffs2 images are small (not
> padded to full partition size to save programming time), but the partitions
> are rather big (12 Mbyte in one case). Problem is that when booting for the
> first time, one has to wait several minutes (during which the system is
> more or less useless and busy) to get all cleanmarkers written to flash by
> the jffs2 gc thread. This huge delay is rather unacceptable for production,
> so we are looking for a work-around.
>
> One option would be to make jffs2 images that are padded to full partition
> size, but that also isn't very efficient, considering the image is only
> about 100k in beginning and the partition is 12 Mbyte in size. That would
> take a lot of time programming flash (less time than having the jffs2
> driver fix this nevertheless).
>
> Another option is making a little program that writes cleanmarkers in every
> eraseblock starting from the first completely empty one in a partition
> before mounting that partition for the very first time after flashing.
>
> Since this seems to me like a common situation, I'd like to know if anybody
> knows about a better solution, or if anybody has already dealt with this
> before.
>
> Greetings,


Hi,

"When preparing a flash partition for JFFS2, it is recommended to put 
cleanmarkers to the erased blocks.
This might be done my means of "-j" option of the "flash_eraseall" MTD 
utility. Otherwise, JFFS2 will re-erase the blocks
which contain all 0xFF and have no cleanmarker. This is an unneeded wasting of 
time."

Source : http://www.linux-mtd.infradead.org/faq/jffs2.html

does this may be relevant ?



Best Regards,


Mathieu Deschamps.
