Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54ADE1A0274
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 14:48:32 +1000 (AEST)
Message-ID: <1442551699.19102.99.camel@freescale.com>
Subject: Re: [PATCH] PowerPC: Move Freescale device tree files into fsl folder
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>,
 <robh+dt@kernel.org>
Date: Thu, 17 Sep 2015 23:48:19 -0500
In-Reply-To: <1442548824-45849-1-git-send-email-hongtao.jia@freescale.com>
References: <1442548824-45849-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-09-18 at 12:00 +0800, Jia Hongtao wrote:
> It makes no sense that some Freescale device tree files are in fsl
> directory while some others not. This patch move Freescale device tree
> files into fsl folder. To do that the following two steps are made:
> - Move Freescale device tree files into fsl folder.
> - Update the include path in these files from "fsl/*.dtsi" to "*.dtsi".
> 
> Please add "fsl/" prefix when you make dtb using Makefile.

The existing arrangement is indeed a bit odd, but the real reason for this is 
the interaction with the preprocessor.  If a dtsi uses preprocessor 
directives, it needs to be included with #include rather than /include/, or 
else the dtsi won't be preprocessed.  However, if a dtsi is included with 
#include, and that dtsi is in fsl/ but the including dts isn't, any 
/include/s within the dtsi will not search that fsl/ because dtc doesn't 
realize that's the directory the content came from.

There was a desire to include <dt-bindings/thermal/thermal.h> from 
fsl/t1040si-post.dtsi.  In order to make everything work, we need to either 
move all relevant files to the same directory, or convert all /include/s in 
affected files to #include.

-Scott
