Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 30FBBB6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:19:54 +1100 (EST)
Subject: Re: [PATCH V2 1/2] powerpc: Move GE GPIO and PIC drivers
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330424541-5299-2-git-send-email-martyn.welch@ge.com>
Date: Tue, 6 Mar 2012 06:19:37 -0600
Message-Id: <C5C3845E-9732-4A9D-B1DC-84688E7D807F@kernel.crashing.org>
References: <1330424541-5299-1-git-send-email-martyn.welch@ge.com>
 <1330424541-5299-2-git-send-email-martyn.welch@ge.com>
To: Martyn Welch <martyn.welch@ge.com>
Cc: linus.walleij@stericsson.com,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Wim Van Sebroeck <wim@iguana.be>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 28, 2012, at 4:22 AM, Martyn Welch wrote:

> Move the GE GPIO and PIC drivers to allow these to be used by non-86xx
> boards.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@ge.com>
> ---
>=20
> v2: Move GPIO and PIC drivers to sysdev/ge/ rather than platforms/.
>=20
> arch/powerpc/platforms/86xx/Kconfig                |    3 +++
> arch/powerpc/platforms/86xx/Makefile               |    7 +++----
> arch/powerpc/platforms/86xx/gef_ppc9a.c            |    2 +-
> arch/powerpc/platforms/86xx/gef_sbc310.c           |    2 +-
> arch/powerpc/platforms/86xx/gef_sbc610.c           |    2 +-
> arch/powerpc/sysdev/Kconfig                        |    7 +++++++
> arch/powerpc/sysdev/Makefile                       |    2 ++
> arch/powerpc/sysdev/ge/Makefile                    |    2 ++
> .../86xx/gef_gpio.c =3D> sysdev/ge/ge_gpio.c}        |    2 +-
> .../86xx/gef_pic.c =3D> sysdev/ge/ge_pic.c}          |    2 +-
> .../86xx/gef_pic.h =3D> sysdev/ge/ge_pic.h}          |    0
> drivers/watchdog/Kconfig                           |    2 +-
> 12 files changed, 23 insertions(+), 10 deletions(-)
> create mode 100644 arch/powerpc/sysdev/ge/Makefile
> rename arch/powerpc/{platforms/86xx/gef_gpio.c =3D> =
sysdev/ge/ge_gpio.c} (98%)
> rename arch/powerpc/{platforms/86xx/gef_pic.c =3D> sysdev/ge/ge_pic.c} =
(99%)
> rename arch/powerpc/{platforms/86xx/gef_pic.h =3D> sysdev/ge/ge_pic.h} =
(100%)

gpio driver should be in drivers/gpio.  Please split that move out as a =
separate patch for Grant & Linus to review as part of the GPIO subsystem

- k=
