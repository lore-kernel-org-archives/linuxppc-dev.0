Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ew0-f167.google.com (mail-ew0-f167.google.com
	[209.85.219.167]) by ozlabs.org (Postfix) with ESMTP id 9EC78DE023
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 18:25:33 +1000 (EST)
Received: by ewy11 with SMTP id 11so3348641ewy.9
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 01:25:31 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20090517100643.9d00e980.krzysztof.h1@poczta.fm>
References: <20090515181237.22961.64270.stgit@localhost.localdomain>
	<20090517100643.9d00e980.krzysztof.h1@poczta.fm>
Date: Sun, 17 May 2009 10:25:31 +0200
Message-ID: <10f740e80905170125ie1c1aew441de30874e6a72f@mail.gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Add PLB support and cleanup
	DCR in xilinxfb driver.
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Antonino Daplas <adaplas@gmail.com>, Suneel <suneelg@xilinx.com>,
	linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 17, 2009 at 10:06, Krzysztof Helt <krzysztof.h1@poczta.fm> wrot=
e:
> On Fri, 15 May 2009 12:19:17 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>> index 40a3a2a..7a868bd 100644
>> --- a/drivers/video/xilinxfb.c
>> +++ b/drivers/video/xilinxfb.c
>> @@ -107,17 +111,28 @@ static struct fb_var_screeninfo xilinx_fb_var =3D =
{
>> =C2=A0 =C2=A0 =C2=A0 .activate =3D =C2=A0 =C2=A0 FB_ACTIVATE_NOW
>> =C2=A0};
>>
>> +
>> +#define PLB_ACCESS_FLAG =C2=A0 =C2=A0 =C2=A00x1 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* 1 =3D PLB, 0 =3D DCR */
>> +
>> =C2=A0struct xilinxfb_drvdata {
>>
>> =C2=A0 =C2=A0 =C2=A0 struct fb_info =C2=A0info; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* FB driver info record */
>>
>> - =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs_phys;=
 =C2=A0 =C2=A0 =C2=A0/* phys. address of the control registers */
>> - =C2=A0 =C2=A0 u32 __iomem =C2=A0 =C2=A0 *regs; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* virt. address of the control registers */
>> + =C2=A0 =C2=A0 phys_addr_t =C2=A0 =C2=A0 regs_phys; =C2=A0 =C2=A0 =C2=
=A0/* phys. address of the control
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 registers */
>
> There are fields fb_info.fix.mmio_start and fb_info.fix.mmio_len for
> physical IO range used by framebuffer. There is no field for
> virtual IO address so the "regs" below must stay.

If I'm not mistaken, this driver is used on ppc44x, where phys_addr_t is 64=
-bit,
so the 32-bit unsigned long fb_info.fix.mmio_start is not large enough
to hold the
physical address.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
