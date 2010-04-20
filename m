Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 7B233B7CF8
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Apr 2010 04:16:03 +1000 (EST)
Date: Tue, 20 Apr 2010 11:15:05 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
In-Reply-To: <1271765898.4324.2.camel@concordia>
Message-ID: <alpine.DEB.2.01.1004201104170.13016@bogon.housecafe.de>
References: <deuQKFRcc0B.A.3EG.BRSzLB@tosh> <YeFfFNFyTSF.A.vUB.fSSzLB@tosh>
	<alpine.DEB.2.01.1004192339190.13016@bogon.housecafe.de>
	<1271765898.4324.2.camel@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	adobriyan@gmail.com, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Apr 2010 at 22:18, Michael Ellerman wrote:
> Try this 100% unbuilt, 100% untested patch.

I added GFP_KERNEL to kstrdup to make the compile error go away:

fs/proc/proc_devtree.c: In function =E2=80=98unslash_name=E2=80=99:
fs/proc/proc_devtree.c:183: error: too few arguments to function =E2=80=98k=
strdup=E2=80=99
make[2]: *** [fs/proc/proc_devtree.o] Error 1
make[1]: *** [fs/proc] Error 2
make: *** [fs] Error 2

And now 2.6.34-rc5 compiles and boots without the warning. Thanks!=20
New dmesg and /proc/device-tree on:

  http://nerdbynature.de/bits/2.6.34-rc1/xlate_proc_name/

Alexey mentioned that this is "wasteful" - does it make the kernel slower?=
=20
I have not done any performance tests, but I'd rather stick with the=20
warning than make this Powerbook G4 any more slower :-\


Thanks again,
Christian.

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index ce94801..019581d 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -176,6 +176,24 @@ retry:
 =09return fixed_name;
 }
=20
+static const char *unslash_name(const char *name)
+{
+=09char *p, *fixed_name;
+
+=09fixed_name =3D kstrdup(name, GFP_KERNEL);
+=09if (!fixed_name) {
+=09=09printk(KERN_ERR "device-tree: Out of memory trying to unslash "
+=09=09=09=09"name \"%s\"\n", name);
+=09return name;
+=09}
+
+=09p =3D fixed_name;
+=09while ((p =3D strstr(p, "/")))
+=09=09*p++ =3D '_';
+
+=09return fixed_name;
+}
+
 /*
  * Process a node, adding entries for its children and its properties.
  */
@@ -212,6 +230,9 @@ void proc_device_tree_add_node(struct device_node *np,
 =09=09if (duplicate_name(de, p))
 =09=09=09p =3D fixup_name(np, de, p);
=20
+=09=09if (strstr(p, "/"))
+=09=09=09p =3D unslash_name(p);
+
 =09=09ent =3D __proc_device_tree_add_prop(de, pp, p);
 =09=09if (ent =3D=3D NULL)
 =09=09=09break;
--=20
BOFH excuse #369:

Virus transmitted from computer to sysadmins.
