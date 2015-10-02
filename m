Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 100221A015B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 10:56:42 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so90404084pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2015 17:56:40 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 18/34] cxlflash: Fix AFU version access/storage and add
 check
In-Reply-To: <1443715012-18236-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1443714773-9176-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443715012-18236-1-git-send-email-mrochs@linux.vnet.ibm.com>
Date: Fri, 02 Oct 2015 10:56:35 +1000
Message-ID: <87h9maay0s.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

> The AFU version is stored as a non-terminated string of bytes within
> a 64-bit little-endian register. Presently the value is read directly
> (no MMIO accessor) and is stored in a buffer that is not big enough
> to contain a NULL terminator. Additionally the version obtained is not
> evaluated against a known value to prevent usage with unsupported AFUs.
> All of these deficiencies can lead to a variety of problems.
>
> +	if ((afu->interface_version + 1) == 0) {
> +		pr_err("Back level AFU, please upgrade. AFU version %s "
> +		       "interface version 0x%llx\n", afu->version,
> +		       afu->interface_version);
> +		rc = -EINVAL;
> +		goto err1;

I'm confused by this if statement. If afu->interface_version + 1 == 0,
and interface_version is a 64bit unsigned int, that would mean that
afu->interface_version was 0xFFFF FFFF FFFF FFFF.

Are you trying to check against all Fs? Is that value significant in the
hardware?

Regards,
Daniel



> +	} else
> +		pr_debug("%s: afu version %s, interface version 0x%llX\n",
> +			 __func__, afu->version, afu->interface_version);
>  
>  	rc = start_afu(cfg);
>  	if (rc) {
> diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
> index 63bf394..8425d1a 100644
> --- a/drivers/scsi/cxlflash/sislite.h
> +++ b/drivers/scsi/cxlflash/sislite.h
> @@ -340,7 +340,7 @@ struct sisl_global_regs {
>  #define SISL_AFUCONF_MBOX_CLR_READ     0x0010ULL
>  	__be64 afu_config;
>  	__be64 rsvd[0xf8];
> -	__be64 afu_version;
> +	__le64 afu_version;
>  	__be64 interface_version;
>  };
>  
> -- 
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
