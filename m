Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id F0EAF140081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 05:46:59 +1100 (EST)
Message-ID: <533320A0.8010507@tabi.org>
Date: Wed, 26 Mar 2014 13:46:56 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Jason Jin <Jason.Jin@freescale.com>
Subject: Re: [PATCH 1/2] video/fsl: make the diu driver work without platform
 hooks
References: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1395855704-19908-1-git-send-email-Jason.Jin@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: b07421@freescale.com, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, r58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2014 12:41 PM, Jason Jin wrote:
> This board sepecific initialization mechanism is not feasible i
> for corenet platform as the corenet platform file is a
> abstraction of serveral platforms.

You can't make it 100% abstract.  The DIU driver requires some sort of 
board support.  I think you can make a generic platform file for the DIU.

> However, the DIU is already initialized in u-boot and we can
> rely on the settings in u-boot for corenet platform,

I don't like that at all.

> the only
> issue is that when DIU wake up from the deepsleep, some of the
> board specific initialization will lost, such as the pixel clock
> setting.

That is a BIG issue.  This is why we have a platform file -- to handle 
the platform issues.
