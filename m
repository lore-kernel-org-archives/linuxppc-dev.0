Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0BFEB6F2B
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jan 2011 10:31:00 +1100 (EST)
Subject: Re: PMU_IOC_SLEEP failed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTim=HWGMWtXxQF3RzuVMHuG+RJNkzEMU=RnY2nuf@mail.gmail.com>
References: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
	<1293550353.19556.224.camel@thor.local>
	<AANLkTinBQAMvmmNP5S_=++UOQDoTe-1efD39VF0PO5kB@mail.gmail.com>
	<1293569648.17779.20.camel@pasglop>
	<AANLkTim=HWGMWtXxQF3RzuVMHuG+RJNkzEMU=RnY2nuf@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 Jan 2011 10:30:45 +1100
Message-ID: <1293838245.17779.69.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-12-29 at 00:35 +0100, jjDaNiMoTh wrote:
> >> (dmesg..)
> >> [...]
> >> radeonfb_pci_register BEGIN
> >> radeonfb 0000:00:10.0: BAR 0: can't reserve [mem
> 0xb8000000-0xbfffffff pref]
> >> radeonfb (0000:00:10.0): cannot request region 0.
> >> radeonfb: probe of 0000:00:10.0 failed with error -16
> >
> > That looks bad indeed. Send me the complete dmesg, a snapshot of the
> > device-tree (tar -c /proc/device-tree >foo.tar) and the output
> > of /proc/iomem please.
> 
> [1] http://nat.vacau.com/linux/iomem.txt.gz
> [2] http://nat.vacau.com/linux/dmesg_37-rc.txt.gz
> [3] http://nat.vacau.com/linux/device_tree.tar 

Are you trying to use radeonfb as a module ? The dmesg seems to indicate
that you have offb taking control of the framebuffer, preventing
radeonfb from loading.

There's no offb->radeonfb handover (the handover mechanism is new and
only used by KMS for now). On those machines, radeonfb should be
built-in.

Cheers,
Ben.
