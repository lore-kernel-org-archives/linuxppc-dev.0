Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A81CE1A1D62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 05:10:56 +1000 (AEST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 20 Aug 2015 16:10:51 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7BED0352007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 15:09:42 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7KJBCiv4034578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 16:11:13 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7KJAlQ3029482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 16:10:47 -0300
Message-ID: <55D62636.5050403@linux.vnet.ibm.com>
Date: Thu, 20 Aug 2015 16:10:46 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 bhelgaas@google.com, mst@redhat.com
Subject: Re: [PATCH v2 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for
 use by arch code
References: <1439945086.23217.5.camel@ellerman.id.au> ,
 <1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440032549.13406.3.camel@ellerman.id.au>
In-Reply-To: <1440032549.13406.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2015 10:02 PM, Michael Ellerman wrote:
> In future you should send a reply like the above to my mail, and then
> separately send the new patch series. My preference is that the new series is
> not a reply to anything, though some other maintainers may disagree on that
> point.

OK, sure. I can send new patch series as new messages instead of replies 
to the same thread.


> The other question, which I neglected to ask yesterday, is what is the symptom
> of the bug? ie. does the system fail to boot or otherwise crash etc.?

This is briefly explained on cover-letter, but I can elaborate a bit 
more: I was testing driver issues on kernel 2.6.32 (RHEL 6.6), and when 
I tried the mainline kernel, the driver wasn't able to enable MSI-X 
capabilities. Interestingly, on kernel 4.1 this behavior doesn't happen 
and the driver can use MSI-X interrupts.

So, I figured that something was wrong and found the problem described 
on the patches. I tried the proposed solution (calling manually the 
function that is not reachable anymore) and it works.

Regarding the bnx2x driver, below are two dmesg outputs:

1) With kernel 4.2-rc7
bnx2x 0000:01:00.0: no msix capability found

2) With kernel 4.1
bnx2x 0000:01:00.0: msix capability found
bnx2x 0000:01:00.0 eth2: using MSI-X  IRQs: sp 24  fp[0] 26 ... fp[7] 33

> This is changes *in* v2, or since v1.

My bad, sorry.


> Or anywhere after the first '---', which means the version commentary is
> discarded in the final commit.

I used scissors, but there's no problem in stop using it in this list. 
Thanks for the suggestion.

Cheers
