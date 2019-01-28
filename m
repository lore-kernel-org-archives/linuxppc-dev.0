Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336EC282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 08:44:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9603421736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 08:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9603421736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p38d4zT5zDq5d
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 19:44:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p36p6DljzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 19:42:58 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0S8f5PZ057390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 03:42:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q9x3h119u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 03:42:56 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.ibm.com>;
 Mon, 28 Jan 2019 08:42:54 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 28 Jan 2019 08:42:53 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0S8gpZq53674068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Jan 2019 08:42:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FAD24C046;
 Mon, 28 Jan 2019 08:42:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E224E4C040;
 Mon, 28 Jan 2019 08:42:50 +0000 (GMT)
Received: from [9.145.43.137] (unknown [9.145.43.137])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 28 Jan 2019 08:42:50 +0000 (GMT)
Subject: Re: [PATCH v2] cxl: Wrap iterations over afu slices inside
 'afu_list_lock'
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20190126114603.29278-1-vaibhav@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 28 Jan 2019 09:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126114603.29278-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012808-0020-0000-0000-0000030C4959
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012808-0021-0000-0000-0000215D959F
Message-Id: <0526a0f3-8c3f-714c-baf1-fde4a34397ce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-28_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280072
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
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Vaibhav,

2 comments below (one of which I missed on the previous iteration, sorry).


Le 26/01/2019 à 12:46, Vaibhav Jain a écrit :
> Within cxl module, iteration over array 'adapter->slices' may be racy
> at few points as it might be simultaneously read during an EEH and its
> contents being set to NULL while driver is being unloaded or unbound
> from the adapter. This might result in a NULL pointer to 'struct afu'
> being de-referenced during an EEH thereby causing a kernel oops.
> 
> This patch fixes this by making sure that all access to the array
> 'adapter->slices' is wrapped within the context of spin-lock
> 'adapter->afu_list_lock'.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v2:
> * Fixed a wrong comparison of non-null pointer [Fred]
> * Moved a call to cxl_vphb_error_detected() within a branch that
>    checks for not null AFU pointer in 'adapter->slices' [Fred]
> * Removed a misleading comment in code.
> ---
>   drivers/misc/cxl/guest.c |  2 ++
>   drivers/misc/cxl/pci.c   | 43 ++++++++++++++++++++++++++++------------
>   2 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index 5d28d9e454f5..08f4a512afad 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -267,6 +267,7 @@ static int guest_reset(struct cxl *adapter)
>   	int i, rc;
>   
>   	pr_devel("Adapter reset request\n");
> +	spin_lock(&adapter->afu_list_lock);
>   	for (i = 0; i < adapter->slices; i++) {
>   		if ((afu = adapter->afu[i])) {
>   			pci_error_handlers(afu, CXL_ERROR_DETECTED_EVENT,
> @@ -283,6 +284,7 @@ static int guest_reset(struct cxl *adapter)
>   			pci_error_handlers(afu, CXL_RESUME_EVENT, 0);
>   		}
>   	}
> +	spin_unlock(&adapter->afu_list_lock);
>   	return rc;
>   }
>   
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index c79ba1c699ad..ca968a889425 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1805,7 +1805,7 @@ static pci_ers_result_t cxl_vphb_error_detected(struct cxl_afu *afu,
>   	/* There should only be one entry, but go through the list
>   	 * anyway
>   	 */
> -	if (afu->phb == NULL)
> +	if (afu == NULL || afu->phb == NULL)
>   		return result;
>   
>   	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> @@ -1832,7 +1832,8 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   {
>   	struct cxl *adapter = pci_get_drvdata(pdev);
>   	struct cxl_afu *afu;
> -	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET, afu_result;
> +	pci_ers_result_t result = PCI_ERS_RESULT_NEED_RESET;
> +	pci_ers_result_t afu_result = PCI_ERS_RESULT_NEED_RESET;
>   	int i;
>   
>   	/* At this point, we could still have an interrupt pending.
> @@ -1843,6 +1844,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   
>   	/* If we're permanently dead, give up. */
>   	if (state == pci_channel_io_perm_failure) {
> +		spin_lock(&adapter->afu_list_lock);
>   		for (i = 0; i < adapter->slices; i++) {
>   			afu = adapter->afu[i];
>   			/*
> @@ -1851,6 +1853,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   			 */
>   			cxl_vphb_error_detected(afu, state);
>   		}
> +		spin_unlock(&adapter->afu_list_lock);
>   		return PCI_ERS_RESULT_DISCONNECT;
>   	}
>   
> @@ -1932,14 +1935,19 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   	 *     * In slot_reset, free the old resources and allocate new ones.
>   	 *     * In resume, clear the flag to allow things to start.
>   	 */
> +
> +	/* Make sure no one else changes the afu list */
> +	spin_lock(&adapter->afu_list_lock);
> +
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
>   
> -		afu_result = cxl_vphb_error_detected(afu, state);
> -
> -		cxl_context_detach_all(afu);
> -		cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> -		pci_deconfigure_afu(afu);
> +		if (afu != NULL) {
> +			afu_result = cxl_vphb_error_detected(afu, state);
> +			cxl_context_detach_all(afu);
> +			cxl_ops->afu_deactivate_mode(afu, afu->current_mode);
> +			pci_deconfigure_afu(afu);
> +		}
>   
>   		/* Disconnect trumps all, NONE trumps NEED_RESET */
>   		if (afu_result == PCI_ERS_RESULT_DISCONNECT)


Thanks for moving the call to cxl_vphb_error_detected(), but now, the 
"if (afu_result == PCI_ERS_RESULT_DISCONNECT)" test looks like it should 
also be part of the "if (afu != NULL)" statement (and then you wouldn't 
have hit the warning about uninitialized afu_result). Current code would 
work, but looks awkward since there's no need to check afu_result at 
each iteration if afu is NULL.



> @@ -1948,6 +1956,7 @@ static pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>   			 (result == PCI_ERS_RESULT_NEED_RESET))
>   			result = PCI_ERS_RESULT_NONE;
>   	}
> +	spin_unlock(&adapter->afu_list_lock);
>   
>   	/* should take the context lock here */
>   	if (cxl_adapter_context_lock(adapter) != 0)
> @@ -1980,14 +1989,15 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
>   	 */
>   	cxl_adapter_context_unlock(adapter);
>   
> +	spin_lock(&adapter->afu_list_lock);
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
>   

