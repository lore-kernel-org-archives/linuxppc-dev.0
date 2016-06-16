Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVX3Q5J8kzDqld
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:28:18 +1000 (AEST)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVX3P5CnSz9t0v
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 15:28:17 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id b5so14544508pas.3
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2016 22:28:16 -0700 (PDT)
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
To: "Darrick J. Wong" <darrick.wong@oracle.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
Cc: linuxppc-dev@ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <c4e18fda-f864-6d2a-5dea-ab1b7da990e2@gmail.com>
Date: Thu, 16 Jun 2016 15:28:10 +1000
MIME-Version: 1.0
In-Reply-To: <20160616043340.GB22590@birch.djwong.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/06/16 14:33, Darrick J. Wong wrote:
> Hi Aneesh,
> 
> I noticed when trying out 4.7-rc3 on qemu-2.5 that the kernel no longer
> boots.  4.6 booted just fine, so I bisected the kernel to the commit
> 30bda41aba4efb2370c97e2cbe7385de93ccc372, which is "powerpc/mm: Drop WIMG in
> favour of new constants".  The changelog suggests that the KVM changes need
> closer review, and here's an actual crash:
> 
> (I can send libvirt's machine xml, .config, and full dmesg if that helps.)
> 
> --Darrick


Looking at the address - 0xd000080080000010, looks like map_kernel_page followed
by a fault here did not do the right thing. This EA range belongs to the io_remap
range, IIUC. The only suspicious bits I could find are

+       /*
+        * if host is mapped cache inhibited, make sure hptel also have
+        * cache inhibited.
+        */
+       if (wimg & HPTE_R_W) /* FIXME!! is this ok for all guest. ? */
+               return false;


Aneesh also posted some changes to hpte_update and hpte_updatepp that might be
interesting

Balbir
