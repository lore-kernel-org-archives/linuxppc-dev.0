Return-Path: <linasvepstas@gmail.com>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185]) by ozlabs.org (Postfix) with ESMTP id C77CCB7CE8
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 06:09:56 +1100 (EST)
Received: by yxe15 with SMTP id 15so3200250yxe.9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 11:09:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
Date: Wed, 27 Jan 2010 13:09:53 -0600
Message-ID: <3ae3aa421001271109s6b857384x7617566220ffc38b@mail.gmail.com>
Subject: Re: [PATCH 1/2] eeh: Fixing a bug when pci structure is null
From: Linas Vepstas <linasvepstas@gmail.com>
To: leitao@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Yes, that's really my sign off: I discussed this at length with Breno.
One comment:

2010/1/27  <leitao@linux.vnet.ibm.com>:
> During a EEH recover, the pci_dev structure can be null,

It can be null when an error is detected during device config (i.e. via
pci config space access through open firmware, using the OF device
node, instead of mmio/dma access), before the kernel has created
a pci_dev structure for the device.

Oddly enough, either this slipped through the cracks all this time,
or maybe pci_name() used to protect against nulls? Not sure.

-- Linas Vepstas
