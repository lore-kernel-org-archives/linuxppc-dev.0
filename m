Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id 28F1367D77
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 05:08:10 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i16so1216244wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 12:08:09 -0700 (PDT)
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Date: Wed, 3 Aug 2005 00:26:30 +0300
References: <42EF9022.5050707@ru.mvista.com>
In-Reply-To: <42EF9022.5050707@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200508030026.31224.pantelis.antoniou@gmail.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
Reply-To: pantelis.antoniou@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 02 August 2005 18:24, Vitaly Bordug wrote:
> Kumar, Pantelis,
>
> This patch makes non-console UART work on both 8xx and 82xx. Various
> issues are resolved:
> - removed unnecessary STOP_TX commands in shutdown - no need to
> completely stop CPM TX and reinit BDs each time the port is closing;
> - when mem_addr has been allocated via dma_coherent_alloc, virt_to_bus
> on it will not tell the truth in most cases
> - SCC UART needs to wait several character times even after all the BDs
> have READY bit cleared
> - adds needed board-specific bits for 86xADS
>
> Tested on 8272ADS, 885ADS and 866ADS development boards.
> ---------------------------------
> Signed-off-by:  Vitaly Bordug <vbordug@ru.mvista.com>

Vitaly, this patch is clearly in conflict with mine.

Mind taking a look at my patch and include the changes I've made?

You'll only have to change the cpm2cpu & cpu2cpm functions...

I would also argue that the STOP_TX command is needed at shutdown, since
this is the canonical way serial ports operate in linux. Also you might want
to change the protocol running on an SCC port after shutdown.

The rest are fine...

Regards

Pantelis
