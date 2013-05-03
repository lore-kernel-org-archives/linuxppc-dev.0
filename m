Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B2822C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 23:52:28 +1000 (EST)
Date: Fri, 3 May 2013 15:52:23 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH 1/1] powerpc: mpc512x_dma: add support for data
 transfers between memory and i/o memory
Message-ID: <20130503155223.1eff1d9f@crub>
In-Reply-To: <CAF0T0X5cRMvoZKQQUkQHTLjbzz1xi_1pvUiywsKb5BGvyMGvpg@mail.gmail.com>
References: <1367407689-16252-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130502171452.GP1960@intel.com>
 <CAF0T0X7XBuL7a=8zwqMnLDB04-Tf=qhCLPZ4T29yNdN6mP5S2A@mail.gmail.com>
 <20130503085944.69ef751e@crub>
 <CAF0T0X5cRMvoZKQQUkQHTLjbzz1xi_1pvUiywsKb5BGvyMGvpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dan Williams <djbw@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Alexander,

On Fri, 3 May 2013 14:43:23 +0400
Alexander Popov <a13xp0p0v88@gmail.com> wrote:

> Hello Anatolij,
> 
> > Note that there is a patch for .device_prep_slave_sg() operation
> > for this driver as part of this series:
> > https://patchwork.kernel.org/patch/2368581/
> > https://patchwork.kernel.org/patch/2368591/
> Thanks, I haven't seen that patch.
> It's certainly what my SCLPC device driver needs
> (http://patchwork.ozlabs.org/patch/241010/).
> I will send the second version of it which uses .device_prep_slave_sg().
> 
> > maybe you can reuse and improve it.
> > Anatolij
> Should I propose my additions at https://patchwork.kernel.org/patch/2368591/ ?

Yes, I think so. I only used drivers new .device_prep_slave_sg()
for SDHC DMA channel transfers up to now. Adding support for other
peripherals would be good. With generic DMA DT bindings patch for
this driver you can use

    dmas = <&dma0 26>;
    dma-names = "rx-tx";

in your sclpc@10100 DT node and then
dma_request_slave_channel(&pdev->dev, "rx-tx") in the lpbfifo
driver.

Thanks,

Anatolij
