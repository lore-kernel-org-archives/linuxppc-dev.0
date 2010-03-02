Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f181.google.com (mail-qy0-f181.google.com
	[209.85.221.181]) by ozlabs.org (Postfix) with ESMTP id A288EB7DDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Mar 2010 14:18:24 +1100 (EST)
Received: by qyk11 with SMTP id 11so1814929qyk.24
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 01 Mar 2010 19:18:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <48abf2c21003011820k4e259734ma5b1d0fd79fc4af9@mail.gmail.com>
References: <48abf2c21003011820k4e259734ma5b1d0fd79fc4af9@mail.gmail.com>
Date: Tue, 2 Mar 2010 11:18:21 +0800
Message-ID: <48abf2c21003011918k2d759597q6f9cc1de25c75fc9@mail.gmail.com>
Subject: Re: something gets odd when I set the mtd.dev.parent
From: Peter Pan <pppeterpppan@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Problem solved. The NULL oops is due to the mtd->dev.class->p is NULL,
which makes the spin_lock in "get_device_parent" function uses a false
spin_lock_t struct.
the line is "spin_lock(&dev->class->p->class_dirs.list_lock);"
That is mainly because in function add_mtd_device function uses the
static struct mtd_class to fill into mtd->dev.class. The static struct
is not initialized because I drop the driver in our custom dirctory,
which is in /arch/powerpc/platforms/..., not in the /drivers/mtd/nand
directory, after I put the file there and modifies the Makefile,
everything works fine.

2010/3/2 Peter Pan <pppeterpppan@gmail.com>:
>
> We use Address A20 and A21 connect to ALE and CLE, the data bus is
> connected through a buffer.
> The RE is OE AND with CS. the WE is PBS0 AND with CS. CE pin is
> connect to ground. It works
> fine in VxWorks. And also in our previous Linux version 2.6.22.
>
> Now, I get a odd problem. My GPCM Nand flash driver is mostly copied
> from fsl_upm.c. In the fun_probe
> function, I have printed out the of_device pointer status as follows:
> ofdev= 0xcf851ca0
> ofdev->dev= 0xcf851cb0
> ofdev->dev.class= 0xcf851d50
>
> Then I set the &ofdev->dev to mtd.dev.parent using
> fun->mtd.dev.parent = &ofdev->dev;
>
> Then I print out the values:
> fun->mtd.dev.parent= 0xcf851cb0
> fun->mtd.dev.parent->class= 0x0
>
> The parent pointer is identical, but the class member is NULL, which
> makes the access of NULL pointer oops
> later.
>
> I'm wondering why this could happen. The pointer points at the same
> address, shouldn't all the members be the
> same?
>
