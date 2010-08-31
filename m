Return-Path: <timur.tabi@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by ozlabs.org (Postfix) with ESMTP id 64F40B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 02:57:20 +1000 (EST)
Received: by pvg13 with SMTP id 13so3148701pvg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 Aug 2010 09:57:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <09C49916-9A20-41CD-A7BA-2F467BFD24DA@freescale.com>
References: <1282946147-28164-1-git-send-email-msm@freescale.com>
	<AANLkTimYz6v2tMJRYnki9Ph33HL9yGsOcpgJ78LTDCTG@mail.gmail.com>
	<09C49916-9A20-41CD-A7BA-2F467BFD24DA@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 31 Aug 2010 11:56:48 -0500
Message-ID: <AANLkTikdm6f6dRDoOXuBx0-viwNqHuez4P+xTum+M+9O@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl_soc: Search all global-utilities nodes for
	rstccr
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 11:26 AM, Matthew McClintock <msm@freescale.com> wr=
ote:

>> I'm not sure KERN_EMERG is warranted for this kind of error.
>
> I'm not sure either - I left it as it was before.

My vote is to change it to KERN_ERR, but it's your call.

>> So if a node has an fsl,rstcr property, but the of_iomap() fails, we
>> jump to the next global-utilities node? =A0Perhaps you need a 'break'
>> after the printk()?
>
> Or potentially a continue to be more robust? Or would two (or more) "has-=
rstcr" nodes be wrong?

My point is that if the of_iomap() call fails, looking for another
global-utilities node is not the right course of action.  of_iomap()
failing is a serious error that should result in an immediate exit.

>> Wouldn't it make more sense to assign fsl_rstcr_restart to
>> ppc_md.restart only if we find a valid fsl,has-rstcr property?
>
> Again I'm not entirely sure, I left this as it was before. Is there anoth=
er way to reset the board if the rstcr node was not found correctly?

Not on our 85xx boards.  On 83xx, there's mpc83xx_restart().  I just
don't like "ppc_md.restart =3D=3D fsl_rstcr_restart", because it assumes
that the define_machine() entry is incorrect.

--=20
Timur Tabi
Linux kernel developer at Freescale
