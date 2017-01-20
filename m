Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v4Wzq1h8HzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 18:09:42 +1100 (AEDT)
Subject: Re: powerpc/nvram: Move an assignment for the variable "ret" in
 dev_nvram_write()
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
 <dcaccc31-99ac-ef90-cbef-79dbf72f0a4d@users.sourceforge.net>
 <52f46c9b-e049-7288-2c53-9c2525cd84c6@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <b0958392-8325-4f56-cded-0ff6691893cf@users.sourceforge.net>
Date: Fri, 20 Jan 2017 08:08:55 +0100
MIME-Version: 1.0
In-Reply-To: <52f46c9b-e049-7288-2c53-9c2525cd84c6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I think you really could have squashed patches 1-3 into a single patch
> that returns directly after any failure.

Thanks for your constructive feedback.

I have got software development concerns around such patch squashing.


> At this point you might as well remove that label and move the kfree(tmp) call up
> and return directly after the failure and at the nvram_write() call site
> doing away completely with the "ret" variable.

Your idea might look nice at first glance. But I would interpret the previous
implementation of the discussed function in the way that the memory which was
dynamically allocated here should always (not only in the failure case) be released
before returning here.

Would you really like to change the life time for this “temporary” data item?

Regards,
Markus
