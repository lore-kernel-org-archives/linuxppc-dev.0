Return-Path: <jstancek@redhat.com>
Received: from mx3-phx2.redhat.com (mx3-phx2.redhat.com [209.132.183.24])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjWjJ2Nl4zDrKb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 03:51:00 +1000 (AEST)
Date: Mon, 26 Sep 2016 13:50:04 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Marcelo Cerri <marcelo.cerri@canonical.com>
Cc: rui y wang <rui.y.wang@intel.com>, herbert@gondor.apana.org.au,
 mhcerri@linux.vnet.ibm.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <978710766.77328.1474912204420.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160926141510.GC5031@gallifrey>
References: <450861381.1559123.1474673197124.JavaMail.zimbra@redhat.com>
 <1655600242.1561022.1474676547316.JavaMail.zimbra@redhat.com>
 <20160926141510.GC5031@gallifrey>
Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




----- Original Message -----
> From: "Marcelo Cerri" <marcelo.cerri@canonical.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "rui y wang" <rui.y.wang@intel.com>, herbert@gondor.apana.org.au, mhcerri@linux.vnet.ibm.com,
> leosilva@linux.vnet.ibm.com, pfsmorigo@linux.vnet.ibm.com, linux-crypto@vger.kernel.org,
> linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
> Sent: Monday, 26 September, 2016 4:15:10 PM
> Subject: Re: [bug] crypto/vmx/p8_ghash memory corruption in 4.8-rc7
> 
> Hi Jan,
> 
> Just out of curiosity, have you tried to use "76" on both values to
> check if the problem still happens?

I did, I haven't seen any panics with such patch:

@@ -211,7 +212,7 @@ struct shash_alg p8_ghash_alg = {
        .update = p8_ghash_update,
        .final = p8_ghash_final,
        .setkey = p8_ghash_setkey,
-       .descsize = sizeof(struct p8_ghash_desc_ctx),
+       .descsize = sizeof(struct p8_ghash_desc_ctx) + 20,
        .base = {
                 .cra_name = "ghash",
                 .cra_driver_name = "p8_ghash",
