Return-Path: <timur.tabi@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by ozlabs.org (Postfix) with ESMTP id 1A955DE10D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:47:54 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so186028ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:47:52 -0700 (PDT)
Message-ID: <ed82fe3e0809251147t30743080v593d194eba731a7b@mail.gmail.com>
Date: Thu, 25 Sep 2008 13:47:52 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH v2] fsl-dma: allow Freescale Elo DMA driver to be compiled
	as a module
In-Reply-To: <20080925184020.GA5230@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1222293567-17694-1-git-send-email-timur@freescale.com>
	<2a27d3730809242354u4cc24b96yda3973bfc3ddac92@mail.gmail.com>
	<48DB9816.4020603@freescale.com>
	<20080925184020.GA5230@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	Li Yang <leoli@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 1:40 PM, Scott Wood <scottwood@freescale.com> wrote:

> If there's a dependency there, how will it work when this is built as a
> module?

There are no dependencies.  fsldma registers with the DMA engine,
which is always built in-kernel.  The DMA engine is what handles
linking DMA clients to DMA drivers. The DMA clients get a callback
whenever a DMA driver registers with the DMA engine.  If the DMA
driver is already registered when the client registers, then the
client will get a callback immediately after it registers.

I chose subsys_initcall() to increase the probability that fsldma is
already present when DMA clients are loaded/initialized and register.

-- 
Timur Tabi
Linux kernel developer at Freescale
