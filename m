Return-Path: <James.Bottomley@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D410B6EDD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 02:43:51 +1100 (EST)
Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
From: James Bottomley <James.Bottomley@suse.de>
To: Pravin Bathija <pbathija@amcc.com>
In-Reply-To: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
References: <1259805106-23636-1-git-send-email-pbathija@amcc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Dec 2009 09:43:38 -0600
Message-Id: <1260459818.2457.77.camel@mulgrave.site>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Eric.Moore@lsi.com, linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-02 at 17:51 -0800, Pravin Bathija wrote:
> Powerpc 44x uses 36 bit real address while the real address defined
>     in MPT Fusion driver is of type 32 bit. This causes ioremap to fail and driver
>     fails to initialize. This fix changes the data types representing the real
>     address from unsigned long 32-bit types to resource_size_t which is 64-bit. The
>     driver has been tested, the disks get discovered correctly and can do IO.
> 
> Signed-off-by: Pravin Bathija <pbathija@amcc.com>
> Acked-by: Feng Kan <fkan@amcc.com>
> Acked-by: Fushen Chen <fchen@amcc.com>
> Acked-by: Loc Ho <lho@amcc.com>
> Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
> Acked-by: Victor Gallardo <vgallardo@amcc.com>
> ---
>  drivers/message/fusion/mptbase.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index 5d496a9..9f14a60 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -1511,7 +1511,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
>  {
>  	u8		__iomem *mem;
>  	int		 ii;
> -	unsigned long	 mem_phys;
> +	resource_size_t	 mem_phys;

You never actually compiled this, did you?

drivers/message/fusion/mptbase.c: In function 'mpt_mapresources':
drivers/message/fusion/mptbase.c:1680: warning: format '%lx' expects type 'long unsigned int', but argument 4 has type 'resource_size_t'

I'll just fold the fix in

James

---

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 162923f..85bc6a6 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1677,8 +1677,8 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 		return -EINVAL;
 	}
 	ioc->memmap = mem;
-	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem = %p, mem_phys = %lx\n",
-	    ioc->name, mem, mem_phys));
+	dinitprintk(ioc, printk(MYIOC_s_INFO_FMT "mem = %p, mem_phys = %llx\n",
+	    ioc->name, mem, (unsigned long long)mem_phys));
 
 	ioc->mem_phys = mem_phys;
 	ioc->chip = (SYSIF_REGS __iomem *)mem;
