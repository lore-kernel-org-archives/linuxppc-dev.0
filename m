Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BE203B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 11:46:48 +1100 (EST)
Message-ID: <1332031585.3105.197.camel@pasglop>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date: Sun, 18 Mar 2012 11:46:25 +1100
In-Reply-To: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-03-17 at 20:04 +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> I'm trying to make framebuffer to work on PPC460EX board (canyonlands).
> 
> The peculiarity of this platform is the fact that it has
> sizeof(unsigned long) = 4,
> but physical address on it is 36 bits width. It is a common to various pieces
> of the code to expect that unsigned long variable is able to contain physical
> address. Most of those places are easy to fix.

Yes. In fact, Tony (CC) has some patches to fix a lot of the DRM
infrastructure (we have radeon KMS working on a similar platform).

> The problem I'm stuck with is a fb_mmap() code. To find a right memory to map
> it uses information from struct fb_fix_screeninfo provided by the driver.
> This structure uses two unsigned long fields to hold physical addresses
> (smem_start and mmio_start). It would be easy to change that structure
> to use phys_addr_t instead of unsigned long, but this structure is a part
> of userspace ABI. It is returned to userspace on FBIOGET_FSCREENINFO ioctl.
> And now I'm stuck with it.

It's an old problem, which I think we described a while back on the
list. Back then the conclusion was to make a new version with a proper
__u64, a new ioctl to access is, and a "compatible" ioctl that blanks
the address fields (or fails) if they contain a value >32-bit.

We just never got to actually implement it.

In fact, we could make the new structure such that it doesn't break
userspace compatibility with 64-bit architectures at all, ie, the "new"
and "compat" ioctl could remain entirely equivalent on 64-bit.
 
> In my driver code I have just overwritten the fb_mmap function with
> driver-private
> fb_mmap callback supporting 64-bit addressing, but this doesn't look like
> a generic and correct solution.
> 
> What is the best way to fix this problem? Should we break ABI with the goal
> of correctness? Should we add new FBIOGET_FSCREENINFO2, which will
> return a correct structure with phys_addr_t (or simply u64) fields and make
> FBIOGET_FSCREENINFO a wrapper returning partially bogus structure
> (with smem_start and mmio_start fields being truncated to just unsigned long)?
> What would developers recommend?

Cheers,
Ben.
