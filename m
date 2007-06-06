Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 68555DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 05:55:27 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id v1so266854nzb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Jun 2007 12:55:26 -0700 (PDT)
Message-ID: <fa686aa40706061255w2e589980tf89f3ba763bb9f54@mail.gmail.com>
Date: Wed, 6 Jun 2007 13:55:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
In-Reply-To: <20070606190640.B7028900053@mail104-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
	<20070606190640.B7028900053@mail104-cpk.bigfish.com>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/6/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> > Why still have XILINX_EDK?  I thought you meant replace
> > XILINX_EDK with XILINX_DRIVERS.
>
> Yes, that's what I was suggesting.
> But I think that Andrei still wants to use XILINX_EDK to pull in the
> stuff in drivers/xilinx_common.
>
> # The Xilinx OS common code
> obj-$(CONFIG_XILINX_EDK) += xbasic_types.o xpacket_fifo_l_v2_00_a.o \
>                             xpacket_fifo_v2_00_a.o xversion.o \
>                             xdma_channel.o xdma_channel_sg.o
>
> Which you wouldn't want if you were able to build a kernel completely
> from 'non-edk' drivers.

Fair enough, but that's only an issue for vendor trees.  None of this
code will be going into mainline.  Any of it that does get into good
shape should probably go under drivers/misc, and have the drivers
select only the pieces that are needed (with finer-grain CONFIG_
items).  A blanked CONFIG_XILINX_EDK for random stuff is not a good
idea.

Cheers,
g.

>
> Steve
>
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
