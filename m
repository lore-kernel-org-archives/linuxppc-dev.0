Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B1DEFB6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:13:07 +1100 (EST)
Subject: Re: [PATCH 2/4] fsl_pci: Add a workaround for PCI 5 errata in MPC8548
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331025056-15983-2-git-send-email-chenhui.zhao@freescale.com>
Date: Tue, 6 Mar 2012 06:13:05 -0600
Message-Id: <9449E54A-E134-45B9-A012-C824753D0C97@kernel.crashing.org>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
 <1331025056-15983-2-git-send-email-chenhui.zhao@freescale.com>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 3:10 AM, Zhao Chenhui wrote:

> +		if ((fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) &&

Should this also have 8547, 8547E, 8545, 8545E, 8543, & 8543E?

> +		    !early_find_capability(hose, 0, 0, PCI_CAP_ID_PCIX)) {
> +			early_read_config_word(hose, 0, 0,
> +						PCI_BUS_FUNCTION, &temp);
> +			temp |= PCI_BUS_FUNCTION_MDS;
> +			early_write_config_word(hose, 0, 0,
> +						PCI_BUS_FUNCTION, temp);
> +		}
> 	}
