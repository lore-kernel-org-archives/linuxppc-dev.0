Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 2B47E67E73
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 15:15:46 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so81036wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 22:15:45 -0700 (PDT)
Message-ID: <9b7ca65705080222154ec23c2e@mail.gmail.com>
Date: Wed, 3 Aug 2005 14:15:45 +0900
From: Daniel Ann <ktdann@gmail.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <42f035f0.13006336.4667.1893SMTPIN_ADDED@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570508021721773d06f0@mail.gmail.com>
	<42f035f0.13006336.4667.1893SMTPIN_ADDED@mx.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A PPC kernel issue with UART ??
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A Ha. That's the question I've asked kumar earlier today. Having
inserted that myself it worked also. Still wondering why tho...

On 8/3/05, JohnsonCheng <johnsoncheng@qnap.com.tw> wrote:
> Actually, I had reviews all article about "serial console", just know I h=
ave
> to use LEVEL for interrupt, not EDGE. Unfortunately the default interrupt
> setting for kernel is with LEVEL, IRQ_SENSE_LEVEL, I think I don't need t=
o
> modify it.
> But I found I add ASYNC_SKIP_TEST flag to UART in sandpoint.h can fix my
> problem.
>=20
> Thanks,
> Johnson Cheng
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Daniel Ann
> Sent: Wednesday, August 03, 2005 8:22 AM
> To: JohnsonCheng
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: A PPC kernel issue with UART ??
>=20
> Johnson,
>=20
> You know what? I've had the exact same problem only day or two ago. I
> think the mail subject was "serial console" or something similar. Have
> a read at it.
>=20
> BTW, My problem was with interrupt setting.
> Daniel.
>=20
> On 8/2/05, JohnsonCheng <johnsoncheng@qnap.com.tw> wrote:
> >
> >
> > Dear All,
> >
> >
> >
> > I meet a wired UART problem on linux-2.6 with MPC8241 chip.
> >
> >
> >
> > My Environment is as following:
> >
> > CPU: MPC8241
> >
> > Linux: 2.6.12.3
> >
> > COM1 offset: 0x4500, COM2 offset: 0x4600
> >
> >
> >
> > When I booting my rootfs, it hangs at following message:
> >
> > RAMDISK: Compressed image found at block 0
> >
> > VFS: Mounted root (ext2 filesystem) readonly.
> >
> > Freeing unused kernel memory: 104k init
> >
> > EXT2-fs warning: checktime reached, running e2fsck is recommended
> >
> >
> >
> > I had add printk in tty_write() of drivers/char/tty_io.c, the message f=
rom
> > rootfs have printed.
> >
> > The conclusion is that message can be printed by printk() in linux kern=
el,
> > but can't be printed by printf() in user mode. I think it must be
> something
> > wrong for my UART configurations, does anybody know it??
> >
> >
> >
> >
> >
> > Best Regards,
> >
> > Johnson Cheng
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
>=20
>=20
> --
> Daniel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20


--=20
Daniel
