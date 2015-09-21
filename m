Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CA401A022F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:44:45 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:44:43 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 874B119D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:35:34 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8LMhUk7721228
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 15:43:30 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8LMiekN024680
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:44:41 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 21/30] cxlflash: Fix to prevent workq from accessing
 freed memory
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FFF745.8080802@redhat.com>
Date: Mon, 21 Sep 2015 17:44:40 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <B29886C1-4FB9-4ED9-B7F1-0836F20008AC@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439105-50148-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FFF745.8080802@redhat.com>
To: Tomas Henzl <thenzl@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 21, 2015, at 7:25 AM, Tomas Henzl <thenzl@redhat.com> wrote:
> On 16.9.2015 23:31, Matthew R. Ochs wrote:
>> The workq can process work in parallel with a remove event, leading
>> to a condition where the workq handler can access freed memory.
>> 
>> To remedy, the workq should be terminated prior to freeing memory. Move
>> the termination call earlier in remove and use cancel_work_sync() instead
>> of flush_work() as there is not a need to process any scheduled work when
>> shutting down.
>> 
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>> ---
>> drivers/scsi/cxlflash/main.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
>> index 1856a73..1625aea 100644
>> --- a/drivers/scsi/cxlflash/main.c
>> +++ b/drivers/scsi/cxlflash/main.c
>> @@ -736,12 +736,12 @@ static void cxlflash_remove(struct pci_dev *pdev)
>> 		scsi_remove_host(cfg->host);
>> 		/* Fall through */
>> 	case INIT_STATE_AFU:
>> +		cancel_work_sync(&cfg->work_q);
>> 		term_afu(cfg);
> 
> You disable irqs after a call to cancel_work_sync.
> That means a late int could trigger the workqueue again?
> Please disable irqs earlier - as described in Documentation/PCI/pci.txt

I'll change the order here such that the work is cancelled after
term_afu() is called.

-matt
