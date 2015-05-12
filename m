Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B2A41A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:17:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 May 2015 09:17:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 04A432CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:17:35 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4CNHQrd42598442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:17:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CNH20R021615
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 09:17:02 +1000
Date: Wed, 13 May 2015 09:16:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 8/9] powerpc/powernv: Support PCI config restore for VFs
Message-ID: <20150512231637.GA8004@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-9-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150511042238.GA19629@gwshan> <20150512013134.GA5814@richard>
 <20150512063403.GA21256@gwshan> <20150512081645.GD16788@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150512081645.GD16788@richard>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 04:16:45PM +0800, Wei Yang wrote:
>On Tue, May 12, 2015 at 04:34:03PM +1000, Gavin Shan wrote:
>>>
>>>>>+	/* Disable Completion Timeout */
>>>>>+	if (pcie_cap) {
>>>>>+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCAP2, 4, &cap2);
>>>>>+		if (cap2 & 0x10) {
>>>>>+			pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, &cap2);
>>>>>+			cap2 |= 0x10;
>>>>>+			pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, cap2);
>>>>>+		}
>>>>>+	}
>>>>>+
>>>>>+	/* Enable SERR and parity checking */
>>>>>+	pnv_pci_cfg_read(pdn, PCI_COMMAND, 2, &cmd);
>>>>>+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
>>>>>+	pnv_pci_cfg_write(pdn, PCI_COMMAND, 2, cmd);
>>>>>+
>>>>>+	/* Enable report various errors */
>>>>>+	if (pcie_cap) {
>>>>>+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
>>>>>+		devctl &= ~PCI_EXP_DEVCTL_CERE;
>>>>>+		devctl |= (PCI_EXP_DEVCTL_NFERE |
>>>>>+			   PCI_EXP_DEVCTL_FERE |
>>>>>+			   PCI_EXP_DEVCTL_URRE);
>>>>>+		pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
>>>>>+	}
>>>>>+
>>>>>+	/* Enable ECRC generation and check */
>>>>>+	if (pcie_cap) {
>>>>>+		aer_cap = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
>>>>>+		pnv_pci_cfg_read(pdn, aer_cap + PCI_ERR_CAP, 4, &aer_capctl);
>>>>>+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
>>>>>+		pnv_pci_cfg_write(pdn, aer_cap + PCI_ERR_CAP, 4, aer_capctl);
>>>>>+	}
>>>>>+
>>>>>+	return 0;
>>>>>+}
>>>>>+#endif /* CONFIG_PCI_IOV */
>>>>>+
>>>>
>>>>The code is copied over from skiboot firmware. I still dislike the fact that
>>>>we have to maintain two sets of similar functions in skiboot/kernel. I still
>>>>believe the way I suggested can help: the firmware exports the error routing
>>>>rules and kernel has support it based on the rules. With it, the skiboot is
>>>>the source of the information to avoid mismatching between kernel/firmware.
>>>
>>>Yes, it looks we have duplicate code in kernel and skiboot.
>>>
>>>As you suggest, if we export some bit map from device node, we still have the
>>>real logic in kernel, until we remove that part in skiboot.
>>>
>>>By removing that part in skiboot, we may have some compatibility problem. For
>>>example, an old kernel may not run on the new version of skiboot.
>>>
>>
>>It's fine to keep two set code which bear with same rule, which is exported
>>from skiboot. In that case, the rule is the only thing we have to care. We
>>don't need care the code any more to avoid mismatch between kernel/firmware.
>>
>
>Ok, duplication is reasonable, then the major point for this is we need to
>have a clear rule for restoring configuration for a device.
>

Well, I have to explain a bit more if I didn't make myself clear enough, then
you change the code in another way, which will waste your time.

- From skiboot, each PHB's device node maintains the rules, which *could* be
  described as the data structures I have given in previous replies if you
  can't figure out better data structures.
- Skiboot will reinitialize those devices for the following 3 cases: PCI
  enumeration, PCI config space restore requested from EEH, after PCI hotplug/reset.
  Obviously, the code needs changes to utilize the rules in PHB's device node.
- Kernel will do similiar thing as skiboot will do: Reinitialize VFs according
  to the rules in PHB's device node.

Yes, we have duplicated code, not rules. Hopefully, I make myself clear enough.

>Than I suggest we could have another patch set to handle this. Define the rule
>clearly and restore the configuration in kernel when skiboot firmware export
>such rules.
>

Sure.

Thanks,
Gavin
