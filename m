Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12DA51A006C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:59:51 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 15:59:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8F5B82CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:59:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u115xEp343385062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:59:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u115xCtx013302
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:59:13 +1100
Message-ID: <56AEF41E.9050105@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 11:28:54 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 3/9] arch/powerpc: Handle removing maybe-present bolted
 HPTEs
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:53 AM, David Gibson wrote:
> At the moment the hpte_removebolted callback in ppc_md returns void and
> will BUG_ON() if the hpte it's asked to remove doesn't exist in the first
> place.  This is awkward for the case of cleaning up a mapping which was
> partially made before failing.
> 
> So, we add a return value to hpte_removebolted, and have it return ENOENT
> in the case that the HPTE to remove didn't exist in the first place.
> 
> In the (sole) caller, we propagate errors in hpte_removebolted to its
> caller to handle.  However, we handle ENOENT specially, continuing to
> complete the unmapping over the specified range before returning the error
> to the caller.
> 
> This means that htab_remove_mapping() will work sanely on a partially
> present mapping, removing any HPTEs which are present, while also returning
> ENOENT to its caller in case it's important there.

Yeah makes sense.

> 
> There are two callers of htab_remove_mapping():
>    - In remove_section_mapping() we already WARN_ON() any error return,
>      which is reasonable - in this case the mapping should be fully
>      present

Right.

>    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that to
>      just a WARN_ON() in the case of ENOENT, since failing to remove a
>      mapping that wasn't there in the first place probably shouldn't be
>      fatal.

Provided the caller of vmemmap_remove_mapping() which is memory hotplug
path must be handling the returned -ENOENT error correctly. Just curious
and want to make sure that any of the memory sections or pages inside the
section must not be left in a state which makes the next call in the
hotplug path fail.
