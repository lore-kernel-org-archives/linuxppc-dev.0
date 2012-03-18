Return-Path: <dbaryshkov@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37F9EB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 01:04:07 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so873284pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 07:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332031585.3105.197.camel@pasglop>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
Date: Sun, 18 Mar 2012 18:04:04 +0400
Message-ID: <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org,
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

On Sun, Mar 18, 2012 at 4:46 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2012-03-17 at 20:04 +0400, Dmitry Eremin-Solenikov wrote:
>> Hello,
>>
>> I'm trying to make framebuffer to work on PPC460EX board (canyonlands).
>>
>> The peculiarity of this platform is the fact that it has
>> sizeof(unsigned long) = 4,
>> but physical address on it is 36 bits width. It is a common to various pieces
>> of the code to expect that unsigned long variable is able to contain physical
>> address. Most of those places are easy to fix.
>
> Yes. In fact, Tony (CC) has some patches to fix a lot of the DRM
> infrastructure (we have radeon KMS working on a similar platform).

That is interesting! Are those patches published or otherwise available
somewhere? We are also very interested in enabling Canyonlands
with Radeon KMS!

>
>> The problem I'm stuck with is a fb_mmap() code. To find a right memory to map
>> it uses information from struct fb_fix_screeninfo provided by the driver.
>> This structure uses two unsigned long fields to hold physical addresses
>> (smem_start and mmio_start). It would be easy to change that structure
>> to use phys_addr_t instead of unsigned long, but this structure is a part
>> of userspace ABI. It is returned to userspace on FBIOGET_FSCREENINFO ioctl.
>> And now I'm stuck with it.
>
> It's an old problem, which I think we described a while back on the
> list. Back then the conclusion was to make a new version with a proper
> __u64, a new ioctl to access is, and a "compatible" ioctl that blanks
> the address fields (or fails) if they contain a value >32-bit.
>
> We just never got to actually implement it.

I see. I will try to prepare patches.

>
> In fact, we could make the new structure such that it doesn't break
> userspace compatibility with 64-bit architectures at all, ie, the "new"
> and "compat" ioctl could remain entirely equivalent on 64-bit.

I remember stuff about compat_ioctl, but I have never used/implemented
that. Are there any details of requirements for the structures being passed?

-- 
With best wishes
Dmitry
