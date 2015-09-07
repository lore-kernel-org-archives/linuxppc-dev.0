Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 792DD1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 09:08:06 +1000 (AEST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 7 Sep 2015 20:08:03 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 365A31DC0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 19:06:58 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t87N6Ces23658772
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 20:06:12 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t87N7w7K024508
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 19:07:59 -0400
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com> <1441595403.12945.3.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mst@redhat.com, Fam Zheng <famz@redhat.com>, Yinghai Lu
 <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "David S. Miller" <davem@davemloft.net>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <55EE18CD.1060803@linux.vnet.ibm.com>
Date: Mon, 7 Sep 2015 20:07:57 -0300
MIME-Version: 1.0
In-Reply-To: <1441595403.12945.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09/07/2015 12:10 AM, Michael Ellerman wrote:
>> But we later removed pci_msi_off() completely, so I think we probably
>> *could* call pci_msi_setup_pci_dev() from pci_init_capabilities().
>>
>> That would be much nicer because it makes more sense there, and it
>> would do the right thing for powerpc and sparc because they both
>> already use that path.
>
> Sounds reasonable to me.
>
> Guilherme can you please try this and let us know.

Sure Michael. I tested in pSeries and PowerNV and both worked. Couldn't 
test on SPARC.


Cheers
