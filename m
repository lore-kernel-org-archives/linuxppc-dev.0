Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D86E1B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 20:29:48 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FF8FDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 20:29:47 +1000 (EST)
Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pbathija@amcc.com
In-Reply-To: <1252455333-9925-1-git-send-email-pbathija@amcc.com>
References: <1252455333-9925-1-git-send-email-pbathija@amcc.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 20:29:38 +1000
Message-Id: <1253010578.8375.220.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index 5d496a9..d5b0f15 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -1510,11 +1510,12 @@ static int
>  mpt_mapresources(MPT_ADAPTER *ioc)
>  {
>  	u8		__iomem *mem;
> +	u8		__iomem *port;
>  	int		 ii;
> -	unsigned long	 mem_phys;
> -	unsigned long	 port;
> -	u32		 msize;
> -	u32		 psize;
> +	phys_addr_t	 mem_phys;
> +	phys_addr_t	 port_phys;
> +	resource_size_t	 msize;
> +	resource_size_t	 psize;

Is phys_addr_t defined for all archs nowadays ? Why not use
resource_size_t for everything ? resource_size_t is a bit of a misnomer,
it's not a type supposed to reference a "size" but really a physical
address (or a size)... it's been called resource_size_t I believe
because it's "sized" appropriately for holding a physical address.

Cheers,
Ben.
