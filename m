Message-ID: <40CD9F20.4040603@246tNt.com>
Date: Mon, 14 Jun 2004 14:50:40 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATH] Fix a warning in traps.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Huh, it's the only warning I got when compiling, so I someone could
fix it ...

--- arch/ppc/kernel/traps.c.old 2004-06-14 14:43:34.908368944 +0200
+++ arch/ppc/kernel/traps.c     2004-06-14 14:38:29.309826984 +0200
@@ -646,7 +646,7 @@
        /* The kernel has executed an altivec instruction without
           first enabling altivec.  Whinge but let it do it. */
        if (++kernel_altivec_count < 10)
-               printk(KERN_ERR "AltiVec used in kernel (task=%p, pc=%x)\n",
+               printk(KERN_ERR "AltiVec used in kernel (task=%p,
pc=%lx)\n",
                       current, regs->nip);
        regs->msr |= MSR_VEC;
 }



Regards,

    Sylvain Munaut


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
