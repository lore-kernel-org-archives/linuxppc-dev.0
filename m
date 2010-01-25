Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-111.bluehost.com (outbound-mail-111.bluehost.com
	[69.89.18.7]) by ozlabs.org (Postfix) with SMTP id 25CD81007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 07:45:36 +1100 (EST)
Date: Mon, 25 Jan 2010 12:38:49 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
Message-ID: <20100125123849.111fa2d1@jbarnes-piketon>
In-Reply-To: <4B5D9FC5.5070600@linux.vnet.ibm.com>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ron Mercer <ron.mercer@qlogic.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Jay Vosburgh <fubar@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	kaneshige.kenji@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jan 2010 11:42:29 -0200
Breno Leitao <leitao@linux.vnet.ibm.com> wrote:

> Hello, 
> 
> I found that qlge is broken on PPC, and it got broken after commit 
> 06a1cbafb253c4c60d6a54a994887f5fbceabcc0. It happens because
> dev->pcie is not set on PPC, because the function
> set_pcie_port_type(), who sets dev->pcie, is not being called on PPC
> PCI code.

You mean dev->is_pcie?

Why isn't pci_scan_device calling pci_setup_device for you?  That
should do the proper PCIe init depending on the device, along with
extracting other device info...

-- 
Jesse Barnes, Intel Open Source Technology Center
