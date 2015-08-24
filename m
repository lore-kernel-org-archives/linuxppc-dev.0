Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36A581A1D63
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 17:37:59 +1000 (AEST)
Message-ID: <1440401878.15373.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] PCI: Make pci_msi_setup_pci_dev() non-static for
 use by arch code
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 bhelgaas@google.com, mst@redhat.com
Date: Mon, 24 Aug 2015 17:37:58 +1000
In-Reply-To: <55D62636.5050403@linux.vnet.ibm.com>
References: <1439945086.23217.5.camel@ellerman.id.au>
 ,<1439932077-11427-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440009922-30248-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440032549.13406.3.camel@ellerman.id.au>
 <55D62636.5050403@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-20 at 16:10 -0300, Guilherme G. Piccoli wrote:
> On 08/19/2015 10:02 PM, Michael Ellerman wrote:
> > In future you should send a reply like the above to my mail, and then
> > separately send the new patch series. My preference is that the new series is
> > not a reply to anything, though some other maintainers may disagree on that
> > point.
> 
> OK, sure. I can send new patch series as new messages instead of replies 
> to the same thread.

Thanks.

> > The other question, which I neglected to ask yesterday, is what is the symptom
> > of the bug? ie. does the system fail to boot or otherwise crash etc.?
> 
> This is briefly explained on cover-letter, but I can elaborate a bit 

Sure, but the cover-letter is not committed, so the commit change logs need to
be self describing.

> more: I was testing driver issues on kernel 2.6.32 (RHEL 6.6), and when 
> I tried the mainline kernel, the driver wasn't able to enable MSI-X 
> capabilities. Interestingly, on kernel 4.1 this behavior doesn't happen 
> and the driver can use MSI-X interrupts.
> 
> So, I figured that something was wrong and found the problem described 
> on the patches. I tried the proposed solution (calling manually the 
> function that is not reachable anymore) and it works.
> 
> Regarding the bnx2x driver, below are two dmesg outputs:
> 
> 1) With kernel 4.2-rc7
> bnx2x 0000:01:00.0: no msix capability found

OK. This is because the initialisation of dev->msix_cap was lost due to commit
1851617cd2da.

> 2) With kernel 4.1
> bnx2x 0000:01:00.0: msix capability found
> bnx2x 0000:01:00.0 eth2: using MSI-X  IRQs: sp 24  fp[0] 26 ... fp[7] 33

OK. And I assume with these patches you see the above output again.

> > This is changes *in* v2, or since v1.
> 
> My bad, sorry.
> 
> > Or anywhere after the first '---', which means the version commentary is
> > discarded in the final commit.
> 
> I used scissors, but there's no problem in stop using it in this list.

Thanks, but my scripts don't grok scissors. So I prefer the commentary after
the '---'.

cheers
