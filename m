Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0878A1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 09:04:35 +1000 (AEST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 7 Sep 2015 20:04:29 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3378A1DC0080
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 19:03:23 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t87N4oKk4227292
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 20:04:50 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t87N4Npp026426
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 20:04:24 -0300
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
To: Michael Ellerman <mpe@ellerman.id.au>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com> <55EA2678.5030801@linux.vnet.ibm.com>
 <20150906173838-mutt-send-email-mst@redhat.com>
 <1441595823.12945.4.camel@ellerman.id.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, paulus@samba.org,
 Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
 Yijing Wang <wangyijing@huawei.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "David S. Miller" <davem@davemloft.net>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <55EE17F6.8010807@linux.vnet.ibm.com>
Date: Mon, 7 Sep 2015 20:04:22 -0300
MIME-Version: 1.0
In-Reply-To: <1441595823.12945.4.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sun, 2015-09-06 at 17:44 +0300, Michael S. Tsirkin wrote:

>>> My question is: is necessary to initialize MSI capabilities even with
>>> CONFIG_PCI_MSI not set? In negative case, would be "cleaner" revert the 3
>>> commits, right?

>> I think the reason why it's necessary is explained in
>> commit log for commit 1851617cd2da9cc53cdc1738f4148f4f042c0e56 (that's
>> [3] below).

Thanks very much Michael. I re-read the text of your commit, and makes 
sense then to initialize the MSI capabilities even with CONFIG_PCI_MSI 
not set.


> On 09/07/2015 12:17 AM, Michael Ellerman wrote:
> Well yes and no.
>
> What we want to do when CONFIG_PCI_MSI=n is disable MSI on the device. In order
> to do that the code first initialises dev->msi[x]_cap.
>
> But arguably that's wrong, ie. when CONFIG_PCI_MSI=n dev->msi[x]_cap *should*
> be zero so that any code which erroneously tries to use them will fail.
>
> But perhaps that's being too pedantic :)

I thought exactly this - that was the reason of my questioning. Thanks 
for your opinion Michael - I'd call the argument logical, not pedantic 
hehehe


Cheers
