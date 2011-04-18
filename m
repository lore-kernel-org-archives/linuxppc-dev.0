Return-Path: <vapier.adi@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4AD01007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 12:34:46 +1000 (EST)
Received: by yxp4 with SMTP id 4so2012199yxp.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 17 Apr 2011 19:34:42 -0700 (PDT)
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <201104172311.59289.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172311.59289.rjw@sisk.pl>
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 17 Apr 2011 22:34:22 -0400
Message-ID: <BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
Subject: Re: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of
	sysdevs for PM
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 17, 2011 at 17:11, Rafael J. Wysocki wrote:
> Convert some Blackfin architecture's code to using struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
>
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.

looks straight forward enough ...
Acked-by: Mike Frysinger <vapier@gentoo.org>

> +static struct syscore_ops nmi_syscore_ops =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D nmi_wd=
t_resume,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nmi_wd=
t_suspend,
> =C2=A0};

a bit sad this couldnt be made const
-mike
