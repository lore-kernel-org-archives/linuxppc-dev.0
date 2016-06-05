Return-Path: <marwahamza63@gmail.com>
Received: from mail-vk0-x232.google.com (mail-vk0-x232.google.com
 [IPv6:2607:f8b0:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rMwfT4qS0zDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jun 2016 21:32:17 +1000 (AEST)
Received: by mail-vk0-x232.google.com with SMTP id e4so31029702vkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jun 2016 04:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464999780.22191.53.camel@buserror.net>
References: <CAGF64GXnJ-qPHo6xoueE5hPmuNFDG+n+oNWr-O1J1kaUD0zyDg@mail.gmail.com>
 <1464999780.22191.53.camel@buserror.net>
From: Marwa Hamza <marwahamza63@gmail.com>
Date: Sun, 5 Jun 2016 12:32:14 +0100
Message-ID: <CAGF64GWve7q2gEhz6nHCoZg2vJf+M2UT-_1HXPhF+ss0V483CQ@mail.gmail.com>
Subject: Fwd: running qemu for powerpc (32bits) architecture
To: oss@buserror.net, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=94eb2c0b7694b8b6120534864edf
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0b7694b8b6120534864edf
Content-Type: text/plain; charset=UTF-8

---------- Forwarded message ----------
From: Scott Wood <oss@buserror.net>
Date: 2016-06-04 1:23 GMT+01:00
Subject: Re: running qemu for powerpc (32bits) architecture
To: Marwa Hamza <marwahamza63@gmail.com>, linuxppc-dev@lists.ozlabs.org


On Mon, 2016-05-30 at 10:04 +0100, Marwa Hamza wrote:
> hello everyone
> I'm trying to run qemu for powerpc architecture but either
> 1/ i got a black screen with this sentence " QEMU 2.4.0.1 monitor - type
> help for more information"
>                        (QEMU)
> if i run this command ./ppc-softmmu/qemu-system-ppc -M ppce500 -kernel
> ../linux-4.4.1/arch/powerpc/boot/zImage -initrd powerpc/busybox
> -1.21.0/rootfs.img.gz -append "root=/dev/ram rdinit=/bin/sh"

I can't help with the other platforms, but for ppce500, make sure you have
CONFIG_PPC_QEMU_E500 enabled in the kernel (and that it's an e500 build, of
course), pass either uImage or vmlinux (not zImage) to -kernel, and specify
the desired cpu type on the QEMU command line (using -cpu) to match the type
of kernel you built.  I recommend using e500mc rather than older e500
because
then you get standard floating point which your RFS may depend on.

Also note that this target will have a serial port for output, not a
display,
so configure QEMU appropriately with -serial for how you want to access
that.

If you need more help (especially with other PPC platforms) I suggest the
qemu-ppc@nongnu.org mailing list.

-Scott



hey
i tried what you said,
./ppc-softmmu/qemu-system-ppc -M ppce500 -kernel
/home/powerpc/linux-4.4.1/vmlinux -initrd
/home/busybox-1.21.0/rootfs.img.gz -append "root=/dev/ram console=ttyAMA0
rdinit=/sbin/init" -serial stdio -cpu e500mc
an error displayed Qemu can't load kernel vmlinux
other thing i didn't understand how i made sure that CONFIG_PPC_QEMU_E500
enabled in the kernel, what is the default configuration should i use?
what's the e500 build ?
regards
marwa

--94eb2c0b7694b8b6120534864edf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">---------- Forwarded messag=
e ----------<br>From: <b class=3D"gmail_sendername">Scott Wood</b> <span di=
r=3D"ltr">&lt;<a href=3D"mailto:oss@buserror.net">oss@buserror.net</a>&gt;<=
/span><br>Date: 2016-06-04 1:23 GMT+01:00<br>Subject: Re: running qemu for =
powerpc (32bits) architecture<br>To: Marwa Hamza &lt;<a href=3D"mailto:marw=
ahamza63@gmail.com">marwahamza63@gmail.com</a>&gt;, <a href=3D"mailto:linux=
ppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozlabs.org</a><br><br><br><spa=
n class=3D"">On Mon, 2016-05-30 at 10:04 +0100, Marwa Hamza wrote:<br>
&gt; hello everyone<br>
&gt; I&#39;m trying to run qemu for powerpc architecture but either<br>
&gt; 1/ i got a black screen with this sentence &quot; QEMU 2.4.0.1 monitor=
 - type<br>
&gt; help for more information&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (QEMU)<br>
&gt; if i run this command ./ppc-softmmu/qemu-system-ppc -M ppce500 -kernel=
<br>
&gt; ../linux-4.4.1/arch/powerpc/boot/zImage -initrd powerpc/busybox<br>
&gt; -1.21.0/rootfs.img.gz -append &quot;root=3D/dev/ram rdinit=3D/bin/sh&q=
uot;<br>
<br>
</span>I can&#39;t help with the other platforms, but for ppce500, make sur=
e you have<br>
CONFIG_PPC_QEMU_E500 enabled in the kernel (and that it&#39;s an e500 build=
, of<br>
course), pass either uImage or vmlinux (not zImage) to -kernel, and specify=
<br>
the desired cpu type on the QEMU command line (using -cpu) to match the typ=
e<br>
of kernel you built.=C2=A0 I recommend using e500mc rather than older e500 =
because<br>
then you get standard floating point which your RFS may depend on.<br>
<br>
Also note that this target will have a serial port for output, not a displa=
y,<br>
so configure QEMU appropriately with -serial for how you want to access tha=
t.<br>
<br>
If you need more help (especially with other PPC platforms) I suggest the<b=
r>
<a href=3D"mailto:qemu-ppc@nongnu.org">qemu-ppc@nongnu.org</a> mailing list=
.<br>
<span class=3D""><font color=3D"#888888"><br>
-Scott<br>
<br>
<br>
</font></span></div><br><div><div><div><div><div>hey<br></div>i tried what =
you said, <br>./ppc-softmmu/qemu-system-ppc
 -M ppce500 -kernel /home/powerpc/linux-4.4.1/vmlinux -initrd=20
/home/busybox-1.21.0/rootfs.img.gz -append &quot;root=3D/dev/ram=20
console=3DttyAMA0 rdinit=3D/sbin/init&quot; -serial stdio -cpu e500mc<br></=
div>an error displayed Qemu can&#39;t load kernel vmlinux <br></div>other
 thing i didn&#39;t understand how i made sure that CONFIG_PPC_QEMU_E500=20
enabled in the kernel, what is the default configuration should i use?=20
what&#39;s the e500 build ? <br></div>regards<br></div>marwa</div>

--94eb2c0b7694b8b6120534864edf--
