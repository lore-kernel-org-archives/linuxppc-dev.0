Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id AD4DE2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 14:14:48 +1100 (EST)
Date: Fri, 8 Feb 2013 14:14:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 4/8] cputime: Generic on-demand virtual cputime accounting
Message-Id: <20130208141447.03914013db9a5f7308fc1675@canb.auug.org.au>
In-Reply-To: <20130208140749.5a094f271e529dacfb962b51@canb.auug.org.au>
References: <1359399845-10568-1-git-send-email-fweisbec@gmail.com>
 <1359399845-10568-5-git-send-email-fweisbec@gmail.com>
 <20130208140749.5a094f271e529dacfb962b51@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__8_Feb_2013_14_14_47_+1100_8PRWiGC1WXHj12yk"
Cc: Namhyung Kim <namhyung.kim@lge.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__8_Feb_2013_14_14_47_+1100_8PRWiGC1WXHj12yk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Fri, 8 Feb 2013 14:07:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> This patch has the side effect of changing the default configurations:
> (This is PowerPC pseries_defconfig before/after this patch)
>=20
> @@ -119,8 +120,8 @@
>  #
>  # CPU/Task time and stats accounting
>  #
> -# CONFIG_TICK_CPU_ACCOUNTING is not set
> -CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> +CONFIG_TICK_CPU_ACCOUNTING=3Dy
> +# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
>  # CONFIG_BSD_PROCESS_ACCT is not set
>  CONFIG_TASKSTATS=3Dy
>  CONFIG_TASK_DELAY_ACCT=3Dy
>=20
> I don't know if that was deliberate, but it was suprising.  I noticed
> when this patch entered next-20130207.

I suspect that this is caused by the changes to init/Kconfig:

diff --git a/init/Kconfig b/init/Kconfig
index be8b7f5..a05f843 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -326,6 +326,9 @@ source "kernel/time/Kconfig"
=20
 menu "CPU/Task time and stats accounting"
=20
+config VIRT_CPU_ACCOUNTING
+	bool
+
 choice
 	prompt "Cputime accounting"
 	default TICK_CPU_ACCOUNTING if !PPC64

The next line of context is:

        default VIRT_CPU_ACCOUNTING if PPC64

Which may have needed changing as well?  Indeed, changing that to
VIRT_CPU_ACCOUNTING_NATIVE restores the old defaults.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__8_Feb_2013_14_14_47_+1100_8PRWiGC1WXHj12yk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRFG2nAAoJEECxmPOUX5FEGF4P/3BLna8t0BGkV9U4Iqk576Tc
/yHogk27oIY6LjqSaMbRXyPs1b0DdzyHuMQ/jhdKzazNZzQ9PzcZD1PlOo+h31Pw
Y53JcalMqFuq2xvCNnYjralphv2mHKDOJXErp22srdnXN+8V93Qn1dMLWApKZ/MX
ElHJGS6XGvBHwZ9CEPu+q80vDIE0ctHtMZlee0JJCPnXcsPvArUgoMzV/+5SArET
oRwc7pXEtz/IbV+8bdjEVoVSSCC/J9ch40mVKF+y4g8aCxqIvpji+8uZyCAHrAmx
1jrwTcaKb3ef6tQVQksQWSIfzj8qMeHJzDBiQhInrVmumQi7LE9u84IbyAo9hEsB
0saEux8PHoBHjlt0tU7SH8B6nSMfywt8RKkZHEKa4vzLgQ7J+qDRFsZiEVCSZrTk
LcJNyo0H9Dz+4R3hN/jgwHr9jdGtFynyGdg/y2agpaFmUxkbbkZ1hvFnoroXvTnF
awm6CuJxG05EaV0BUINiJYeG9pLCDWJLuJRMvw8/wTKWCvh/rysC0Pju9s7GH+Ed
QyJ1aLBQXSZWszhXXQm0Ry/XphqbzmhTqclRHfR0HnkvQa3fnY+LIr4OgQHLE5N/
maV4LMaT3YrlLRlIZq3cDm72fbGggrW7YCPpV5DQTOb3v9uFjPUYw/PbnZb8nFgR
UMdJAJUHMbl+eSAHQTkC
=OV61
-----END PGP SIGNATURE-----

--Signature=_Fri__8_Feb_2013_14_14_47_+1100_8PRWiGC1WXHj12yk--
