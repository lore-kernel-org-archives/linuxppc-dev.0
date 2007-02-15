Return-Path: <watashin@mvision.co.jp>
Received: from mail.asahi-net.or.jp (mail2.asahi-net.or.jp [202.224.39.198])
	by ozlabs.org (Postfix) with ESMTP id 9A768DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 21:16:40 +1100 (EST)
Received: from wata (c200018.ppp.asahi-net.or.jp [210.155.200.18])
	by mail.asahi-net.or.jp (Postfix) with SMTP id 980A02AECA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 19:16:34 +0900 (JST)
Message-ID: <013b01c750ea$5e8544b0$1601a8c0@wata>
From: "Shinji Watanabe" <watashin@mvision.co.jp>
To: <linuxppc-embedded@ozlabs.org>
Subject: How to access MPC8555 DMA register ?
Date: Thu, 15 Feb 2007 19:16:27 +0900
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-2022-jp";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't know how to bind the driver.

I maked driver of pci device type for MPC8555 as Log.A.

/var/log/message log is Log.B.

When I called platform_get_resource,
I can't get validate value.

Why ?

please help me!

///////////////////////// log.A

#define VENDORID_MVPPC 0x1057
#define DEVICEID_MVPPC 0x000A

static struct pci_device_id ids[] = {
 { PCI_DEVICE(VENDORID_MVPPC, DEVICEID_MVPPC), },
 { 0, }
};

MODULE_DEVICE_TABLE(pci, ids);

static struct pci_driver pci_driver = {
 .name = PCI_DEVICE_NAME, 
 ...
 .id_table = ids,
 .probe = probe,
};


static int probe(struct pci_dev *dev, const struct pci_device_id *id)
{
 struct resource *res;
 ...
 ...
 struct platform_device *pdev = to_platform_device(&dev->dev);
 ..
 ..
 pci_enable_device(dev);
 ..
 ..
 res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  dprintk("res0 %p\n", 
   res
   );
 res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 dprintk("res1 %p\n", 
   res
   );
 res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
 dprintk("res2 %p\n", 
   res
   );
 ...
 ...
}


///////////////////////// log.b
Feb 10 11:34:23 mpc8555cds user.debug kernel: res0 00000000
Feb 10 11:34:23 mpc8555cds user.debug kernel: res1 00000000
Feb 10 11:34:23 mpc8555cds user.debug kernel: res2 00000000


Regars,

shinji
