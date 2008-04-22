Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1DB1DDFD1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 23:22:38 +1000 (EST)
In-Reply-To: <1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208758907.9955.4.camel@concordia>
	<CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
	<1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e642c15622ac3ca89a6a43f439f2c222@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
Date: Tue, 22 Apr 2008 15:22:16 +0200
To: michael@ellerman.id.au
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Jin Zhengxiong <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
>>>> +				  struct msi_msg *msg)

> No I mean I'm confused about the maths here. If we pull out the
> variables it boils down to:
>
> data = ((hwirq / 32) << 5) | ((hwirq % 32) & 0x1F)
>
> Which doesn't seem to actually do anything?

It's not a no-op, because hwirq is signed.  It probably should be
unsigned, like most things.


Segher
