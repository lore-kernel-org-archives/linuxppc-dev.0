Return-Path: <madhvesh.s@ap.sony.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id CB98ADDE28
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 01:21:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [RFC] Kprobes for book-e
Date: Fri, 20 Jun 2008 20:51:04 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D2E35AB@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>, linuxppc-dev@ozlabs.org,
	rsmadhvesh@vsnl.net, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote on Thursday, June 19, 2008 10:15 PM
> To: Sulibhavi, Madhvesh
> > No!!, this code cannot be removed. My tests fail
> > while doing the probe test for do_gettimeofday and __kmalloc.
> > I get Oops and Segfault. I think i had got similar results
> > in my initial port using 2.6.26.39. Here is the log...
>=20
> What is that test.  Can you send it to me.  Its not clear to me why =20
> this is an issue.

My test code is very simple and it is added at the
end of this mail. Brief steps include..

1. Build k-007.c and k-008.c as kernel modules
2. Insert the k-008.ko first=20
3. Insert k-007.ko
4. Do any operation like "ls"
5. Ooops will be seen followed by Segv


-Madhvesh

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
//k-008.c test code

#include <linux/module.h>
#include <linux/init.h>
#include <linux/kprobes.h>
#include <linux/kallsyms.h>
=20
static struct kprobe k_008_kp1;
=20
static void __exit k_008_exit_probe(void)
{
        unregister_kprobe(&k_008_kp1);
}
=20
static int k_008_pre_handler(struct kprobe *k_008_kp1, struct pt_regs
*p)
{
        return 0;
}
=20
static int __init k_008_init_probe(void)
{

        /* Registering a kprobe */
        k_008_kp1.pre_handler =3D (kprobe_pre_handler_t)
k_008_pre_handler;
=20
        k_008_kp1.symbol_name =3D "do_gettimeofday";
=20
        if( register_kprobe(&k_008_kp1) <0 ) {
                printk("k-008.c: register_kprobe is failed\n");
                return -1;
        }
=20
        register_kprobe(&k_008_kp1);
=20
        return 0;
}
=20
module_init(k_008_init_probe);
module_exit(k_008_exit_probe);
=20
MODULE_DESCRIPTION("Kprobes test module");
MODULE_LICENSE("GPL");

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
//k-007.c test code

static struct kprobe k_007_kp, k_007_kp1;
int k_007_kmalloc_count =3D 0;
int k_007_kfree_count =3D 0;
=20
static int k_007_kmalloc_hndlr(struct kprobe *kpr, struct pt_regs *p)
{
        k_007_kmalloc_count++;
        return 0;
}
=20
static int k_007_kfree_hndlr(struct kprobe *kpr, struct pt_regs *p)
{
        k_007_kfree_count++;
        return 0;
}
=20
static int __init k_007_kmf_init(void)
{
        k_007_kp.pre_handler =3D k_007_kmalloc_hndlr;
        k_007_kp1.pre_handler =3D k_007_kfree_hndlr;
=20
        k_007_kp.symbol_name =3D "__kmalloc";
        k_007_kp1.symbol_name =3D "kfree";
=20
        if( (register_kprobe(&k_007_kp) <0) ||
(register_kprobe(&k_007_kp1) <0) ) {
                printk("k-007.c: register_kprobe is failed\n");
                return -1;
        }
=20
        return 0;
}
=20
static void __exit k_007_kmf_exit(void)
{
        printk("%%%%%%%%%%%%%%%%%%%%%%%%%\n\n");
        printk("kmalloc count is %d \n", k_007_kmalloc_count);
        printk("kfree count is %d \n", k_007_kfree_count);
        printk("\n\n\n%%%%%%%%%%%%%%%%%%%%%%\n");
        unregister_kprobe(&k_007_kp);
        unregister_kprobe(&k_007_kp1);
        printk(KERN_INFO "k-007 exiting...\n");
}
=20
module_init(k_007_kmf_init);
module_exit(k_007_kmf_exit);
MODULE_LICENSE("GPL");
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D







-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
