Date: Mon, 31 Jul 2000 13:03:53 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel panic in current benh tree (chrp)
Message-ID: <20000731130353.A9796@suse.de>
References: <20000729233822.A31230@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000729233822.A31230@suse.de>; from olh@suse.de on Sat, Jul 29, 2000 at 11:38:22PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 29, Olaf Hering wrote:

> the current benh tree gives me a kernel panic whit a chrp only config.

> Any ideas what can cause the problem?
> I will update the diffs of the last benh changes at
> ftp://ftp.suse.com/pub/suse/ppc/update/BETA/devel/kernel/benh/

The problem seems to be the size of prom.c. I tried all diffs and
reverse patched the above linux.tar.bz2, the 20th kernel worked then.

So, the diff that caused the problem was the following:


diff -urN source20/linux-pmac-benh/arch/ppc/kernel/prom.c source19/linux-pmac-benh/arch/ppc/kernel/prom.c
--- source20/linux-pmac-benh/arch/ppc/kernel/prom.c     Mon Jul 31 10:56:18 2000
+++ source19/linux-pmac-benh/arch/ppc/kernel/prom.c     Mon Jul 31 10:48:07 2000
@@ -1711,9 +1711,17 @@
        int l;

        for (np = allnodes; np != 0; np = np->allnext) {
-               char *pname = np->parent ?
-                       (char *)get_property(np->parent, "name", &l) : 0;
-               if (pname && strcmp(pname, "mac-io") == 0)
+               int in_macio = 0;
+               struct device_node* parent = np->parent;
+               while(parent) {
+                       char *pname = (char *)get_property(np->parent, "name", &l);
+                       if (pname && strcmp(pname, "mac-io") == 0) {
+                               in_macio = 1;
+                               break;
+                       }
+                       parent = np->parent;
+               }
+               if (in_macio)
                        continue;
                reg = (unsigned int *) get_property(np, "reg", &l);
                if (reg == 0 || l < sizeof(struct reg_property))


But, when I insert a printk() before the "for" loop it works again. But
the size of the vmlinux didn't change.


So it seems that the size of prom.c can cause any problems?
I use quik as boot loader, the zImage from arch/ppc/chrpboot/ didn't
work as well. The machine is a B50 with 1GB ram.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
