Return-Path: <r.goyet@gmail.com>
Received: from mail-fx0-f228.google.com (mail-fx0-f228.google.com
	[209.85.220.228]) by ozlabs.org (Postfix) with ESMTP id 42691B7CF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 21:32:59 +1100 (EST)
Received: by fxm28 with SMTP id 28so1603024fxm.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 03:32:57 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Mar 2010 11:32:57 +0100
Message-ID: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
Subject: Booting headless PowerMac G5
From: Romain Goyet <r.goyet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,


  Here's a summary about "how to boot a PowerMac G5 without a screen
attached". As many people have noticed, default yaboot install won't
boot unless a screen is attached.

  Actually, the workaround is really simple. Thing is, that's the
"ofboot.b" script that messes things up. This script is a "bridge",
that actually either starts yaboot or let you boot off of a CD. I
don't know what's the point, since OpenFirmware already lets you boot
off of the CD by pressing C on boot=E2=80=A6

  So basically, to boot headless, all you have to do is to tell
OpenFirmware to boot straight off the yaboot binary, and to skip the
ofboot.b
Just boot into OpenFirmware (Command-Option-O-F), and type :
setenv boot-device hd:2,yaboot (where 2 is the number of the partition
containing yaboot)
boot

And here you go, you can unplug that useless monitor :-)

References :
http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOOT.h=
tml
http://grub.enbug.org/TestingOnPowerPC

By the way, as of writing this, grub2 on PPC from debian gives a "out
of memory" issue. Known bug.
