Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 322761007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 16:23:58 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] Correct offset_in_page mask bits in function
	edac_mc_handle_ce.
Date: Fri, 15 Jul 2011 06:21:24 +0000
Message-ID: <267A3B246C22C34A8E574051858E0770107372@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1310608902-14221-1-git-send-email-Shaohui.Xie@freescale.com>
	<20110714145042.9d2e88de.akpm@linux-foundation.org>
In-Reply-To: <20110714145042.9d2e88de.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	"djiang@mvista.com" <djiang@mvista.com>,
	"ptyser@xes-inc.com" <ptyser@xes-inc.com>,
	Jiang Kai-B18973 <B18973@freescale.com>,
	"dougthompson@xmission.com" <dougthompson@xmission.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: Andrew Morton [mailto:akpm@linux-foundation.org]
>Sent: Friday, July 15, 2011 5:51 AM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; Wood Scott-B07421;
>ptyser@xes-inc.com; djiang@mvista.com; dougthompson@xmission.com; Jiang
>Kai-B18973
>Subject: Re: [PATCH] Correct offset_in_page mask bits in function
>edac_mc_handle_ce.
>
>On Thu, 14 Jul 2011 10:01:42 +0800
>Shaohui Xie <Shaohui.Xie@freescale.com> wrote:
>
>> From: Kai.Jiang <Kai.Jiang@freescale.com>
>>
>> Parameter offset_in_page in function edac_mc_handle_ce should be
>> masked the higher bits above the page size, not the lower bits. The
>> original input sometimes causes crash.
>>
>> Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
>> ---
>>  drivers/edac/mpc85xx_edac.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> index 38ab8e2..b048a5f 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>> @@ -854,11 +854,11 @@ static void mpc85xx_mc_check(struct mem_ctl_info
>*mci)
>>  		mpc85xx_mc_printk(mci, KERN_ERR, "PFN out of range!\n");
>>
>>  	if (err_detect & DDR_EDE_SBE)
>> -		edac_mc_handle_ce(mci, pfn, err_addr & PAGE_MASK,
>> +		edac_mc_handle_ce(mci, pfn, err_addr & ~PAGE_MASK,
>>  				  syndrome, row_index, 0, mci->ctl_name);
>>
>>  	if (err_detect & DDR_EDE_MBE)
>> -		edac_mc_handle_ue(mci, pfn, err_addr & PAGE_MASK,
>> +		edac_mc_handle_ue(mci, pfn, err_addr & ~PAGE_MASK,
>>  				  row_index, mci->ctl_name);
>>
>>  	out_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DETECT, err_detect);
>
>The patch should have had your Signed-off-by:, as described in
>Documentation/SubmittingPatches.  I added your s-o-b to my copy - please
>ack this.
[Xie Shaohui] OK, thank you.

>
>From the description it appears to me that this fix should be backported
>into 2.6.39.x and earlier.  Do you agree?
[Xie Shaohui] Actually this patch was created based on 2.6.32, it can be ap=
plied=20
to 2.6.39 and 3.0 without any change.

>
>The way to indicate this intention is to add "Cc: <stable@kernel.org>"
>to the changelog.  I added that tag to my copy of this patch.

[Xie Shaohui] OK, thank you.


Best Regards,=20
Shaohui Xie
