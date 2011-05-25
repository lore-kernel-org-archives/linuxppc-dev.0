Return-Path: <B29882@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FDF1B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 04:52:34 +1000 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: Booting p4080ds on non-0 cpu
Date: Wed, 25 May 2011 18:52:23 +0000
Message-ID: <BANLkTi=jp2CbA+wCEVfM8O0-ON5ZUgo47A@mail.gmail.com>
References: <DBDC8B5977CFF7429A9DBC6C51C7ADE701E81C32@EU1-MAIL.mgc.mentorg.com>
	<DBDC8B5977CFF7429A9DBC6C51C7ADE701E81C39@EU1-MAIL.mgc.mentorg.com>
In-Reply-To: <DBDC8B5977CFF7429A9DBC6C51C7ADE701E81C39@EU1-MAIL.mgc.mentorg.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Blanchard,
	Hollis" <Hollis_Blanchard@mentor.com>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2011 at 7:16 AM, Gabbasov, Andrew
<Andrew_Gabbasov@mentor.com> wrote:
> Hello Matthew,
>
> You have made a patch
> "powerpc/fsl_booke:=A0Add=A0support=A0to=A0boot=A0from=A0core=A0other=A0t=
han=A00" some time
> ago, so you probably worked with booting the kernel on a cpu subset,
> particularly on the core other than 0.
>
> Could you please describe any details how you ran the kernel from u-boot =
on
> a non-0 cpu?

I did this via kexec not via u-boot. In this method I would reboot on
any one of the cores and it would bring up the other cores.

> I have a problem trying to boot linux on p4080ds platform on any non-0 cp=
u
> (as a first step to running AMP or mixed AMP/SMP configuration). I'm tryi=
ng
> to run 2.6.34.6 kernel with some Freescale patches in SMP configuration w=
ith
> full original device tree and device tree with some cpu nodes removed. I'=
m
> using the u-boot script, shown at the bottom of this message.
>
> If I run "bootm go" after the script commands (thus running the kernel on
> cpu 0), the kernel runs fine.
>
> When I'm trying to run the SMP kernel with full device tree on cpu 1 usin=
g
> the following commands after the script:
> =A0 fdt boot 1
> =A0 cpu 1 release 0 1 c00000 -
> the kernel begins to run, but soon crashes. Possible reasons
> are:=A0"Unrecoverable FP Unavailable Exception", at nearly random
> place;=A0memory allocation errors somewhere in DPAA=A0code and then segme=
ntation
> fault (sig 11); unknown exception (sig 4).=A0Sometimes it doesn't even sh=
ow
> anything on the console (too early exception?), but sometimes it boots
> successfully up to the shell prompt.

Is the single core boot stable at this point?

> When I'm trying to run the SMP kernel with the device tree with cpu 0
> stripped out (commented out the whole cpu0 node and all properties referr=
ing
> to it with &cpu0), using the following commands after the script:
> =A0 fdt boot 1
> =A0 cpu 1 release 0 0 c00000 -
> =A0 [Note the difference in the parameter to 'cpu 1 release' command,
> =A0=A0=A0 it should be a logical cpu number, which is different]
> the result is almost the same, the kernel crashes too. The reasons are
> similar to the above, with more often "Unrecoverable FP Unavailable
> Exception".

Can you send me the kernel boot logs and kernel defconfig? (off list perhap=
s)

>
> Can you give any advise why can this happen, and what I could be doing
> wrong?

Did you build your kernel relocatable? Did you use the -b option when
compiling your device tree? We do have a hypervisor for this part
which might be a more suitable and tested solution depending on what
you are trying to accomplish. I'm not sure that anyone has explicitly
tested AMP on a p4080.

-M=
