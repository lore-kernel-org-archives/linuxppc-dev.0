Return-Path: <domino@mikroswiat.pl>
Received: from jupiter.az.pl (jupiter.az.pl [62.146.68.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C196CDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Nov 2008 23:54:38 +1100 (EST)
Message-ID: <49241856.1090209@mikroswiat.pl>
Date: Wed, 19 Nov 2008 14:44:54 +0100
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
Subject: Re: Help: NOR flash MTD and JFFS2 rootfs
References: <D839955AA28B9A42A61B9181506E27C4013A03DC@SRVCHBER1212.ch.keymile.net>
In-Reply-To: <D839955AA28B9A42A61B9181506E27C4013A03DC@SRVCHBER1212.ch.keymile.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Varlese, Christopher wrote:
> I'm having some trouble booting from a JFFS2 disk partition.
> I have a few questions maybe someone can help.
>
>
> Q1: mtdparts=x not necessary?
> U-Boot supports configuring and passing mtdparts=x in the kernel
> command line.  But with powerpc the partitions can be defined in
> the device tree and the kernel can parse this to discover the MTD
> partitions.  So is it right then I don't need to use mtdparts?
> ref: drivers/mtd/ofpart.c:of_mtd_parse_partitions()
>   

If it is working, your choice.


> Q2: /proc/partitions empty?
> [...]

I can't explain.

>
> Q3: JFFS2 booting fails?
> I have a JFFS2 root fs disk image burned to a flash mtd partition.
> I can manually mount it with NFS/ram boot scenarios, but so far
> cannot boot directly from it as rootfs (infos below).   Any
> good suggestions what might be wrong?
>
> [...]
> ...
> Kernel command line: root=/dev/mtdblock5 rw rootfstype=jffs2
> ip=192.168.33.38:192.168.33.35:192.168.33.35::eter1:eth0:off panic=1
> con0
> [...]
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(2,0)

I'm using hexadecimal value for "root". I guess in your case try "root=1f05.

Domino
