Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 576371A1F58
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 12:53:12 +1000 (AEST)
Message-ID: <1441594391.12945.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] cxl: abort cxl_pci_enable_device_hook() if PCI
 channel is offline
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au1.ibm.com,
 dja@axtens.net
Date: Mon, 07 Sep 2015 12:53:11 +1000
In-Reply-To: <1441587178-5581-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1441587178-5581-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-07 at 10:52 +1000, Andrew Donnellan wrote:
> cxl_pci_enable_device_hook() is called when attempting to enable an AFU
> sitting on a vPHB. At present, the state of the underlying CXL card's PCI
> channel is only checked when it calls cxl_afu_check_and_enable() at the
> very end, after it has already set DMA options and initialised a default
> context.
> 
> Check the CXL card's link status before setting DMA options or initialising
> a default context. If the link is down, print a warning and return
> immediately.

Is this a fix targetting 4.3 (current release) and/or stable, or something for
next?

cheers
