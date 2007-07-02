Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35882DDF05
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 03:07:40 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l62H7Y7T518972
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 17:07:34 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l62H7Z002908360
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 18:07:35 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l62G6B1p029989
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Jul 2007 17:06:12 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Date: Mon, 2 Jul 2007 19:19:26 +0200
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org, jim.houston@ccur.com
Subject: idr_get_new_above() limitation?
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707021919.27251.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, Stefan Roscher <ossrosch@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
For ehca device driver we're intending to utilize 
idr_get_new_above() and have written a test case, which I'm attaching
at the end. Basically it tries to get an idr token above a lower boundary
by calling idr_get_new_above() and then uses idr_find() to check if 
the returned token can be found. 
Here is our observation with 2.6.22-rc7 on ppc64:

Use lower boundary 0x3ffffffc
[root@xyz idr_bug]# insmod idr_test_mod.ko start=1073741820
insmod: error inserting 'idr_test_mod.ko': -1 Unknown symbol in module
[root@xyz idr_bug]# dmesg -c
i=3ffffffc token=3ffffffc t=000000003ffffffc
i=3ffffffd token=3ffffffd t=000000003ffffffd
i=3ffffffe token=3ffffffe t=000000003ffffffe
i=3fffffff token=3fffffff t=000000003fffffff
i=40000000 token=40000000 t=0000000000000000
Invalid object 0000000000000000. Expected 40000000

That means token 0x40000000 seems to be the "upper boundary" of idr_find().
However the behaviour is not consistent in that it was returned by
idr_get_new_above().

Looking at void *idr_find(struct idr *idp, int id)
{
	int n;
	struct idr_layer *p;

	n = idp->layers * IDR_BITS;
	p = idp->top;

	/* Mask off upper bits we don't use for the search. */
	id &= MAX_ID_MASK;

	if (id >= (1 << n))
		return NULL;

	while (n > 0 && p) {
		n -= IDR_BITS;
		p = p->ary[(id >> n) & IDR_MASK];
	}
	return((void *)p);
}
we found that the if-condition has failed:
  layers = 5
  IDR_BITS = 6
  n = 30
  (id >= (1 << n)) = (0x40000000 >= 0x40000000) = 1

Since MAX_ID_MASK=0x7fffffff, I'm wondering if 0x40000000 is the actual
upper boundary. Any hints or suggestions are appreciated.

Thanks!
Nam



#include <linux/module.h>
#include <linux/idr.h>

MODULE_LICENSE("GPL");

int start_opt = 0x7e000000;

module_param_named(start, start_opt, int, 0);

MODULE_PARM_DESC(start,
		 "Start token for idr_get_new_above(). Default 0x7e000000");

static int __init idr_test_init(void)
{
	DEFINE_IDR(idr);
	int token, ret;
	unsigned long i;

	for (i = start_opt;  i <= MAX_ID_MASK; i++) {
		void * t;
		if (!idr_pre_get(&idr, GFP_KERNEL)) {
			printk(KERN_ERR "ERROR: Out of mem\n");
			return -ENOENT;
		}
		ret = idr_get_new_above(&idr, (void*)i, start_opt, &token);
		switch (ret) {
		case 0:
			t = idr_find(&idr, token);
			printk(KERN_ERR "i=%lx token=%x t=%p\n", i, token, t);
			if (t != (void*)i) {
				printk(KERN_ERR "Invalid object %p. Expected %lx\n",
				       t, i);
				return -ENOENT;
			}
			break;
		case -EAGAIN:
			i--;
			printk("idr_get_new_above() ret=-EAGAIN\n");
			break;
		default:
			printk(KERN_ERR "ERROR: Out of mem\n");
			break;
		}
	}
	/*
	 * return an error in any case since we don't need the module
	 * loaded anyway.
	 */
	return -ENOENT;
}

static void __exit idr_test_exit(void)
{
	printk(KERN_ERR "module exit\n");
}

module_init(idr_test_init);
module_exit(idr_test_exit);
