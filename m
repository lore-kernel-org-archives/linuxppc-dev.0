Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9052F2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 12:35:52 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 6 Aug 2013 22:35:48 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 2CC0BC90045
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 22:34:25 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r772YQTT164442
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 22:34:26 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r772YPLk031295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Aug 2013 22:34:26 -0400
Date: Wed, 7 Aug 2013 10:34:20 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Fix undefined variable
Message-ID: <20130807023420.GA16844@shangw.(null)>
References: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 10:24:46PM -0400, Mike Qiu wrote:
>'pe_no' hasn't been defined, it should be an typo error,
>it should be 'frozen_pe_no'.
>
>Also '__func__' should be added to IODA_EEH_DBG(),
>
>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>index 0cd1c4a..a49bee7 100644
>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>@@ -843,7 +843,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
> 		 * specific PHB.
> 		 */
> 		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
>-			err_type, severity, pe_no, hose->global_number);
>+			__func__, err_type, severity,
>+			frozen_pe_no, hose->global_number);
> 		switch (err_type) {
> 		case OPAL_EEH_IOC_ERROR:
> 			if (severity == OPAL_EEH_SEV_IOC_DEAD) {

Thanks,
Gavin
