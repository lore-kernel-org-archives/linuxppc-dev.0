Return-Path: <yamazaki.seiji@kk.jp.panasonic.com>
Received: from smtp.mei.co.jp (smtp.mei.co.jp [133.183.100.20])
	by ozlabs.org (Postfix) with ESMTP id 35E9FDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 18:51:33 +1100 (EST)
Received: from mail-gw.jp.panasonic.com ([157.8.1.145])
	by smtp.mei.co.jp (8.12.11.20060614/3.7W/kc-maile13) with ESMTP id
	n337pVmC015720
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 16:51:31 +0900 (JST)
Received: by mail-gw.jp.panasonic.com (8.11.6p2/3.7W/somlb1) with ESMTP id
	n337pVX13984
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 16:51:31 +0900 (JST)
Received: from epochmail.jp.panasonic.com (localhost [127.0.0.1])
	by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili07) with ESMTP id
	n337pYb19538
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 16:51:34 +0900 (JST)
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/somla1) id
	n337pVU5022483
	for linuxppc-dev@ozlabs.org; Fri, 3 Apr 2009 16:51:31 +0900 (JST)
Received: from [10.74.116.86]
	by somla1.jp.panasonic.com (8.12.11.20060308/3.7W) with ESMTP id
	n337pUoR022465
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Apr 2009 16:51:30 +0900 (JST)
Date: Fri, 03 Apr 2009 16:51:30 +0900
From: yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Interrupt ID number on mpc8347
Message-Id: <20090403163928.4679.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
I have another problem.

I use many external Interrupts.

one of them ,I setup 
	localbus@f0000000 {	//WDT,SW etc.k
		reg = <0xf0000000 0x20>;
		pci_inta@2{
			interrupt-parent = <&ipic>;
			interrupts = <17 0x8>;
		};
	};
on dts file.

And I programmed
	struct device_node *np;
	struct resource irq_res;
	int ret;
	
	char *irqs[]={
		"pci_inta",
		 NULL};
	for(i=0;;i++){
		if(irqs[i]==NULL){
			break;
		}
		np = of_find_node_by_name(NULL, irqs[i]);
		if (np == NULL) {
			printk("No %s in DTB. Has it been eaten by wild dogs?\n",irqs[i]);
			return -ENODEV;
		}
		if (!of_device_is_available(np)){
			printk("No %s in DTB. of_device_is_availables?\n",irqs[i]);
			return -ENODEV;
		}
		ret = of_irq_to_resource(np, 0, &irq_res);
		if (ret == NO_IRQ)
			irq_res.start = irq_res.end = 0;
		else
			irq_res.flags = 0;
		printk("********************************* %s irq_res.start=%d,irq_res.end=%d\n",irqs[i],irq_res.start,irq_res.end);
	}

printk result is

********************************* pci_inta irq_res.start=19,irq_res.end=19


I set the Interrupt ID number 17.
But kernel gives the Interrupt ID number 19.

I wont to know the reasen.
Please tell me.

-Seiji Yamazaki

-- 
yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
