Return-Path: <patrick.huesmann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 1684367A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 02:05:56 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 68so310892wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 07:05:55 -0800 (PST)
Message-ID: <93579fec05031706597355371c@mail.gmail.com>
Date: Thu, 17 Mar 2005 15:59:14 +0100
From: Patrick Huesmann <patrick.huesmann@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
In-Reply-To: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: looking for a model for building CRAMFS(?)-based system
Reply-To: Patrick Huesmann <patrick.huesmann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, 16 Mar 2005 11:33:39 -0500 (EST), Robert P. J. Day
<rpjday@mindspring.com> wrote:
>   currently, the system i've built for our 850 board incorporates
> 
>         - boot loader (sadly, not u-boot, but i'm working on it)
>         - standard zImage.initrd.bin kernel+initrd image
>         ... mountable JFFS2 filesystem with persistent stuff ...
> 
>   obviously, with this layout, it's kind of a nuisance to update
> anything individually in the initrd portion of the system, so i'd like
> to at least experiment with a layout that has separate
> 
>         - boot loader (ideally, u-boot)
>         - kernel image
>         - updateable (normally mounted read-only?) root filesystem
>         ... rest of stuff the same ...

I'm using separate MTD partitions for bootloader, device parameters,
zImage, initrd and persistent storage.

When updating the initrd, the only thing necessary is a
eraseall /dev/mtdX
cat initrd.gz > /dev/mtdX

When booting the kernel, you need something like this in the commandline:
root=/dev/mtdblockX prompt_ramdisk=0 load_ramdisk=1 ramdisk_size=8192

This is bootloader independent, of course.

HTH,
Patrick
