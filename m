Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 903C9DE085
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 02:05:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 58/60] microblaze_v4: sys_microblaze.c
Date: Thu, 26 Jun 2008 18:04:24 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-58-git-send-email-monstr@seznam.cz>
	<1214483429-32360-59-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-59-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261804.25344.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> +
> +int sys_uname(struct old_utsname *name)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int err =3D -EFAULT;
> +
> +=A0=A0=A0=A0=A0=A0=A0down_read(&uts_sem);
> +=A0=A0=A0=A0=A0=A0=A0if (name && !copy_to_user(name, utsname(), sizeof(*=
name)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0up_read(&uts_sem);
> +=A0=A0=A0=A0=A0=A0=A0return err;
> +}

This actually seems to be dead code, as your sys_call_table only contains
sys_newuname but not sys_uname.

	Arnd <><
