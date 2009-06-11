Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6CF15B7227
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 14:15:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADD9ADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 14:15:21 +1000 (EST)
Message-Id: <90AED712-28A1-4800-978C-125A887D0DA7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1242117363-14949-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 1/6] rapidio: add common mapping APIs for RapidIO memory
	access
Date: Wed, 10 Jun 2009 23:13:00 -0500
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
Cc: Zhang Wei <zw@zh-kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 12, 2009, at 3:35 AM, Li Yang wrote:

> Add the mapping functions used to support direct IO memory access of
> rapidIO.
>
> Signed-off-by: Zhang Wei <zw@zh-kernel.org>
> Signed-off-by: Li Yang <leoli@freescale.com>

Use inbnd/outbnd instead of inb/outb which make one think of byte  
level io accessors.

As I look at this I don't think this is the correct API.  I think we  
should be using the DMA mapping API to hide these details.  The  
concept of mapping like this seems to be more a function of FSL's  
Address translation/mapping unit (ATMU) than anything specific to the  
RIO bus standard.

> ---
> drivers/rapidio/rio.c   |   95 ++++++++++++++++++++++++++++++++++++++ 
> +++++++++
> include/linux/rio.h     |   25 ++++++++++++
> include/linux/rio_drv.h |   24 +++++++++---
> 3 files changed, 138 insertions(+), 6 deletions(-)

- k
