Return-Path: <krzysztof.h1@poczta.fm>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by ozlabs.org (Postfix) with ESMTP id 9B42BDDE9A
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 18:48:04 +1100 (EST)
Date: Mon, 18 Feb 2008 08:18:47 +0100
From: Krzysztof Helt <krzysztof.h1@poczta.fm>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
Message-Id: <20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
In-Reply-To: <Pine.LNX.4.64.0802171030330.6848@anakin>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 17 Feb 2008 10:44:32 +0100 (CET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Fri, 15 Feb 2008, Anton Vorontsov wrote:
> > On Thu, Feb 14, 2008 at 10:49:42PM -0800, Andrew Morton wrote:
> > > On Tue, 5 Feb 2008 18:44:32 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> > > Actually...  should CONFIG_FB_FOREIGN_ENDIAN exist, or should this feature
> > > be permanently enabled?
> > 
(...)
> 
> The notion of `FOREIGN_ENDIAN' is relative, as it depends on the
> architecture you're compiling for.
> 
> Suppose you have a PCI graphics card with a frame buffer that's always
> big endian. When compiling for a big endian platform, the driver won't
> depend on FB_FOREIGN_ENDIAN. When compiling for a little endian
> platform, it will.
> 
> Shouldn't we add LITTLE_ENDIAN and BIG_ENDIAN Kconfig vars first, just
> like we have 64BIT?
> 

I disagree here. The FOREIGN_ENDIAN is enough. It is determined only by
graphics chip endianess and CPU (arch) endianess.
I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
Both resolve endianess at driver level. Actually, both handle it by setting special
bits so the graphics chip itself reorder bytes to transform foreign endianess. 
I understand that this patch is for chips which cannot reorder bytes by themselves.

So the FOREIGN_ENDIANESS flag should be set by the driver if it is needed
(if the graphics chip is BE and CPU is LE a simple #ifdef will add the flag).

> 
> I'd like to handle this in Kconfig (cfr. above).
> 

Again, it is possible. It is enough to put one rule which enables
the FOREIGN_ENDIAN if the architecture endianess is "foreign"
for the driver. The advantage here is that it  can be set only
for drivers which need it (as some driver can handle it without
this code). It should be hidden option set only internally if needed
(no user selectable).

I tested this patch on the s3c2410fb with disabled byte order
corrections by the graphics chip itself. It worked for 8-bit depth
but not for 16-bit depth (pixel position seemed ok but wrong tux'
colors). I will investigate. The s3c2410fb is BE and the kernel
was arm LE.

I would like to extend this patch to fb depths below 8-bit. The
s3c2410fb cannot handle this correctly with LE kernel.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Masz ostatnia szanse !
Sprawdz >>> http://link.interia.pl/f1d02  
