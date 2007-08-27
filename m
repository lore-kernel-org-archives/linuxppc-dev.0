Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80908DDF0E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 03:50:51 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.23-rc3 broken on G5
References: <jelkccftt6.fsf@sykes.suse.de>
	<18116.52843.212978.281399@cargo.ozlabs.ibm.com>
	<jefy2j6qtq.fsf@sykes.suse.de>
	<18118.41979.148016.177427@cargo.ozlabs.ibm.com>
	<jey7g9i3qk.fsf@sykes.suse.de>
	<18119.42120.893384.555002@cargo.ozlabs.ibm.com>
	<jetzqvk9of.fsf@sykes.suse.de>
	<18126.6446.158988.391247@cargo.ozlabs.ibm.com>
Date: Mon, 27 Aug 2007 19:50:41 +0200
In-Reply-To: <18126.6446.158988.391247@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri\, 24 Aug 2007 09\:33\:02 +1000")
Message-ID: <jewsvgvpce.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index a73d2d7..1ca87eb 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -89,7 +89,7 @@ void slb_flush_and_rebolt(void)
>  	vflags = SLB_VSID_KERNEL | vmalloc_llp;
>  
>  	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
> -	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET) {
> +	if ((ksp_esid_data & ESID_MASK) <= PAGE_OFFSET) {
>  		ksp_esid_data &= ~SLB_ESID_V;
>  		slb_shadow_clear(2);
>  	} else {
>

Thanks, this looks good.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
