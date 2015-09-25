Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BF291A0014
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 07:24:09 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Fri, 25 Sep 2015 15:24:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E38883E40030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 15:24:03 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8PLO37s6029632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 14:24:03 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8PLO2Fu028443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 15:24:03 -0600
Subject: Re: [PATCH v3 31/32] cxlflash: Fix to avoid corrupting adapter fops
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123851-17893-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Brian King <brking@linux.vnet.ibm.com>
Message-ID: <5605BB6F.1030905@linux.vnet.ibm.com>
Date: Fri, 25 Sep 2015 16:23:59 -0500
MIME-Version: 1.0
In-Reply-To: <1443123851-17893-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2015 02:44 PM, Matthew R. Ochs wrote:
> @@ -1293,8 +1291,8 @@ static int cxlflash_disk_attach(struct scsi_device *sdev,
> 
>  	int fd = -1;
> 
> -	/* On first attach set fileops */
> -	if (atomic_read(&cfg->num_user_contexts) == 0)
> +	/* On very first attach set fileops for adapter */
> +	if (cfg->cxl_fops.owner != THIS_MODULE)
>  		cfg->cxl_fops = cxlflash_cxl_fops;

Hmm... Why not just set this up once at probe time instead?

> 
>  	if (attach->num_interrupts > 4) {
> 


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
