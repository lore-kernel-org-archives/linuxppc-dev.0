Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D53EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803B5218FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 20:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJOdstN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803B5218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LNCh2KzKzDqxD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 07:10:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rJOdstN+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="rJOdstN+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LN961VQgzDqwy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 07:07:54 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F036D218FD;
 Thu, 20 Dec 2018 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545336472;
 bh=5IJq36Mnqum9AvJT9vqPPi+IUGmFL1wkTL6Hzxs5Mkk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rJOdstN+nCAw+WU2+WNMgkx/Pzu9voi+dbJJSyjxDYnb8T1Zl7rC9J4L/YxQS4a1t
 MU/R0AMcCBWc4rRRCjZOH8Uh5af2xOHYwud3tH7MZBd5FWth2zJEBeEEUt3GqCWXCm
 9cbnLvM96oWX+kX7d9+LSKtYH5jdD/ekssAIkasI=
Date: Thu, 20 Dec 2018 14:07:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI/IOV: provide flag to skip VF scanning
Message-ID: <20181220200750.GF183878@google.com>
References: <20181217173546.GA4106@infradead.org>
 <20181218101650.23089-1-sebott@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218101650.23089-1-sebott@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sebastian,

On Tue, Dec 18, 2018 at 11:16:49AM +0100, Sebastian Ott wrote:
> Provide a flag to skip scanning for new VFs after SRIOV enablement.
> This can be set by implementations for which the VFs are already
> reported by other means.
> 
> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> ---
>  drivers/pci/iov.c   | 48 ++++++++++++++++++++++++++++++++++++------------
>  include/linux/pci.h |  1 +
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9616eca3182f..3aa115ed3a65 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -252,6 +252,27 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> +static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
> +{
> +	unsigned int i;
> +	int rc;
> +
> +	if (dev->no_vf_scan)
> +		return 0;
> +
> +	for (i = 0; i < num_vfs; i++) {
> +		rc = pci_iov_add_virtfn(dev, i);
> +		if (rc)
> +			goto failed;
> +	}
> +	return 0;
> +failed:
> +	while (i--)
> +		pci_iov_remove_virtfn(dev, i);
> +
> +	return rc;
> +}

I think the strategy is fine, but can you restructure the patches
like this:

  1) Factor out sriov_add_vfs() and sriov_dev_vfs().  This makes no
     functional change at all.

  2) Add dev->no_vf_scan, set it in the s390 pcibios_add_device(), and
     test it in sriov_add_vfs(), and sriov_del_vfs().

I think both pieces will be easier to review that way.

>  static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  {
>  	int rc;
> @@ -337,21 +358,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	msleep(100);
>  	pci_cfg_access_unlock(dev);
>  
> -	for (i = 0; i < initial; i++) {
> -		rc = pci_iov_add_virtfn(dev, i);
> -		if (rc)
> -			goto failed;
> -	}
> +	rc = sriov_add_vfs(dev, initial);
> +	if (rc)
> +		goto err_pcibios;
>  
>  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
>  	iov->num_VFs = nr_virtfn;
>  
>  	return 0;
>  
> -failed:
> -	while (i--)
> -		pci_iov_remove_virtfn(dev, i);
> -
>  err_pcibios:
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
> @@ -368,17 +383,26 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	return rc;
>  }
>  
> -static void sriov_disable(struct pci_dev *dev)
> +static void sriov_del_vfs(struct pci_dev *dev)
>  {
> -	int i;
>  	struct pci_sriov *iov = dev->sriov;
> +	int i;
>  
> -	if (!iov->num_VFs)
> +	if (dev->no_vf_scan)
>  		return;
>  
>  	for (i = 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
> +}
> +
> +static void sriov_disable(struct pci_dev *dev)
> +{
> +	struct pci_sriov *iov = dev->sriov;
> +
> +	if (!iov->num_VFs)
> +		return;
>  
> +	sriov_del_vfs(dev);
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..f70b9ccd3e86 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -405,6 +405,7 @@ struct pci_dev {
>  	unsigned int	non_compliant_bars:1;	/* Broken BARs; ignore them */
>  	unsigned int	is_probed:1;		/* Device probing in progress */
>  	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
> +	unsigned int	no_vf_scan:1;		/* Don't scan for VF's after VF enablement */
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> -- 
> 2.13.4
> 
