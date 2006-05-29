Return-Path: <jourdan@enib.fr>
Received: from alto.enib.fr (alto.enib.fr [195.221.233.5])
	by ozlabs.org (Postfix) with ESMTP id 61687679FD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 17:39:51 +1000 (EST)
Message-ID: <1402.194.3.133.184.1148888040.squirrel@webmail.enib.fr>
In-Reply-To: <20060524195747.0CE6E353BFD@atlas.denx.de>
References: Your message of "Wed, 24 May 2006 18:54:00 +0200."            
	<3799.194.3.133.184.1148489640.squirrel@webmail.enib.fr>
	<20060524195747.0CE6E353BFD@atlas.denx.de>
Date: Mon, 29 May 2006 09:34:00 +0200 (CEST)
Subject: Re: Can't get CoralP drivers to work
From: jourdan@enib.fr
To: "Wolfgang Denk" <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: jourdan@enib.fr, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> In message <3799.194.3.133.184.1148489640.squirrel@webmail.enib.fr> you
> wrote:
>>
>> I have a MPC8260 processor card with a Coral-P evaluation board (rev
>> 4.0).
>> My system do not have keyboard nor mouse (i use the serial console).
>>
>> I use linux kernel 2.4.25 & 2.6.9.
>
> We have instructions on our web site; did you read these?

Yes I did. I use the same jumper configuration (for board rev 4.0) as the
pictures on your web site.

>> I'm trying to get the framebuffer driver to work. During the boot the
>> driver loads fine but the monitor remains blank (no video signal). If i
>> try to `cat /dev/urandom > /dev/fb/0` nothing happens.
>
> Are you using devfs? Don't! Use /dev/fb0

Without devfs, I have /dev/fb0.

During boot sequence, the driver loads fine (built-in, not module) :
...
MB86290: fb_init called.
MB86290: initialize called.
MB86290: GDC base phys address: 0x8c000000
MB86290: GDC base virt address: 0xc5000000
Console: switching to frame buffer device
MB86290: dmamem: GFP success.
MB86290: fb_init finished
...

In /proc I have :
#  more /proc/fb
0 MB86290

This seems ok to me but I don't have any video signal. My screen remains
blank.

>> I compiled an Xserver (Release 6.9), and the x11 drivers for the coralp.
>> When I start X, it says that it can not open tty0 (indeed it doesn't
>> exists).
>
> Well, you got an error message (tty0 cannot be opened), you  verified
> that it is valid (tty0 does not exist), so fix the problem...
>

Without devfs, I have ttys :
# ls -al tty*
crw-rw-rw-    1 root     root       5,   0 May 29  2006 tty
crw--w--w-    1 root     5          4,   0 May 29  2006 tty0
crw-rw----    1 root     5          4,   1 May 29  2006 tty1
crw-rw----    1 root     5          4,   2 May 29  2006 tty2
crw-rw----    1 root     14         4,  64 May 29  2006 ttyS0
crw-rw----    1 root     14         4,  65 May 29  2006 ttyS1
crw-rw----    1 root     14         4,  66 May 29  2006 ttyS2
crw-rw----    1 root     14         4,  67 May 29  2006 ttyS3
crw-rw-rw-    1 root     5          3,   0 May 29  2006 ttyp0
crw-rw-rw-    1 root     5          3,   1 May 29  2006 ttyp1
crw-rw-rw-    1 root     5          3,   2 May 29  2006 ttyp2
crw-rw-rw-    1 root     5          3,   3 May 29  2006 ttyp3
crw-rw-rw-    1 root     5          3,   4 May 29  2006 ttyp4
crw-rw-rw-    1 root     5          3,   5 May 29  2006 ttyp5
crw-rw-rw-    1 root     5          3,   6 May 29  2006 ttyp6
crw-rw-rw-    1 root     5          3,   7 May 29  2006 ttyp7
crw-rw-rw-    1 root     5          3,   8 May 29  2006 ttyp8
crw-rw-rw-    1 root     5          3,   9 May 29  2006 ttyp9

Major and minor codes are ok but when I start X :
...
Fatal server error:
xf86OpenConsole: Cannot open /dev/tty0 (No such file or directory)
...

I have to start X from a serial console. There are no keyboard or mouse
connectors on my board. This is maybe the source of my problems ?

Thanks for your help.
