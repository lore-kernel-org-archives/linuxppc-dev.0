Return-Path: <john.williams@petalogix.com>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id 28778B7D00
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 10:13:00 +1100 (EST)
Received: by pzk15 with SMTP id 15so2505966pzk.11
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Feb 2010 15:12:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100208224812.CBED7A87D1A@gemini.denx.de>
References: <1d3f23371002080247j17138famcf4e4aebc1ae04f5@mail.gmail.com>
	<20100208224812.CBED7A87D1A@gemini.denx.de>
Date: Tue, 9 Feb 2010 09:12:58 +1000
Message-ID: <1d3f23371002081512vec499d1wcd0ae2ea34d41df9@mail.gmail.com>
Subject: Re: simpleImage.XX and large kernels
From: John Williams <john.williams@petalogix.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

On Tue, Feb 9, 2010 at 8:48 AM, Wolfgang Denk <wd@denx.de> wrote:
>> I'm looking at the simpleImage.XXX make target (PPC 405/440), and it
>> seems that by default the arch/powerpc/boot/wrapper script places the
>> bootwrapper at 0x400000, effectively setting a limit on the maximum
>> bootable kernel size.
>>
>> For various reasons we'd like to be able to put a fairly complete
>> rootfs as an initramfs, which obviously blows past a 4Mbyte limit very
>> quickly. =A0Short of adding a new 'platform' option and associated
>> hackery through the powerpc/boot Makefiles and wrapper, is there a
>> quick and clean way I can tell the boot wrapper to link at a higher
>> address?
>
> Is there any specific reason why you want to use simpleImage, instead
> of using a normal uImage either bundled with your ramdisk image as a
> classic multifile image, or (recommended) as a FIT image?

Yes, there are a few reasons, though not necessarily very strong ones!
 Although we'll normally be using u-boot, I don't want to make it a
hard requirement.  simpleImage's ability to boot directly with a DTB
already bundled is attractive in this regard.

Another reason is that for compatibility with our MicroBlaze flow
(which also uses a simpleImage target, although a MicroBlaze
simpleImage is actually vmlinux with the DTB stuffed into its own
section).

Also sometimes it's nice to have a single ELF or binary blob we can
just push over JTAG straight to the target.  Having the DTB embedded
simplifies this process, no need to download vmlinux and DTB
separately, setup boot params etc.

I like FIT and think it's an elegant solution, I'm just a bit
reluctant to force its use.  For deeply embedded and flash constrained
systems we sometimes have a requirement to bypass uboot and boot
directly.

I may have to rethink the boot strategy eventually but in the short
term, getting some control over simpleImage as per my original post
would be a good first step.

Regards,

John
