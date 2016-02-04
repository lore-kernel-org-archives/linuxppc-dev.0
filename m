Return-Path: <pku.leo@gmail.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com
 [IPv6:2a00:1450:400c:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B30E81A0220
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 10:25:02 +1100 (AEDT)
Received: by mail-wm0-x22e.google.com with SMTP id p63so4370865wmp.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 15:25:02 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1452251929-18368-1-git-send-email-raghav@freescale.com>
References: <1452251929-18368-1-git-send-email-raghav@freescale.com>
Date: Thu, 4 Feb 2016 17:24:59 -0600
Message-ID: <CADRPPNRjdWcqdALo_AW-k=0pYnkbd69nHyLBJHr66r9o6oaEZw@mail.gmail.com>
Subject: Re: [PATCH][v2] drivers/memory: Add deep sleep support for IFC
From: Li Yang <leoli@freescale.com>
To: Raghav Dogra <raghav@freescale.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, oss@buserror.net,
 prabhakar.kushwaha@nxp.com, Prabhakar Kushwaha <prabhakar@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 8, 2016 at 5:18 AM, Raghav Dogra <raghav@freescale.com> wrote:
> Add support of suspend, resume function to support deep sleep.
> Also make sure of SRAM initialization  during resume.
>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> Signed-off-by: Raghav Dogra <raghav@freescale.com>
> ---
> Changes for v2: Copying only the correct registers while resume.
> Based on git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> branch "next"
>
>  drivers/memory/fsl_ifc.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl_ifc.h  |   6 ++
>  2 files changed, 169 insertions(+)
>
{snip}
> +               ifc_out32(ncfgr | IFC_NAND_SRAM_INIT_EN,
> +                                       &ifc->ifc_nand.ncfgr);
> +               /* wait for  SRAM_INIT bit to be clear or timeout */
> +               status = spin_event_timeout(

This spin_event_timeout() API is only defined by powerpc and is not
supposed to be used in a generic driver.  How did you pass the build
on arm/arm64?

Regards,
Leo
