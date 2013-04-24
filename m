Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8391E2C011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 11:31:45 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 19:31:43 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9E7FC3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:31:26 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O1Vd9H100502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:31:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O1Vdap009171
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 19:31:39 -0600
Date: Wed, 24 Apr 2013 09:31:36 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130424013136.GB6527@shangw.(null)>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366715034-24594-5-git-send-email-shangw@linux.vnet.ibm.com>
 <1366730513.12131.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366730513.12131.5.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 24, 2013 at 01:21:53AM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2013-04-23 at 19:03 +0800, Gavin Shan wrote:
>> 
>> +static int pnv_pci_ioda_msi_eoi(struct pnv_phb *phb, unsigned int hw_irq)
>> +{
>> +       u8 p_bit = 1, q_bit = 1;
>> +       long rc;
>> +
>> +       while (p_bit || q_bit) {
>> +               rc = opal_pci_get_xive_reissue(phb->opal_id,
>> +                               hw_irq - phb->msi_base, &p_bit, &q_bit);
>> +               if (rc) {
>> +                       pr_warning("%s: Failed to get P/Q bits of IRQ#%d "
>> +                                  "on PHB#%d, rc=%ld\n", __func__, hw_irq,
>> +                                  phb->hose->global_number, rc);
>> +                       return -EIO;
>> +               }
>> +               if (!p_bit && !q_bit)
>> +                       break;
>> +
>> +               rc = opal_pci_set_xive_reissue(phb->opal_id,
>> +                               hw_irq - phb->msi_base, p_bit, q_bit);
>> +               if (rc) {
>> +                       pr_warning("%s: Failed to clear P/Q (%01d/%01d) of "
>> +                                  "IRQ#%d on PHB#%d, rc=%ld\n", __func__,
>> +                                  p_bit, q_bit, hw_irq,
>> +                                  phb->hose->global_number, rc);
>> +                       return -EIO;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>
>Can you turn that into a single opal_pci_msi_eoi() ? This means that a
>single MSI will trigger only one OPAL call rather than two which is
>better for performances.
>

Ok. I will add new OPAL API opal_pci_msi_eoi() and use that in next version.

>We will later implement an "optimized" variant using direct MMIO based
>on knowing specifically the HW type but not now.
>

Ok :-)

Thanks,
Gavin
