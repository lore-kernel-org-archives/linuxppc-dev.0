Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE700DDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 09:54:21 +1100 (EST)
Message-Id: <C09ECC62-C81F-41EA-9990-D127265F9CA4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <11963681602431-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: qe: fix device tree lookup code in qe_muram_init()
Date: Thu, 29 Nov 2007 16:54:13 -0600
References: <11963681602431-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 29, 2007, at 2:29 PM, Timur Tabi wrote:

> Function qe_muram_init() was only looking for a node called "data- 
> only",
> instead of making sure it is the correct node.  This patch modifies
> qe_muram_init() to find the QE node first, then the MURAM node  
> inside it,
> and then the data-only node.  It also reports errors.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/qe.c |   39 ++++++++++++++++++++++++++++++ 
> +--------
> 1 files changed, 31 insertions(+), 8 deletions(-)

Add a compatible property in the muram data-only node called "fsl,qe- 
muram-data" and match on that compatible to find the node instead of  
walking the tree like you are. And report an error if there isn't a  
'fsl,qe-muram-data' node

- k
