Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 59B08DDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:10:25 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2640243qwe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 20:10:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243454097.3489.0@antares>
References: <20090525214718.GA8152@pengutronix.de> <1243454097.3489.0@antares>
Date: Wed, 27 May 2009 23:10:23 -0400
Message-ID: <9e4733910905272010j891b3deh89df84144b2bcb5e@mail.gmail.com>
Subject: Re: [Solved/Patch Question] Weird 5200/mtd-ram problem
From: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 3:54 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> Hi all:
>
> Am 25.05.09 23:47 schrieb(en) Wolfram Sang:
>>>
>>> A word or long copy of 0x0055aaff with U-Boot works fine, but a byte co=
py
>>> filled the whole ram with 0x0000aaaa. =A0The reason is apparently that =
the
>>> chip is attached to the local bus in 16-bit mode, which is incompatible=
 with
>>> byte accesses. =A0However, the Local Bus doesn't provide "low byte" or =
"high
>>> byte" indicators in non-muxed mode. =A0How is this supposed to work the=
n?
>>
>> Hmm, as I feared... we were bitten by this, too:
>>
>> http://thread.gmane.org/gmane.linux.drivers.mtd/21521
>>
>> There is no generic solution yet :(
>
> At least for my case, I could completely (afaict) solve the problem, i.e.=
 I
> can now access the 16-bit nv ram as mtd char and block device, the latter
> with jffs2. =A0I would like to submit a patch, but I actually don't know
> exactly how...
>
> The solution itself is quite simple: add a new method which works like
> memcpy_toio, but respects the fact that no single bytes may be written
> (reading through memcpy_fromio works painlessly). =A0I think this functio=
n
> should go into arch/powerpc/kernel/io.c, depending upon CONFIG_PPC_MPC52x=
x,
> and the prototype into arch/powerpc/include/asm/io.h, right?
>
> The harder part is to actually call this function properly. =A0I now call=
 it
> in include/linux/mtd/map.h, function inline_map_copy_to(), if
> CONFIG_PPC_MPC52xx is defined and if map->bankwidth is 2. =A0However, is =
it
> acceptable to have a processor-type dependency in a top-level include fil=
e?
> =A0Or what would be the proper way to implement it?

This is an old jffs2 patch that was addressing this same problem.

diff --git a/fs/jffs2/scan.c b/fs/jffs2/scan.c
index 272872d..c982adc 100644
--- a/fs/jffs2/scan.c
+++ b/fs/jffs2/scan.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/crc32.h>
 #include <linux/compiler.h>
+#include <asm/io.h>
 #include "nodelist.h"
 #include "summary.h"
 #include "debug.h"
@@ -505,7 +506,7 @@ static int jffs2_scan_eraseblock (struct
jffs2_sb_info *c, struct jffs2_eraseblo
 					sumptr =3D kmalloc(sumlen, GFP_KERNEL);
 					if (!sumptr)
 						return -ENOMEM;
-					memcpy(sumptr + sumlen - buf_len, buf + buf_size - buf_len, buf_len);
+					memcpy_fromio(sumptr + sumlen - buf_len, buf + buf_size -
buf_len, buf_len);
 				}
 				if (buf_len < sumlen) {
 					/* Need to read more so that the entire summary node is present */
@@ -1035,7 +1036,7 @@ static int jffs2_scan_dirent_node(struct
jffs2_sb_info *c, struct jffs2_eraseblo
 	if (!fd) {
 		return -ENOMEM;
 	}
-	memcpy(&fd->name, rd->name, checkedlen);
+	memcpy_fromio(&fd->name, rd->name, checkedlen);
 	fd->name[checkedlen] =3D 0;

 	crc =3D crc32(0, fd->name, rd->nsize);



>
> Thanks, Albrecht.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
