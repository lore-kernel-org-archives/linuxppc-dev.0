Return-Path: <dbaryshkov@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5312B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 03:04:23 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so594773pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 09:04:21 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 17 Mar 2012 20:04:21 +0400
Message-ID: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
Subject: Problem with framebuffer mmap on platforms with large addressing
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Josh Boyer <jwboyer@gmail.com>, Matt Porter <mporter@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm trying to make framebuffer to work on PPC460EX board (canyonlands).

The peculiarity of this platform is the fact that it has
sizeof(unsigned long) = 4,
but physical address on it is 36 bits width. It is a common to various pieces
of the code to expect that unsigned long variable is able to contain physical
address. Most of those places are easy to fix.

The problem I'm stuck with is a fb_mmap() code. To find a right memory to map
it uses information from struct fb_fix_screeninfo provided by the driver.
This structure uses two unsigned long fields to hold physical addresses
(smem_start and mmio_start). It would be easy to change that structure
to use phys_addr_t instead of unsigned long, but this structure is a part
of userspace ABI. It is returned to userspace on FBIOGET_FSCREENINFO ioctl.
And now I'm stuck with it.

In my driver code I have just overwritten the fb_mmap function with
driver-private
fb_mmap callback supporting 64-bit addressing, but this doesn't look like
a generic and correct solution.

What is the best way to fix this problem? Should we break ABI with the goal
of correctness? Should we add new FBIOGET_FSCREENINFO2, which will
return a correct structure with phys_addr_t (or simply u64) fields and make
FBIOGET_FSCREENINFO a wrapper returning partially bogus structure
(with smem_start and mmio_start fields being truncated to just unsigned long)?
What would developers recommend?


Thank you.


-- 
With best wishes
Dmitry
