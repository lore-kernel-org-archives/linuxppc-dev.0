Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 752B02C023D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:55:59 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 17 Jun 2013 18:55:52 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DD0CA19D8036
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 18:55:40 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I0tn5t151192
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 18:55:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I0tmrV009542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 18:55:49 -0600
Date: Tue, 18 Jun 2013 08:55:45 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/27] powerpc/eeh: Move common part to kernel directory
Message-ID: <20130618005545.GA2795@shangw.(null)>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371286998-2842-2-git-send-email-shangw@linux.vnet.ibm.com>
 <51BE7C77.1020602@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51BE7C77.1020602@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 17, 2013 at 11:03:19AM +0800, Mike Qiu wrote:
>=E4=BA=8E 2013/6/15 17:02, Gavin Shan =E5=86=99=E9=81=93:

.../...

>>+
>>+	/* Gather bridge-specific registers */
>>+	if (dev->class >> 16 =3D=3D PCI_BASE_CLASS_BRIDGE) {
>>+		eeh_ops->read_config(dn, PCI_SEC_STATUS, 2, &cfg);
>>+		n +=3D scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
>>+		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
>>+
>>+		eeh_ops->read_config(dn, PCI_BRIDGE_CONTROL, 2, &cfg);
>>+		n +=3D scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
>>+		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
>>+	}
>>+
>>+	/* Dump out the PCI-X command and status regs */
>>+	cap =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);
>BTW, when move common part , here you could use dev->pcie_cap at your
>convenience, and pcie_cap has
>been initialized in of_create_pci_dev--->set_pcie_port_type


Thanks, Mike. It's not safe enough to use the cached capability
offsets, which might be invalid when we running into here. However,
we probably use following code in future, but not now :-)

It would save some PCI-CFG access.

	if (dev->pcie_cap)
		cap =3D dev->pcie_cap;
	else
		cap =3D pci_find_capability(dev, PCI_CAP_ID_PCIX);=20

Thanks,
Gavin=20
