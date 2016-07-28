Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0Gbj5hFGzDrL2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 12:52:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powernv/pci: Add PHB register dump debugfs handle
In-Reply-To: <20160728015847.GA17212@gwshan>
References: <20160727061404.13831-1-ruscur@russell.cc>
 <20160728015847.GA17212@gwshan>
Date: Thu, 28 Jul 2016 12:52:01 +1000
Message-ID: <871t2e325q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> On Wed, Jul 27, 2016 at 04:14:04PM +1000, Russell Currey wrote:
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 891fc4a..2b9f114 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -3018,6 +3018,42 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>> 	}
>> }
>>
>>+#ifdef CONFIG_DEBUG_FS
>>+static int pnv_pci_diag_data_set(void *data, u64 val)
>>+{
>>+	struct pci_controller *hose;
>>+	struct pnv_phb *phb;
>>+	int ret;
>
> s/int/int64_t

Actually please stick to the kernel types, so s64.

>>+	/* Retrieve the diag data from firmware */
>
> Unnecessary comments as the code is obvious.

Only if you know the OPAL API, for the rest of us that comment is fine IMHO.

>>+	ret = opal_pci_get_phb_diag_data2(phb->opal_id, phb->diag.blob,
>>+					  PNV_PCI_DIAG_BUF_SIZE);
>>+	if (ret != OPAL_SUCCESS)
>>+		return -EIO;
>>+
>>+	/* Print the diag data to the kernel log */

And that comment is very helpful, because the expectation is that the output
would go to the debugfs file.

>>@@ -3033,9 +3069,14 @@ static void pnv_pci_ioda_create_dbgfs(void)
>>
>> 		sprintf(name, "PCI%04x", hose->global_number);
>> 		phb->dbgfs = debugfs_create_dir(name, powerpc_debugfs_root);
>>-		if (!phb->dbgfs)
>>+		if (!phb->dbgfs) {
>> 			pr_warning("%s: Error on creating debugfs on PHB#%x\n",
>> 				__func__, hose->global_number);
>>+			continue;
>>+		}
>>+
>>+		debugfs_create_file("dump_regs", 0200, phb->dbgfs, hose,
>>+				    &pnv_pci_diag_data_fops);
>
> I still think "diag-data" is more indicative. It's also consistent with
> the handler's name (pnv_pci_diag_data_set())?

"dump_regs" is better because it's clearly a verb phrase. Which makes it clear
that manipulating the file causes something to happen.

"diag-data" could be a verb phrase, if you read "diag" as "diagnose", in which
case it would mean "diagnose the data". But that's not what the file does, it
doesn't diagnose anything, it just dumps some registers.

Most likely people will read "diag" as "diagnostic", in which case the name
means "diagnostic data" - which is a noun phrase. That indicates the file *is*
something, ie. an object, so when I read it I would expect to see the object,
and when I write to the file I would expect that to mutate the object.

cheers
