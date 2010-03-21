Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id C431DB7C09
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 21:15:44 +1100 (EST)
Received: by wwb31 with SMTP id 31so806400wwb.15
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Mar 2010 03:15:42 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
Date: Sun, 21 Mar 2010 11:15:41 +0100
Message-ID: <10f740e81003210315h640b9918g909ef6ad397afcec@mail.gmail.com>
Subject: Re: [PATCH] Macintosh: fix brace and trailing statement coding style
	issues in adb-iop.c This is a patch to the adb-iop.c file that cleans
	up
	brace and trailing statement warnings found by the checkpatch.pl tool.
	Signed-off-by: Michael Beardsworth <m
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: fthain@telegraphics.com.au
Content-Type: text/plain; charset=UTF-8
Cc: Michael Beardsworth <mbeards2@uoregon.edu>, linux-m68k@vger.kernel.org,
	benh@kernel.crashing.or, linuxppc-dev@ozlabs.org,
	Michael Beardsworth <mbeards@mbeards-mbp.lulzzzzzzz.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 21, 2010 at 10:16,  <fthain@telegraphics.com.au> wrote:
>> On Tue, Mar 09, 2010 at 01:46:20PM -0800, Michael Beardsworth wrote:
>> >...
>> >
>> > =C2=A0#ifdef DEBUG_ADB_IOP
>> > - =C2=A0 printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X",=
 req,
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint) amsg->count + 2, (uint) am=
sg->flags, (uint) amsg->cmd);
>> > + =C2=A0 printk(KERN_WARNING "adb_iop_listen %p: rcvd packet, %d bytes=
: %02X %02X",
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req, (uint) amsg->count + 2, (uin=
t) amsg->flags, (uint) amsg->cmd);
>> > =C2=A0 =C2=A0 for (i =3D 0; i < amsg->count; i++)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(" %02X", (uint) amsg-=
>data[i]);
>> > =C2=A0 =C2=A0 printk("\n");
>
>> >...
>> > =C2=A0#ifdef DEBUG_ADB_IOP
>> > - =C2=A0 printk("adb_iop_start %p: sending packet, %d bytes:", req, re=
q->nbytes);
>> > + =C2=A0 printk(KERN_WARNING "adb_iop_start %p: sending packet, %d byt=
es:", req, req->nbytes);
>> > =C2=A0 =C2=A0 for (i =3D 0 ; i < req->nbytes ; i++)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(" %02X", (uint) req->=
data[i]);
>> > =C2=A0 =C2=A0 printk("\n");
>
> KERN_DEBUG is used for debugging messages, not KERN_WARNING.

And that change is not covered by the patch description.

BTW, pr_debug(), these days.

>  int adb_iop_init(void)
>  {
> -       printk("adb: IOP ISM driver v0.4 for Unified ADB.\n");
> +       printk(KERN_MESSAGE "adb: IOP ISM driver v0.4 for Unified ADB.\n"=
);
>        iop_listen(ADB_IOP, ADB_CHAN, adb_iop_listen, "ADB");
>       return 0;
> }

Not to mention the non-existence of KERN_MESSAGE?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
