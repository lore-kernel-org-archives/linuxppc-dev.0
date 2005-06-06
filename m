Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D641679E9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 00:27:45 +1000 (EST)
Message-ID: <42A4549B.3050601@am.sony.com>
Date: Mon, 06 Jun 2005 06:50:19 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <20050604005106.GB12513@gate.ebshome.net>
In-Reply-To: <20050604005106.GB12513@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
Cc: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [1/2] PM support for Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Fri, Jun 03, 2005 at 04:22:40PM -0700, Geoff Levand wrote:
> 
> [snip]
> 
> 
>>+	/* save current CPM */
>>+	cpm_save_er = mfdcr(DCRN_CPC0_ER);
>>+
>>+	/* save UIC0 enable registers */
>>+	uic_save_er = mfdcr(DCRN_UIC_ER(UIC0));
>>+
>>+#ifdef USE_ETHER_TO_RESUME
>>+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT|UIC0_UIC1NC_BIT);
>>+#else
>>+	/* mask UIC0 interrupts, except External Intr #5 */
>>+	mtdcr(DCRN_UIC_ER(UIC0), UIC0_EIR5_BIT);
>>+#endif
> 
> 
> Why UIC PM code is here and not in ppc4xx_pic.c? I don't think this is 
> the right place to mess with UIC registers.
> 

Yes, that is resonable.  Maybe something like ppc4xx_pic_suspend() 
and ppc4xx_pic_resume().

> 
> 
>>===================================================================
>>--- linux-2.6.12-bhpm.orig/arch/ppc/platforms/4xx/ibm440gp_sleep.S
> 
> 2005-06-01 08:52:49.947684744 -0700
> 
>>+++ linux-2.6.12-bhpm/arch/ppc/platforms/4xx/ibm440gp_sleep.S
> 
> 2005-06-03 16:15:07.000000000 -0700
> 
> I think it should be in arch/ppc/syslib not in arch/ppc/platforms/4xx.
> 

I was thinking the same...

I want to do some cleanup of the debugging code and reformat the text, 
then I'll post a new version with these changes.

-Geoff
