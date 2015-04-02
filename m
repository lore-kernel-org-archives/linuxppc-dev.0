Return-Path: <prvs=053460407f=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF9D41A0332
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 22:13:05 +1100 (AEDT)
Message-ID: <551D2304.40206@keymile.com>
Date: Thu, 02 Apr 2015 13:07:48 +0200
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: madalin.bucur@freescale.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC 00/10] introduce DPAA Ethernet driver
References: <1427905165-27732-1-git-send-email-madalin.bucur__44937.1718721979$1427907304$gmane$org@freescale.com>
In-Reply-To: <1427905165-27732-1-git-send-email-madalin.bucur__44937.1718721979$1427907304$gmane$org@freescale.com>
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/01/2015 06:19 PM, Madalin Bucur wrote:
> This is the second version of a patch series that adds
> the Ethernet driver for the Freescale QorIQ Data Path
> Acceleration Architecture (DPAA).
> 
> This second version includes the changes requested by
> Kumar Gala. The PM ops patch was removed as the
> supporting FMan driver code was de-featured from the
> first submission of the driver to reduce the review
> effort. 
> 
> Together with the driver a managed version of alloc_percpu
> is provided that simplifies the release of percpu memory.
> 
> The Freescale DPAA architecture consists in a series of
> hardware blocks that support the Ethernet connectivity.
> the Ethernet driver depends upon the Peripheral Access
> Memory Unit (PAMU), Frame Manager (FMan), Queue Manager
> (QMan), Buffer Manager (BMan). Drivers for these blocks
> are currently in the kernel or in review.
> 
> The current set of RFC patches is meant to provide early
> access to the codebase and also provide context and aid
> the review of the latest FMan driver patches submitted
> by Igal Liberman:
> 
> [RFC,v2,12/12] soc/fman: Add FMan MAC driver
> [RFC,v2,11/12] soc/fman: Add FMan Port Support
> [RFC,v2,10/12] soc/fman: Add FMan SP support
> [RFC,v2,09/12] soc/fman: Add FMan MAC support
> [RFC,v2,08/12] soc/fman: Add Frame Manager support
> [RFC,v2,07/12] soc/fman: Add FMan MURAM support
> [RFC,v2,06/12] soc/fman: Add the FMan MAC FLIB
> [RFC,v2,05/12] soc/fman: Add the FMan MAC FLIB headers
> [RFC,v2,04/12] soc/fman: Add the FMan port FLIB
> [RFC,v2,03/12] soc/fman: Add the FMan port FLIB headers
> [RFC,v2,02/12] soc/fman: Add the FMan FLIB
> [RFC,v2,01/12] soc/fman: Add the FMan FLIB headers
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=Igal.Liberman&state=*&q=RFC%2Cv2
> 
> These patches rely also on the Q/BMan drivers submitted by
> Emil Medve:
> 
> [RFC,v3,10/10] fsl_qman: Add HOTPLUG_CPU support
> [RFC,v3,09/10] fsl_bman: Add HOTPLUG_CPU support
> [RFC,v3,08/10] fsl_qman: Add debugfs support
> [RFC,v3,07/10] fsl_bman: Add debugfs support
> [RFC,v3,06/10] fsl_qman: Add self-tester
> [RFC,v3,05/10] fsl_bman: Add self-tester
> [RFC,v3,04/10] powerpc/mpc85xx: Add platform support for the Freescale DPAA QMan
> [RFC,v3,03/10] powerpc/mpc85xx: Add platform support for the Freescale DPAA BMan
> [RFC,v3,02/10] fsl_qman: Add drivers for the Freescale DPAA QMan
> [RFC,v3,01/10] fsl_bman: Add drivers for the Freescale DPAA BMan
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=Emil+Medve&state=*&q=RFC
> 

Hello Madalin,

Thank you very much for this summary that helps keeping an overview on the
current Freescale mainline DPAA effort (by the way, I am also very pleased to
see these patches getting to the mailing-lists, this is very important to us).

Now I would like to give all this a try on our P2041 board, the kmcoge4 for
which there is a DT in mainline. Could you please tell me on what kernel branch
these patches are based on ?

Best Regards

Valentin
