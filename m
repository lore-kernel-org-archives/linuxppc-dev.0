Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: bug in XFree86 4.1.0 with Rage 128 driver?
Date: Wed, 10 Oct 2001 21:21:57 -0400
MIME-Version: 1.0
Cc: kevin.hendricks@sympatico.ca
Message-Id: <20011011011945.DFYL19597.tomts17-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am trying to track down a bug that causes OpenOffice to segfault under
XFree86 4.1.0 with rage 128 driver.  This same problem does NOT happen
with XFree 4.0.2.

The problem stems from incorrect or missing alpha information in the
visual.  Olaf tried it with a straight fbdev driver and the problem
disappears so it appears to be linked to changes in the Rage 128 driver
from XF 4.0.2 to XF 4.1.0.

I am trying to look at what changed and was wondering about the lack of
support for depth 32 in the r128 driver.

If I specify depth 32, I used to get 24 bits of color depth with 32 bpp in
the Rage 128 driver.  Now if I try to specify a  depth of 32 in the
XF86Config file, I get the following message:

"Given depth (32) is not supported by the r128 driver".

But if I specify 24 bits of color depth I seem to be getting cfb24 being
used instead of cfb32.

Does anyone know why this change was made?  The kernel itself does support
depths of "32" in the kernel rage 128 driver.

I agree this confuses the depth versus bpp issue but different code is
being used (cfb24 versus cfb32) and the resulting visuals have changed.

Any help would be greatly appreciated.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
