Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87A641A0676
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:34:06 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 13:33:53 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D3D726E8699
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 15:20:13 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TJSUrC62390314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 19:28:30 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TJSTkm002414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 15:28:30 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v4 08/32] cxlflash: Fix to avoid CXL services during EEH
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <87h9meuouw.fsf@gamma.ozlabs.ibm.com>
Date: Tue, 29 Sep 2015 14:28:28 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <84B83AB3-F812-416B-9B98-70F6A4EEC880@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443222852-9229-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87h9meuouw.fsf@gamma.ozlabs.ibm.com>
To: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 28, 2015, at 6:05 PM, Daniel Axtens <dja@axtens.net> wrote:
>=20
> You have two versions of check_state() below, which is a bit
> confusing. It looks like you've moved the function and also added the
> up/down of the read semaphore. I assume that's all that changed?

Correct.

It was originally moved to meet a dependency due to it being defined =
statically.

>=20
>>=20
>> /**
>> + * check_state() - checks and responds to the current adapter state
>> + * @cfg:	Internal structure associated with the host.
>> + *
>> + * This routine can block and should only be used on process =
context.
>> + * It assumes that the caller is an ioctl thread and holding the =
ioctl
>> + * read semaphore. This is temporarily let up across the wait to =
allow
>> + * for draining actively running ioctls. Also note that when waking =
up
>> + * from waiting in reset, the state is unknown and must be checked =
again
>> + * before proceeding.
>> + *
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int check_state(struct cxlflash_cfg *cfg)
>> +{
>> +	struct device *dev =3D &cfg->dev->dev;
>> +	int rc =3D 0;
>> +
>> +retry:
>> +	switch (cfg->state) {
>> +	case STATE_LIMBO:
>> +		dev_dbg(dev, "%s: Limbo state, going to wait...\n", =
__func__);
>> +		up_read(&cfg->ioctl_rwsem);
>> +		rc =3D wait_event_interruptible(cfg->limbo_waitq,
>> +					      cfg->state !=3D =
STATE_LIMBO);
>> +		down_read(&cfg->ioctl_rwsem);
>> +		if (unlikely(rc))
>> +			break;
>> +		goto retry;
>> +	case STATE_FAILTERM:
>> +		dev_dbg(dev, "%s: Failed/Terminating!\n", __func__);
>> +		rc =3D -ENODEV;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>> +/**
>>  * cxlflash_disk_attach() - attach a LUN to a context
>>  * @sdev:	SCSI device associated with LUN.
>>  * @attach:	Attach ioctl data structure.
>> @@ -1523,41 +1563,6 @@ err1:
>> }
>>=20
>> /**
>> - * check_state() - checks and responds to the current adapter state
>> - * @cfg:	Internal structure associated with the host.
>> - *
>> - * This routine can block and should only be used on process =
context.
>> - * Note that when waking up from waiting in limbo, the state is =
unknown
>> - * and must be checked again before proceeding.
>> - *
>> - * Return: 0 on success, -errno on failure
>> - */
>> -static int check_state(struct cxlflash_cfg *cfg)
>> -{
>> -	struct device *dev =3D &cfg->dev->dev;
>> -	int rc =3D 0;
>> -
>> -retry:
>> -	switch (cfg->state) {
>> -	case STATE_LIMBO:
>> -		dev_dbg(dev, "%s: Limbo, going to wait...\n", __func__);
>> -		rc =3D wait_event_interruptible(cfg->limbo_waitq,
>> -					      cfg->state !=3D =
STATE_LIMBO);
>> -		if (unlikely(rc))
>> -			break;
>> -		goto retry;
>> -	case STATE_FAILTERM:
>> -		dev_dbg(dev, "%s: Failed/Terminating!\n", __func__);
>> -		rc =3D -ENODEV;
>> -		break;
>> -	default:
>> -		break;
>> -	}
>> -
>> -	return rc;
>> -}
>> -
>> -/**
>>  * cxlflash_afu_recover() - initiates AFU recovery
>>  * @sdev:	SCSI device associated with LUN.
>>  * @recover:	Recover ioctl data structure.
>> @@ -1646,9 +1651,14 @@ retry_recover:
>> 	/* Test if in error state */
>> 	reg =3D readq_be(&afu->ctrl_map->mbox_r);
>> 	if (reg =3D=3D -1) {
>> -		dev_dbg(dev, "%s: MMIO read fail! Wait for =
recovery...\n",
>> -			__func__);
>> -		mutex_unlock(&ctxi->mutex);
>> +		dev_dbg(dev, "%s: MMIO fail, wait for recovery.\n", =
__func__);
>> +
>> +		/*
>> +		 * Before checking the state, put back the context =
obtained with
>> +		 * get_context() as it is no longer needed and sleep for =
a short
>> +		 * period of time (see prolog notes).
>> +		 */
>> +		put_context(ctxi);
>=20
> Is this needed for the drain to work? It looks like it fixes a
> refcounting bug in the function, but I'm not sure I understand how it
> interacts with the rest of this patch.

This was simply some "while I'm here" refactoring as the commit =
originally
included a change here. The main point of this change was to replace the
mutex_unlock() with put_context(), which is a wrapper around the =
unlocking
of the context's mutex.
>=20
> Anyway, the patch overall looks good to me, and makes your driver
> interact with CXL's EEH support in the way I intended when I wrote it.

Thanks for reviewing.
