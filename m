Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B3E01A0E8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 00:45:43 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from
 fdt in sdhci-pltm.c
Date: Wed, 29 Apr 2015 16:45:30 +0200
Message-ID: <2511590.IBzkZm5Ibi@wuerfel>
In-Reply-To: <CAOHikRD6enDS2VyYH4Nz_+wz_m2v-61QyBDLixZxm-Y0qYtojA@mail.gmail.com>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com>
 <17258495.kJWOqBBcrn@wuerfel>
 <CAOHikRD6enDS2VyYH4Nz_+wz_m2v-61QyBDLixZxm-Y0qYtojA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Langsdorf <mlangsdo@redhat.com>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 29 April 2015 19:55:53 Suman Tripathi wrote:
> >
> > The above assumes that the limitation is enforced by the bus (e.g. an
> > AHB bus can only do 32-bit DMA). It would be a little different if you
> > have a 64-bit AXI bus and the Arasan device itself is limited to 32-bit
> > independent of the width of the bus it is connected to. Can you find out
> > which of these two cases you have?
> >
> 
> We have 64 bit AXI and Arasan device or controller is 32 bit . So there is
> 64 bit AXI to 32 bit AHB translation.

Please be very specific here. If this is an AHB based MMC controller, you
should model that AHB bus in DT, with the 32-bit dma-ranges.

However, if this is an AXI based MMC controller that is limited to 32-bit
DMA, the correct change would be to make ensure that the driver never
asks for a 64-bit DMA mask with this hardware.

Both will result in a 32-bit dma mask being used, and high DMA handled
through the block bounce code or swiotlb, but it's best to ensure that
the DT representation matches the actual hardware as closely as possible,
so it keeps working when you change something in a future chip.

	Arnd
