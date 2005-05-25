Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id C45FC679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 May 2005 03:48:47 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so958167wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 10:48:45 -0700 (PDT)
Message-ID: <c3d0340b05052510483145039e@mail.gmail.com>
Date: Wed, 25 May 2005 10:48:45 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: John Otken <jotken@softadvances.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <4292A441.4080708@softadvances.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b0504251517589940b8@mail.gmail.com>
	<4292A441.4080708@softadvances.com>
Subject: Re: 2.6.10 unable to mount a root fs on ramdisk
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi John,

Thanks for your answer.

I did add these lines to the code. Actually it turned out that I was
so stupid that I didn't enable EXT2 filesystem support in the kernel.
That's why the kernel always complained unknown block.

-Shawn.

On 5/23/05, John Otken <jotken@softadvances.com> wrote:
> I had this problem with MV code on a Bamboo board.  Look at
> platform_init() in ebony.c.  Before the call to ibm44x_platform_init() ad=
d:
>=20
>        /*
>         * If we were passed in a board information, copy it into the
>         * residual data area.
>         */
>        if (r3)
>                __res =3D *(bd_t *)(r3 + KERNELBASE);
>=20
>        /*
>         * If the init RAM disk has been configured in, and there's a vali=
d
>         * starting address for it, set it up.
>         */
>        if (r4) {
>            initrd_start =3D r4 + KERNELBASE;
>            initrd_end =3D r5 + KERNELBASE;
>        }
>=20
>        /* Copy the kernel command line arguments to a safe place. */
>=20
>        if (r6) {
>            *(char *) (r7 + KERNELBASE) =3D 0;
>            strcpy(cmd_line, (char *) (r6 + KERNELBASE));
>        }
