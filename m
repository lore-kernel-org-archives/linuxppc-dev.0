Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C156F1A048E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:28:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 19:28:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C13702CE8062
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:28:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAP9S3Er21889278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:28:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAP9S3st021497
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 20:28:03 +1100
Date: Tue, 25 Nov 2014 17:28:01 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 08/18] powrepc/pci: Refactor pci_dn
Message-ID: <20141125092801.GA3931@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-9-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119233024.GF23467@google.com> <20141120072057.GC8562@richard>
 <20141120190541.GA5110@google.com> <20141121000411.GA19858@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141121000411.GA19858@shangw>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 21, 2014 at 11:04:11AM +1100, Gavin Shan wrote:
>>> 2.4 The potential problem for [Patch 08/18]
>>> ===============================================================================
>>> According to the SPEC, the offset/stride will change after each
>>> sriov_enable(). This means the bus/devfn will change after each
>>> sriov_enable().
>>> 
>>> My current thought is to fix it up in virtfn_add(). If the total VF number
>>> will not change, we could create those pci_dn at the beginning and fix the
>>> bus/devfn at each time the VF is truely created.
>>
>>By "fix it up," I assume you mean call an arch function that does the
>>pci_pdn setup you need.
>>
>>It sounds reasonable to do this either in virtfn_add()/virtfn_remove() or
>>at the points where we write PCI_SRIOV_CTRL_VFE, i.e., in sriov_init(),
>>sriov_enable(), sriov_disable(), and sriov_restore_state().  From a
>>hardware point of view, the VFs exist whenever PCI_SRIOV_CTRL_VFE is set,
>>so it might be nice to have this setup connected to that.
>>
>
>Yes, Both ways can fix the issue. For couple reasons, I want add weak
>pcibios_virtfn_add(), which is called in virtfn_add() if you agree.
>
>- PCI_SRIOV_CTRL_VFE might be set somewhere except the functions you pointed.
>  Set/clear PCI_SRIOV_CTRL_VFE will invoke background work to check pci_dn
>  and add/remove accordingly. It would be overhead which we can avoid.
>- We plan to support EEH for VFs in future. virtfn_add() way matches with
>  current EEH implementation better. EEH device and PE are created based
>  on (struct pci_dev), and EEH devices and PE can be destroied in time in
>  pcibios_release_device(), which is invoked by virtfn_remove(). So we only
>  need one weak function. In contrast, we have to create EEH device and PE
>  for VFs a bit early before any VFs are instantiated, and destroy them a
>  bit late after all VFs are offline.
>

Bjorn,

Since my mail box got some problem in the last few days, I am not sure you
agree with Gavin's proposal or not?

And if you agree to enumerate the maximum VF bus range, I will add this logic
in the next versin.

>Thanks,
>Gavin
>
>>Bjorn
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Richard Yang
Help you, Help me
