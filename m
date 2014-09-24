Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA5301A009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 12:23:17 +1000 (EST)
In-Reply-To: <1409039779-392-3-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/4] powerpc/eeh: Introduce eeh_ops::err_inject
Message-Id: <20140924022317.C98A61400B5@ozlabs.org>
Date: Wed, 24 Sep 2014 12:23:17 +1000 (EST)
Cc: mikey@neuling.org, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-26-08 at 07:56:17 UTC, Gavin Shan wrote:
> From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> 
> +
> +	/* Firmware supports error injection ? */
> +	ret = opal_check_token(OPAL_PCI_ERR_INJCT);
> +	if (ret != OPAL_TOKEN_PRESENT) {
> +		pr_warn("%s: Firmware not support error injection (%lld)\n",
> +			__func__, ret);

This doesn't build, we dropped OPAL_TOKEN_PRESENT.

I've replaced it with:

       if (!opal_check_token(OPAL_PCI_ERR_INJCT)) {
               pr_warn("%s: Firmware doesn't support error injection (%lld)\n",
                        __func__, ret);

cheers
