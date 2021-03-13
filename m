Return-Path: <SRS0=FWXi=IL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 09:18:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B651064ED7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 09:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B651064ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyHCr5mGmz3dKM
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 20:18:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyHCT3fGSz3cG9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Mar 2021 20:17:56 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF3D5ABD7;
 Sat, 13 Mar 2021 09:17:52 +0000 (UTC)
Date: Sat, 13 Mar 2021 10:17:51 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] rpadlpar: fix potential drc_name corruption in store
 functions
Message-ID: <20210313091751.GM6564@kitsune.suse.cz>
References: <20210310223021.423155-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210310223021.423155-1-tyreld@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, mmc@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 10, 2021 at 04:30:21PM -0600, Tyrel Datwyler wrote:
> Both add_slot_store() and remove_slot_store() try to fix up the drc_name
> copied from the store buffer by placing a NULL terminator at nbyte + 1
> or in place of a '\n' if present. However, the static buffer that we
> copy the drc_name data into is not zeored and can contain anything past
> the n-th byte. This is problematic if a '\n' byte appears in that buffer
> after nbytes and the string copied into the store buffer was not NULL
> terminated to start with as the strchr() search for a '\n' byte will mark
> this incorrectly as the end of the drc_name string resulting in a drc_name
> string that contains garbage data after the n-th byte. The following
> debugging shows an example of the drmgr utility writing "PHB 4543" to
> the add_slot sysfs attribute, but add_slot_store logging a corrupted
> string value.
> 
> [135823.702864] drmgr: drmgr: -c phb -a -s PHB 4543 -d 1
> [135823.702879] add_slot_store: drc_name = PHB 4543°|<82>!, rc = -19
> 
> Fix this by NULL terminating the string when we copy it into our static
> buffer by coping nbytes + 1 of data from the store buffer. The code has
Why is it OK to copy nbytes + 1 and why is it expected that the buffer
contains a nul after the content?

Isn't it much saner to just nul terminate the string after copying?

diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
index cdbfa5df3a51..cfbad67447da 100644
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -35,11 +35,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
+	&drc_name[nbytes] = '\0';
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_add_slot(drc_name);
 	if (rc)
@@ -66,11 +66,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
+	&drc_name[nbytes] = '\0';
 
 	end = strchr(drc_name, '\n');
-	if (!end)
-		end = &drc_name[nbytes];
-	*end = '\0';
+	if (end)
+		*end = '\0';
 
 	rc = dlpar_remove_slot(drc_name);
 	if (rc)

Thanks

Michal

> already made sure that nbytes is not >= MAX_DRC_NAME_LEN and the store
> buffer is guaranteed to be zeroed beyond the nth-byte of data copied
> from the user. Further, since the string is now NULL terminated the code
> only needs to change '\n' to '\0' when present.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/pci/hotplug/rpadlpar_sysfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
> index cdbfa5df3a51..375087921284 100644
> --- a/drivers/pci/hotplug/rpadlpar_sysfs.c
> +++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
> @@ -34,12 +34,11 @@ static ssize_t add_slot_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	if (nbytes >= MAX_DRC_NAME_LEN)
>  		return 0;
>  
> -	memcpy(drc_name, buf, nbytes);
> +	memcpy(drc_name, buf, nbytes + 1);
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_add_slot(drc_name);
>  	if (rc)
> @@ -65,12 +64,11 @@ static ssize_t remove_slot_store(struct kobject *kobj,
>  	if (nbytes >= MAX_DRC_NAME_LEN)
>  		return 0;
>  
> -	memcpy(drc_name, buf, nbytes);
> +	memcpy(drc_name, buf, nbytes + 1);
>  
>  	end = strchr(drc_name, '\n');
> -	if (!end)
> -		end = &drc_name[nbytes];
> -	*end = '\0';
> +	if (end)
> +		*end = '\0';
>  
>  	rc = dlpar_remove_slot(drc_name);
>  	if (rc)
> -- 
> 2.27.0
> 
