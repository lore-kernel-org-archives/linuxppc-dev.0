Message-ID: <39992943.C267C4CB@wanadoo.fr>
Date: Tue, 15 Aug 2000 13:28:03 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Jack Howarth <howarth@bromo.med.uc.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4-test7 broken
References: <200008150304.UAA31773@bromo.med.uc.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I too would like to know if somebody has this kernel running.
Jack Howarth wrote:
>
> Hello,
>     There are several problems with the current bitkeeper unstable
> kernel tree. The first two our compilation problems which can be
> fixed if someone with write access to bitkeeper will submit these
> two patches...
>
> --- linuxppc_2_3/drivers/input/adbhid.c.org     Mon Aug 14 22:59:01 2000
> +++ linuxppc_2_3/drivers/input/adbhid.c Mon Aug 14 22:59:36 2000
[]

This one has been mentioned on the list already. I hope someone (Paul?)
will listen this time. The same thing goes for the following patch which
has been published several times but not applied:

--- arch/ppc/kernel/ppc_ksyms.c.ori     Mon Aug 14 09:18:11 2000
+++ arch/ppc/kernel/ppc_ksyms.c         Sun Jul 16 09:06:49 2000
@@ -253,7 +253,7 @@
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
 #endif /* CONFIG_NVRAM */
-#ifdef CONFIG_PPC_RTC
+#ifdef CONFIG_PPC_RTC_MODULE
 EXPORT_SYMBOL(mktime);
 EXPORT_SYMBOL(to_tm);
 #endif


> --- linuxppc_2_3/include/asm-ppc/fcntl.h.org    Mon Aug 14 22:54:35 2000
> +++ linuxppc_2_3/include/asm-ppc/fcntl.h        Mon Aug 14 22:55:56 2000
> @@ -35,6 +35,10 @@
[]

This one has been included in the bitkeeper kernel in the meantime.
On the other hand, the corresponding changeset introduced another bug by
changing the type of the function find_via_cuda() from void to int, but
only its declaration in the header file include/linux/cuda.h and not its
definition in drivers/macintosh/via-cuda.c. Doesn't compile.

> The third problem is more serious. The resulting kernel gets stuck in
> the Freeing unused kernel memory stage. This is similar to the problem
> Geert mentioned earlier on the mailing list.

Mine gets stuck after saying "arch: exit" and before switching from the
prom console to the fb console (no penguin).

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
