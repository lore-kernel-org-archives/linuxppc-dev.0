Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DB351A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:36:55 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 18:36:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4EA362BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 19:36:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u118ajHx41222352
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:36:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u118aKvU023318
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 19:36:21 +1100
Message-ID: <56AF18F2.2020401@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 14:06:02 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 8/9] pseries: Advertise HPT resizing support via CAS
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-9-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-9-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:54 AM, David Gibson wrote:
> The hypervisor needs to know a guest is capable of using the HPT resizing
> PAPR extension in order to make full advantage of it for memory hotplug.
> 
> If the hypervisor knows the guest is HPT resize aware, it can size the
> initial HPT based on the initial guest RAM size, relying on the guest to
> resize the HPT when more memory is hot-added.  Without this, the hypervisor
> must size the HPT for the maximum possible guest RAM, which can lead to
> a huge waste of space if the guest never actually expends to that maximum
> size.
> 
> This patch advertises the guest's support for HPT resizing via the
> ibm,client-architecture-support OF interface.  Obviously, the actual
> encoding in the CAS vector is tentative until the extension is officially
> incorporated into PAPR.  For now we use bit 0 of (previously unused) byte 8
> of option vector 5.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
