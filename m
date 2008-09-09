Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E0BBDDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 17:59:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id m897wug0013601
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 07:58:56 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m897wuJ43444740
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 09:58:56 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m897wqZr021483
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 09:58:53 +0200
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: akpm@linux-foundation.org
Subject: Re: + ehea-fix-dlpar-memory-handling.patch added to -mm tree
Date: Tue, 9 Sep 2008 09:58:47 +0200
References: <200809082225.m88MPu89013383@imap1.linux-foundation.org>
In-Reply-To: <200809082225.m88MPu89013383@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200809090958.47358.hannes.hering@linux.vnet.ibm.com>
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

please consider the ehea-fix-dlpar-memory-handling.patch as critical bug fix,
as it fixes a potential firmware error causing the driver to get inoperable
when system memory is sparse. Therefore please include this fix into 2.6.27.

Regards

Hannes

On Tuesday 09 September 2008 00:25:56 you wrote:
> 
> The patch titled
>      ehea: fix DLPAR memory handling
> has been added to the -mm tree.  Its filename is
>      ehea-fix-dlpar-memory-handling.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: ehea: fix DLPAR memory handling
> From: Hannes Hering <hannes.hering@gmx.de>
> 
> The ehea busmap must be allocated only once in the first of many calls of the
> ehea_create_busmap_callback.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/net/ehea/ehea_qmr.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/net/ehea/ehea_qmr.c~ehea-fix-dlpar-memory-handling drivers/net/ehea/ehea_qmr.c
> --- a/drivers/net/ehea/ehea_qmr.c~ehea-fix-dlpar-memory-handling
> +++ a/drivers/net/ehea/ehea_qmr.c
> @@ -595,7 +595,8 @@ static int ehea_create_busmap_callback(u
>  	end_section = start_section + ((nr_pages * PAGE_SIZE) / EHEA_SECTSIZE);
>  	mr_len = *(unsigned long *)arg;
>  
> -	ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
> +	if (!ehea_bmap)
> +		ehea_bmap = kzalloc(sizeof(struct ehea_bmap), GFP_KERNEL);
>  	if (!ehea_bmap)
>  		return -ENOMEM;
>  
> _
> 
> Patches currently in -mm which might be from hannes.hering@gmx.de are
> 
> ehea-fix-dlpar-memory-handling.patch
> ehea-enable-dlpar-memory-remove.patch
>
