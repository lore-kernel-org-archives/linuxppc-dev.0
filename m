Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F177BDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 14:25:34 +1000 (EST)
Subject: Re: ide pmac breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200807302111.54514.bzolnier@gmail.com>
References: <1217208596.11188.144.camel@pasglop>
	<200807292126.12238.bzolnier@gmail.com>
	<1217401052.11188.318.camel@pasglop>
	<200807302111.54514.bzolnier@gmail.com>
Content-Type: text/plain
Date: Thu, 31 Jul 2008 14:25:22 +1000
Message-Id: <1217478322.11188.410.camel@pasglop>
Mime-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Is it actually caused by additional reference counting on drive->gendev?
> IOW if you reverse the patch below instead of applying the previous fix
> do things work OK again?
> 
> > Note that there shouldn't be anything fundamentally different from
> > ide-pmac here vs. something like pcmcia IDE cards... do you have one of
> > these to test with ?
> 
> Nope and I really don't intend to have one.  I count on other people
> to take some care of support for host drivers that they maintain/use. ;)

Reverting the patch below does the job. Thanks.

Ben.

> Thanks,
> Bart
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 4e73aee..8f253e5 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -57,23 +57,29 @@ static DEFINE_MUTEX(idecd_ref_mutex);
>  #define ide_cd_g(disk) \
>  	container_of((disk)->private_data, struct cdrom_info, driver)
>  
> +static void ide_cd_release(struct kref *);
> +
>  static struct cdrom_info *ide_cd_get(struct gendisk *disk)
>  {
>  	struct cdrom_info *cd = NULL;
>  
>  	mutex_lock(&idecd_ref_mutex);
>  	cd = ide_cd_g(disk);
> -	if (cd)
> +	if (cd) {
>  		kref_get(&cd->kref);
> +		if (ide_device_get(cd->drive)) {
> +			kref_put(&cd->kref, ide_cd_release);
> +			cd = NULL;
> +		}
> +	}
>  	mutex_unlock(&idecd_ref_mutex);
>  	return cd;
>  }
>  
> -static void ide_cd_release(struct kref *);
> -
>  static void ide_cd_put(struct cdrom_info *cd)
>  {
>  	mutex_lock(&idecd_ref_mutex);
> +	ide_device_put(cd->drive);
>  	kref_put(&cd->kref, ide_cd_release);
>  	mutex_unlock(&idecd_ref_mutex);
>  }