We're missing here:
if (afu == NULL)
	continue;

Not introduced with this patch, but since you're fixing a few similar 
cases...

Thanks,

   Fred


>   		if (pci_configure_afu(afu, adapter, pdev))
> -			goto err;
> +			goto err_unlock;
>   
>   		if (cxl_afu_select_best_mode(afu))
> -			goto err;
> +			goto err_unlock;
>   
>   		if (afu->phb == NULL)
>   			continue;
> @@ -1999,16 +2009,16 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
>   			ctx = cxl_get_context(afu_dev);
>   
>   			if (ctx && cxl_release_context(ctx))
> -				goto err;
> +				goto err_unlock;
>   
>   			ctx = cxl_dev_context_init(afu_dev);
>   			if (IS_ERR(ctx))
> -				goto err;
> +				goto err_unlock;
>   
>   			afu_dev->dev.archdata.cxl_ctx = ctx;
>   
>   			if (cxl_ops->afu_check_and_enable(afu))
> -				goto err;
> +				goto err_unlock;
>   
>   			afu_dev->error_state = pci_channel_io_normal;
>   
> @@ -2029,8 +2039,13 @@ static pci_ers_result_t cxl_pci_slot_reset(struct pci_dev *pdev)
>   				result = PCI_ERS_RESULT_DISCONNECT;
>   		}
>   	}
> +
> +	spin_unlock(&adapter->afu_list_lock);
>   	return result;
>   
> +err_unlock:
> +	spin_unlock(&adapter->afu_list_lock);
> +
>   err:
>   	/* All the bits that happen in both error_detected and cxl_remove
>   	 * should be idempotent, so we don't need to worry about leaving a mix
> @@ -2051,10 +2066,11 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   	 * This is not the place to be checking if everything came back up
>   	 * properly, because there's no return value: do that in slot_reset.
>   	 */
> +	spin_lock(&adapter->afu_list_lock);
>   	for (i = 0; i < adapter->slices; i++) {
>   		afu = adapter->afu[i];
>   
> -		if (afu->phb == NULL)
> +		if (afu == NULL || afu->phb == NULL)
>   			continue;
>   
>   		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> @@ -2063,6 +2079,7 @@ static void cxl_pci_resume(struct pci_dev *pdev)
>   				afu_dev->driver->err_handler->resume(afu_dev);
>   		}
>   	}
> +	spin_unlock(&adapter->afu_list_lock);
>   }
>   
>   static const struct pci_error_handlers cxl_err_handler = {
> 

