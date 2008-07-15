Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 60F4FDE653
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 04:30:24 +1000 (EST)
Message-ID: <487CEC85.2070801@denx.de>
Date: Tue, 15 Jul 2008 20:29:25 +0200
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: Alex_SYS <schmid-grafenau@t-online.de>
Subject: Re: Videomode 800x480
References: <18470632.post@talk.nabble.com>
In-Reply-To: <18470632.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
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

then you probably should retrieve proper values for fb_videomode
from display controller registers set up by U-Boot. If you do not
have the spec for your panel, it is the way to go. Consult the
GDC manual (Display control registers section) and
Documentation/fb/framebuffer.txt in the linux source tree.

Best regards,
Anatolij
