Return-Path: <cristian.axenie@gmail.com>
Received: from mail-bw0-f207.google.com (mail-bw0-f207.google.com
	[209.85.218.207])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8DA56B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 15:14:17 +1000 (EST)
Received: by bwz3 with SMTP id 3so1718760bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jul 2009 22:14:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C20DE6983@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C20DE6983@mailsvr>
Date: Mon, 20 Jul 2009 08:14:14 +0300
Message-ID: <9c789a000907192214k2f523dc2w9f1f62d121a247f@mail.gmail.com>
Subject: Re: Mounting a USB flash stick based root FS directly.
From: Cristian Axenie <cristian.axenie@gmail.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello !
If you properly set the root fs on your USB flash you should try to
set it up using some uBoot bootargs :

e.g. :

setenv usbstick_args setenv bootargs root=/dev/sdXX ro
rootdelay=$HOW_MANY_SECONDS_TO_WAIT rootfstype=$YOUR_FS_TYPE
init=/sbin/init console=$consoledev,$baudrate;

setenv usbstick 'run usbstick_args;bootm fe500000 - fe700000'

setenv bootcmd run usbstick

Best !

On 7/20/09, Dushara Jayasinghe <DusharaJ@optiscan.com> wrote:
> Hi all,
>
> I'm attempting to mount the root file system directly from a USB flash stick
> (thus avoiding a ram-disk). The init thread is delayed until the USB device
> is enumerated. However, I find the call to sys_mount() in line 218 @
> http://git.denx.de/?p=linux-2.6-denx.git;a=blob;f=init/do_mounts.c;h=8d4ff5afc1d80b56963cbf119b162a3ebce61124;hb=ad2a8c8d0593bf2d1ef163f1ca7574f02b2e770e
> fails. The problem is I can't work out where sys_mount() is implemented.
>
> I'm working off the 2.6.29-DENX kernel (commit id
> ad2a8c8d0593bf2d1ef163f1ca7574f02b2e770e). and My target CPU is an
> mpc8349.
>
>
> Thanks in advance.
>
>
> Dushara Jayasinghe
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
