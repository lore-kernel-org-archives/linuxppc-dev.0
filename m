Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F319DE073
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 17:52:33 +1100 (EST)
Message-Id: <C65915E8-6544-4229-9ED2-D2BB936D537C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090108013110.GA11165@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode
	support
Date: Thu, 8 Jan 2009 00:50:22 -0600
References: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
	<20090108013110.GA11165@oksana.dev.rtsoft.ru>
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> +struct mpc83xx_pcie_priv {
> +	void __iomem *cfg_map;
> +	u32 dev_base;
> +};

So was thinking about this and was wondering about doing the following:

hose->cfg_addr /* use instead of dev_base to cache pci bus/dev/fn */
hose->cfg_data /* should be the outbound window used for pci cfg  
cycles */
hose->dn->data /* for IMMR regs to tweak window */

thoughts?

Doing this means we should be able to get rid of struct  
mpc83xx_pcie_priv

- k
