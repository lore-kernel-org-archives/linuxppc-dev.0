Return-Path: <dan.j.williams@intel.com>
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D5239140083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 10:30:04 +1000 (EST)
Received: by mail-vc0-f171.google.com with SMTP id lg15so8626937vcb.30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:30:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0c8d1963a25648f8a8f820bbc55afe4f@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1397202086-22489-1-git-send-email-xuelin.shi@freescale.com>
 <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
 <0c8d1963a25648f8a8f820bbc55afe4f@BL2PR03MB147.namprd03.prod.outlook.com>
Date: Mon, 14 Apr 2014 17:30:00 -0700
Message-ID: <CAPcyv4go1ghjD7fiEzwPJmcjRMBv7p0t7Sm9Ki=1Hu-0GKqoCQ@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
From: Dan Williams <dan.j.williams@intel.com>
To: Xuelin Shi <xuelin.shi@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harninder Rai <harninder.rai@freescale.com>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Naveen Burmi <NaveenBurmi@freescale.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 13, 2014 at 7:48 PM, Xuelin Shi <xuelin.shi@freescale.com> wrote:
> Hi Dan,
>
> fsl dma device and fsl raid device are two differenct devices that both provide async_memcpy
> capability, so I use !FSL_DMA to disable the fsl dma device.
>
> That's to say, either select fsldma device, either fsl raid device.
>

Right, but that's not what your proposed Kconfig dependency line does.

You want something like "depends on FSL_SOC && !(FSL_DMA || FSL_DMA=m)"

However, the more problematic option is ASYNC_TX_CHANNEL_SWITCH.  That
option is problematic for RAID, so I propose "depend on
!ASYNC_TX_CHANNEL_SWITCH" since that addresses both problems.
