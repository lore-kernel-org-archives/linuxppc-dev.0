Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 45AC3DDEFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 18:50:51 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KJ2im-0006hN-08
	for linuxppc-embedded@ozlabs.org; Wed, 16 Jul 2008 01:50:48 -0700
Message-ID: <18482586.post@talk.nabble.com>
Date: Wed, 16 Jul 2008 01:50:47 -0700 (PDT)
From: Alex_SYS <schmid-grafenau@t-online.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Videomode 800x480
In-Reply-To: <487CEC85.2070801@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18470632.post@talk.nabble.com> <487CEC85.2070801@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hello,

Alex_SYS wrote:
> Hello, I have the problem that I need a Framebuffer resolution 800x480!
> Since now I have filled the fb_info, var and fix Structs!
> But there was the problem with the resolution!
> I have found out that the problem is the videomode!
> In modedb there is unfortunately no 800x480 Videomode, and I have tried my
> own 800x480 Struct, but the Kernel does`t want my settings (I tried to
> change an 800x600 to 800x480 only by changing yres to 480).
> Can someone tell me please a working fb_videomode struct for 800x480?

Values for 800x480 fb_videomode depend on the TFT-panel that
you are using. Without the spec of this panel it is hard to guess.
It is also hard to guess the value for .pixclock as we do not know
if internal or external clock is used as the source for display
reference clock. What is the value of GDC DCM0 register (at
offset 0x1fd0000 or 0x1fd0100 from the GDC base)?

Try something like this:
.xres = 800
.yres = 480
.pixclock = 40000
.left_margin = 86
.right_margin = 42
.upper_margin = 33
.lower_margin = 10
.hsync_len = 128
.vsync_len = 2

> The syncs are setted up by U-Boot .

>then you probably should retrieve proper values for fb_videomode
>from display controller registers set up by U-Boot. If you do not
>have the spec for your panel, it is the way to go. Consult the
>GDC manual (Display control registers section) and
>Documentation/fb/framebuffer.txt in the linux source tree.

Hello, the physical settings for sync are made by U-Boot and working!
But in Lunux when I use 800x480, the screen is well, but the Kernel crashes
at Bootup!
Using 800x600 works!
Now I need only "Dummy" settings, that I can tell Linux I would like 800x480
and the Kernel doesn`t crash!
I don`t know exactly why the Kernel crashes, I know only that the modedB
800x600 and so on work!
I will try your settings immediately!
Thanks

Alex

Best regards,
Anatolij
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
View this message in context: http://www.nabble.com/Videomode-800x480-tp18470632p18482586.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
