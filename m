Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 9973B2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 14:07:58 +1100 (EST)
Date: Fri, 8 Feb 2013 14:07:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 4/8] cputime: Generic on-demand virtual cputime accounting
Message-Id: <20130208140749.5a094f271e529dacfb962b51@canb.auug.org.au>
In-Reply-To: <1359399845-10568-5-git-send-email-fweisbec@gmail.com>
References: <1359399845-10568-1-git-send-email-fweisbec@gmail.com>
 <1359399845-10568-5-git-send-email-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__8_Feb_2013_14_07_49_+1100_4a4.HCEzi3ISuzA2"
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

--Signature=_Fri__8_Feb_2013_14_07_49_+1100_4a4.HCEzi3ISuzA2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

On Mon, 28 Jan 2013 20:04:01 +0100 Frederic Weisbecker <fweisbec@gmail.com>=
 wrote:
>
> If we want to stop the tick further idle, we need to be
> able to account the cputime without using the tick.
>=20
> Virtual based cputime accounting solves that problem by
> hooking into kernel/user boundaries.
>=20
> However implementing CONFIG_VIRT_CPU_ACCOUNTING require
> low level hooks and involves more overhead. But we already
> have a generic context tracking subsystem that is required
> for RCU needs by archs which plan to shut down the tick
> outside idle.
>=20
> This patch implements a generic virtual based cputime
> accounting that relies on these generic kernel/user hooks.
>=20
> There are some upsides of doing this:
>=20
> - This requires no arch code to implement CONFIG_VIRT_CPU_ACCOUNTING
> if context tracking is already built (already necessary for RCU in full
> tickless mode).
>=20
> - We can rely on the generic context tracking subsystem to dynamically
> (de)activate the hooks, so that we can switch anytime between virtual
> and tick based accounting. This way we don't have the overhead
> of the virtual accounting when the tick is running periodically.
>=20
> And one downside:
>=20
> - There is probably more overhead than a native virtual based cputime
> accounting. But this relies on hooks that are already set anyway.
>=20
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Namhyung Kim <namhyung.kim@lge.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

This patch has the side effect of changing the default configurations:
(This is PowerPC pseries_defconfig before/after this patch)

@@ -119,8 +120,8 @@
 #
 # CPU/Task time and stats accounting
 #
-# CONFIG_TICK_CPU_ACCOUNTING is not set
-CONFIG_VIRT_CPU_ACCOUNTING=3Dy
+CONFIG_TICK_CPU_ACCOUNTING=3Dy
+# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_TASKSTATS=3Dy
 CONFIG_TASK_DELAY_ACCT=3Dy

I don't know if that was deliberate, but it was suprising.  I noticed
when this patch entered next-20130207.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__8_Feb_2013_14_07_49_+1100_4a4.HCEzi3ISuzA2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRFGwFAAoJEECxmPOUX5FEMN8P/3dRSchYze3oBTe8bQVG8EVm
tW0xi0+/8hWWJFjybgy+uZ7mBKYmiaDoNSiZ9iFqZ3V6CY2HZteixa0WIubfgbKb
/YsLDK0aQUnGWo7hjb7WAYGcYcJOl9NKBg7j2I742ydn1fXYTfB+M507uGgnIx6v
gGay1GQUQyVSr6o/mkKwevysH0TiME4eTGmqVmANQLWmEvhdixSnTcJWS5b3XBx9
0xlhOKqm2QhDjs/1x/ft4E3v2xotiJ4T+blsbAUDT+irB/NZD+tKBZLbP8luUCHr
aRMEyqOXgHOzjGTH5YXIYPrI8lUPZXBzsXMKoKB7cV5Gccxytw3n9Pz9PdiH1CwJ
x2oSbsvjEVNbW4R/mh6mekeJm563h67fFEbpuqiIJ3Onkfu9yC6Tl75BfosxMxS8
5hZquUShWSP+FihLt1a4JZ0rdStGRoesc0aWGSXXzErkV6qGzZbCyipJcLBQzCco
xp2qvuUc+JZknsAckqECOfKbshDRwZdBz8OjV+92JZsS9PeGDolJPB2X749wHU1M
sB7qQE/bsgXsybLprI7+3NXGbCfyG3dZhJ2/FXK03l3dhPU+J06amvzlb3uC8zpX
4OL502esdvsmJdaYJCGKkJUTlM1V6gQwqd42cqKWOypv5xxdCHZC+WRyugj4Z8H8
77GBi43R8vJrzcKPXV01
=WaJI
-----END PGP SIGNATURE-----

--Signature=_Fri__8_Feb_2013_14_07_49_+1100_4a4.HCEzi3ISuzA2--
