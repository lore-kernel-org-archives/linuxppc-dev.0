Mime-Version: 1.0
Message-Id: <a05010406b65254022de4@[192.168.240.10]>
In-Reply-To: <19341029132129.28967@192.168.1.2>
References: 
  <Pine.LNX.3.96L.1001204120321.24147A-100000@IBUPROFEN.WEH.ANDREW.CMU.EDU>
 <19341029132129.28967@192.168.1.2>
Date: Tue, 5 Dec 2000 09:30:06 +0100
To: Benjamin Herrenschmidt <bh40@calva.net>
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Re: vmode & atyfb (fwd)
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >in the current kernels (2.2.18pre) and with the first ibook (ATI RAGE
>>Mobility,  not a Rage 128), there are several problems I am aware of :
>>
>>- the color table is bad so there is some gitch on the console
>>colors. You may see in booting in level 3 (no X login) and trying a
>>make menuconfig. The only fix I have found was to reinitilise the
>>console with vmode (or fbset when you correct the second problem I am
>>reporting)
>
>That's new. Did you ever had this problem before ? Can you track it down
>to a specific kernel version ?

All the kernels I have tested have had this problem (i mean all -benh
kernels and the current 2.2.18pre). The problem is not obvious but is
shown in menuconfig and probably other curse based utilities.

>
>>- the geometry reported by the framebuffer is bad because the virtual
>>number of lines is very big (~2600). I have tracked the problem in
>>following code in aty_init() function :
>>
>>      if (var.yres == var.yres_virtual) {
>>          u32 vram = (info->total_vram - (PAGE_SIZE << 2));
>>          var.yres_virtual = ((vram * 8) / var.bits_per_pixel) /
>>var.xres_virtual;
>>          if (var.yres_virtual < var.yres)
>>                  var.yres_virtual = var.yres;
>>      }
>
>I'll see this with Geert, it may indeed be an atyfb bug
>
>>- there are some problems with the atyfb : it seems to be not working
>>with XFree-FB (hangs up). Also it hange when you try some simple
>>thing as copy from or to /dev/fb0 (hangup the system). I think there
>>are some problems with the starting and ending addresses of the
>>framebuffer.
>
>I don't know for XFree-FB (it's possible that the old XFree-FB ATI
>driver has troubles with the mobility chip). It should work with XF4.
>Accessing /dev/fb0 can be dangerous since the chip's MMIO registers
are located at the end of the framebuffer.

the probleme here is that a simple user space command like cp
/dev/fb0 /dev/null may kill the system. Isn't it a poor design ?

>
>>In all of theses cases, the vmode utility is working when fbset is
>>not. Also I think vmode works when not using a dedicated framebuffer
>>driver (for example with video=ofonly), so it is a good utility to
>>tests new drivers or for fresh install.
>
>vmode cannot work without a driver. All vmode does is to send an ioctl
>that ends up to a call to the framebuffer set_disp routine, exactly
>like fbset. The difference is that vmode us hard-coded mode values from
>a table (in macmodes.c) and fbset uses values from /dev/fb.modes. fbset
>also does more sanity check (your bug above).
>
>Ben.

ok, so it may be a good idea to comment all theses things (I mean the
framebuffer stuff and all the commands associated with it). Currently
there is no real information about :

- fb drivers parameters (it is always possible to look at the source
code, but a clever approach would be to comment them)
- fb driver loading (for example in some kernels the driver may be
build as a module : how to load it at startup ?).
- add a comment in the readme for pmac-utils just to say vmode is
replace with fbset.
- in testing and developing, it seems we all have problems with fb,
of, XFree and XPmac interractions, so a little dev document may be
helpfull.

Regards,
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
