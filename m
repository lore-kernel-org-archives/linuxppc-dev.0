Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id 01138DDF1D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Mar 2008 12:09:31 +1100 (EST)
Date: Fri, 07 Mar 2008 17:09:08 -0800
Subject: Re: Performance in Booting Linux w/ Device Tree via U-Boot out of
	JFFS2 on NAND
From: Grant Erickson <gerickson@nuovations.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Message-ID: <C3F72734.DD8E%gerickson@nuovations.com>
In-Reply-To: <C3F56A1C.DD2F%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: "u-boot-users@lists.sourceforge.net" <u-boot-users@lists.sourceforge.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/6/08 9:30 AM, Grant Erickson wrote:
> I am continuing some experiments in booting Linux w/ a flattened device tree
> via u-boot (1.3.2-rc3) from JFFS2 on NAND on an AMCC "Haleakala" board and am
> curious if anyone has come up with some quantitative performance
> characterizations of the various options (in all cases, u-boot lives on NOR
> flash). The options I am evaluating are:
> 
> 1) Put uImage and haleakala.dtb in their own "raw" NAND slices and boot with
>    u-boot nand commands:
> 
> [ ... details omitted ... ]
> 
> Qualitative performance: Nearly instantaneous.
> 
> As expected, in this case the qualitative, subjective time to seeing "Linux
> version 2.6.25-rc3-00951-g6514352-dirty ..." is nearly instantaneous.
> 
> 2) Put uImage and haleakala.dtb as files in /boot in the ~12 MB JFFS2 root
>    file system image in the ~60 MB "root" NAND slice and boot with u-boot
>    fsload commands:
> 
> [ ... details omitted ... ]
> 
> 2a) With CFG_JFFS2_SORT_FRAGMENTS enabled.
> 
> Qualitative performance: Takes the better part of 30-35 minutes.
> 
> As expected with the in-documentation warnings about CFG_JFFS2_SORT_FRAGMENTS
> and looking at the code in u-boot/fs/jffs2/jffs2_nand_1pass.c, the
> qualitative, subjective time to seeing the Linux version banner is slow, slow
> and slow.
> 
> 2b) With CFG_JFFS2_SORT_FRAGMENTS disabled.
> 
> Qualitative performance: Takes about 30 seconds to two minutes.
> 
> 3) This is a hybrid approach that I am setting up right now and is where I am
> curious if anyone has done plots of fsload time on JFFS2 + NAND relative to
> file system size.
> 
> Here, we use a separate 4 MB "/boot" JFFS2 file system for uImage and
> haleakala.dtb files and a 60 MB "/" JFFS2 file system for the root file
> system.
> 
> [ ... details omitted ... ]
> 
> 3a) With CFG_JFFS2_SORT_FRAGMENTS enabled.
> 
> Shouldn't be necessary since the /boot file system would only ever be accessed
> read-only and updated by nandwrite, not individual file updates.
> 
> 3b) With CFG_JFFS2_SORT_FRAGMENTS disabled.
> 
> Qualitative performance: TBD <= 2b

For what it's worth, the results of (3b) above with a 4 MB "boot" JFFS2 file
system were the same as (2b) where "/boot" was just a subdirectory of the 12
MB (62 MB total NAND space) "/" JFFS2 file system:

In short, qualitative performance: Takes about 30 seconds to two minutes.

So, with CFG_JFFS2_SORT_FRAGMENTS disabled it would appear that fsload on
JFFS2 is O(1) with respect to one or all of: file system size, inodes or
dirents in the 4 MB to 64 MB range.

Regards,

Grant
