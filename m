Message-ID: <3EA81B3F.9080709@embeddededge.com>
Date: Thu, 24 Apr 2003 13:13:35 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <20030424123313.A8490@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kent Borg wrote:

> The boot loader thingie in arch/ppc/boot/simple is nifty.  So why
> isn't there a provision for putting it on ROM?

Well, you normally place it in ROM along with the kernel that is
attached.

The purpose of all of these "bootloaders" is to convert a rom
calling sequence into a standard (yes, there is one) Linux start
up call.  They also perform any hardware specific "fixups" that
may be necessary prior to calling Linux.  Another feature is it
isolates boot rom changes from Linux changes.

The old PPCBoot, and probably the new U-boot, kind of perform
some of these functions.  The reason I'm not a fan of doing this
is if we make a change to the Linux calling sequence (which happens
rarely) you also have to update the boot rom to match.  Not a good
thing, IMHO.

The other really nice thing about these bootloaders, compressed
kernels, and attached initrd, is you can boot the identical image
from all "devices."  For example, during development you can tftp
load the image, get everything working, then place the exact same
bits into a flash rom.  Simply jump to the first location of the
image and it will boot from flash.

It's relatively easy to adapt these loaders to any custom product
requirements.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
