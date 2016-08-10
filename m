Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8Xg90RMRzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 23:53:40 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ADncYn092694
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:53:38 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9qqnm5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:53:37 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 10:53:36 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B89FB1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:53:24 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ADrXWf13697336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:53:33 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ADrW5q030178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:53:33 -0300
Subject: Re: [PATCH v2 1/2] powerpc: add refcount to struct pci_controller
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
 <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 10:53:30 -0300
MIME-Version: 1.0
In-Reply-To: <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3106d6ec-96b3-1fdd-5384-4f133f2df559@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2016 10:45 PM, Andrew Donnellan wrote:
> I'm currently working on a cxl defect found by an IBM test team where we
> run into this - will review this patch more thoroughly and test it shortly.

Gavin provided a review/suggestions via chat, pointing to rely on the
refcount that already exists in the PCI subsystem (not reinvent another)
and leverage the release of the PCI root bus -- which is much simpler!

He replied there should be no problems w/ the EEH reset path (PCI root
bus not released) nor w/ other structs w/ refs to the PHB (PCI DN, EEH
PE, EEH DEV).

I'll go down that path for a PATCH v3.

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
