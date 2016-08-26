Return-Path: <theidsieck@leenox.de>
Received: from mail.leenox.de (giles.leenox.de [5.9.156.120])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLBrM20nQzDqB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 17:05:07 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 26 Aug 2016 09:05:02 +0200
From: Tillmann Heidsieck <theidsieck@leenox.de>
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/fsl_pci: Size upper inbound window based on RAM
 size
In-Reply-To: <1472193505-13136-1-git-send-email-oss@buserror.net>
References: <1472193505-13136-1-git-send-email-oss@buserror.net>
Message-ID: <644493115e473879edacfbbb1df80ec2@mail.leenox.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

thanks for the patch! This one works for my setup:
T4240, 12GB Ram and Radeon E6760.

On 2016-08-26 08:38, Scott Wood wrote:
> This allows PCI devices that can only address (e.g.) 36 or 40 bit DMA 
> to
> use direct DMA, at the cost of not being able to DMA to non-RAM 
> addresses
> (this doesn't affect MSIs as there is a separate dedicated window for
> that) which we wouldn't have been able to do anyway if the RAM size 
> didn't
> trigger the creation of the second inbound window.
> 
> It also fixes an off-by-one error that set dma_direct_ops on PCI 
> devices
> whose dma mask could address all the space below the DMA offset
> (previously 40 bits), but not the window that starts at the DMA offset.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Cc: Tillmann Heidsieck <theidsieck@leenox.de>
> ---

Tested-by: Tillmann Heidsieck <theidsieck@leenox.de>
