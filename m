Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (mail.tranzeo.com [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 834D0DDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 23:56:46 +1000 (EST)
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
From: Darcy Watkins <dwatkins@tranzeo.com>
To: paul@mad-scientist.us
In-Reply-To: <1219928864.16802.69.camel@homebase.localnet>
References: <1219928864.16802.69.camel@homebase.localnet>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 06:56:44 -0700
Message-Id: <1219931804.21952.15.camel@localhost>
Mime-Version: 1.0
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

Hi Paul,

A hack we did when building a ported WiMax driver against 2.6.19 was to
merge the two asm-p.*pc directories.

Below is a snippet from one of our build scripts that does this.
Assuming KERNEL_SRC_PATH is set to point to your kernel source...

#------------------
if [ ! -d $KERNEL_SRC_PATH/include/asm-ppc-merged ]; then
echo "Creating a merged include/asm for arch/ppc and arch/powerpc"
mkdir $KERNEL_SRC_PATH/include/asm-ppc-merged
cp -r $KERNEL_SRC_PATH/include/asm-powerpc/* $KERNEL_SRC_PATH/include/asm-ppc-merged
cp -r $KERNEL_SRC_PATH/include/asm-ppc/* $KERNEL_SRC_PATH/include/asm-ppc-merged
fi

echo "Symlinking the merged include/asm"
cd $KERNEL_SRC_PATH/include
rm asm
ln -s asm-ppc-merged asm
#------------------

Based on this order, files from arch/ppc win but missing files will come
from arch/powerpc.

You could try it out.  Mileage may vary, especially newer than 2.6.23
since there may be device tree dependent stuff that gets into the merged
directory.  We stopped using this hack for kernel 2.6.23 and newer since
we migrated to arch/powerpc for 2.6.23 and later (presently using
2.6.25) so I really don't know whether or not it will work for you.

If you use the symlinked shadow source tree facility of the Xenomai
build with your kernel, then use "-rs" instead of "-r" in the "cp"'s
above.  Otherwise just use "-r" as shown above.

Regards,

Darcy


On Thu, 2008-08-28 at 06:07 -0700, Paul Smith wrote:
--snip!--
> In general it seems like lots of headers that used to be in both asm
> directories now appear in only asm-powerpc; I don't really see how
> this
> is supposed to work.  Any tips on this would be most welcome.
--snip!--
-- 


Regards,

Darcy

--------------
Darcy L. Watkins - Senior Software Developer
Tranzeo Wireless Technologies, Inc.
19273 Fraser Way, Pitt Meadows, BC, Canada V3Y 2V4
T:604-460-6002 ext:410
http://www.tranzeo.com
