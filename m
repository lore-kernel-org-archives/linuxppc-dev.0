Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7533FDE06C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 23:07:00 +1100 (EST)
Message-ID: <47EA3BD9.2090308@denx.de>
Date: Wed, 26 Mar 2008 13:04:41 +0100
From: Anatolij Gustschin <agust@denx.de>
MIME-Version: 1.0
To: =?windows-1252?Q?=3F=3F=3F?= <liuxs226@gmail.com>
Subject: Re: system call ioctl() problem
References: <e81b2fb40803260313i14fe5a6dmc21513180466c454@mail.gmail.com>
In-Reply-To: <e81b2fb40803260313i14fe5a6dmc21513180466c454@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

??? wrote:
> hi,all
>   Here is a question I didn't make out, i wonder if anybody can figure 
> it out. My platform is mpc8540 with graphics chip Fujitsu MB86296, my 
> kernel version is 2.6.12.6 <http://2.6.12.6>. I'm about to write a 
> gfxdriver so DirectFB can call this gfxdriver to make MB86296 do some 
> drawing things. I wrote a program to test if the MB86296 drawing 
> registers can be read and written. here is some part of the pragram:

[snip]

> ioctl(3, 0x20004d2f, 0x7fe47914)        = -1 EINVAL (Invalid argument)
> write(1, "ioctlReadRes[0]=484,ioctlReadRes"...,
> 45ioctlReadRes[0]=484,ioctlReadRes[1]=30026f58
> ) = 45
> munmap(0x32028000, 4096)                = 0
> exit_group(45)                          = ?
> 
> 
> from above, I think the problem is in ioctl call, which shows "EINVAL 
> (Invalid argument)", so I added printk() to xx_ioctl() in fb driver, and 
> it showed xx_ioctl() was not called .Then I checked xx_ioctl() was 
> right.  where is my problem? how to call ioctl() right??

probably, your problem is missing mb86290-driver specific ioctl
hook in the "mb86290fb_ops" structure definition in
drivers/video/mb86290/mb86290fb.c.

Ensure that this structure definition contains something like this:

.fb_ioctl = mb86290fb_ioctl,

Without this assignment only generic framebuffer ioctl will be called,
maybe therefore you can not see driver specific ioctl call. Generic
ioctl "doesn't understand" FBIO_MB86290_READ_DRAW_REG argument and
simply returns -EINVAL.

Best regards,
Anatolij

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
