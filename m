Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmbN42JskzF0Sb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 22:48:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v0 1/2] powerpc,
 drmem: Fix unexpected flag value in ibm, dynamic-memory-v2
In-Reply-To: <1519209387-29767-2-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519209387-29767-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1519209387-29767-2-git-send-email-bharata@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 22:48:18 +1100
Message-ID: <87zi42r2bh.fsf@concordia.ellerman.id.au>
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

Bharata B Rao <bharata@linux.vnet.ibm.com> writes:

> Memory addtion and removal by count and indexed-count methods
> temporarily mark the LMBs that are being added/removed by a special
> flag value DRMEM_LMB_RESERVED. Accessing flags value directly at
> a few places without proper accessor method is causing two unexpected
> side-effects:
>
> - DRMEM_LMB_RESERVED bit is becoming part of the flags word of
>   drconf_cell_v2 entries in ibm,dynamic-memory-v2 DT property.
> - This results in extra drconf_cell entries in ibm,dynamic-memory-v2.
>   For example if 1G memory is added, it leads to one entry for 3 LMBs
>   and 1 separate entry for the last LMB. All the 4 LMBs should be
>   defined by one entry here.
>
> Fix this by always accessing the flags by its accessor method
> drmem_lmb_flags().
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Presumably:

  Fixes: 2b31e3aec1db ("powerpc/drmem: Add support for ibm, dynamic-memory-v2 property")

?

cheers
