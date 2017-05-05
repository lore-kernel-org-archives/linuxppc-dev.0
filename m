Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wK3dz4d82zDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 17:37:59 +1000 (AEST)
Date: Fri, 5 May 2017 10:37:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Unlock on error in probe
Message-ID: <20170505073744.yqwfhunn6rlqiupf@mwanda>
References: <20170505053622.0670F124037@b01ledav002.gho.pok.ibm.com>
 <a4c0a3f6-f631-0998-ddd0-ca2efd4f1bfd@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4c0a3f6-f631-0998-ddd0-ca2efd4f1bfd@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 05, 2017 at 05:14:15PM +1000, Andrew Donnellan wrote:
> sem is a global and it looks like it's intended to be held after
> device_open() returns and only released in device_close(), so this looks
> wrong.
> 

This doesn't affect the success path, it only means that if
device_open() fails because we don't have enough free memory or whatever
then we can try again later.

regards,
dan carpenter
