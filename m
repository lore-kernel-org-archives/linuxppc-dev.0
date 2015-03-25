Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A70F11A0C19
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:51:20 +1100 (AEDT)
In-Reply-To: <1423993377.2932.23.camel@TP420>
To: Li Zhong <zhong@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC,
 powerpc] perf/hv-24x7 set the attr group to NULL if events failed to
 be initialized
Message-Id: <20150325095120.8F48F1400EA@ozlabs.org>
Date: Wed, 25 Mar 2015 20:51:20 +1100 (AEDT)
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-15-02 at 09:42:57 UTC, Li Zhong wrote:
> sysfs_create_groups() creates groups one by one in the attr_groups array
> before a NULL entry is encountered. But if an error is seen, it stops
> and removes all the groups already created:
>         for (i = 0; groups[i]; i++) {
>                 error = sysfs_create_group(kobj, groups[i]);
>                 if (error) {
>                         while (--i >= 0)
>                                 sysfs_remove_group(kobj, groups[i]);
>                         break;
>                 }
>         }
> 
> And for the three event groups of 24x7, if it is not supported,
> according to the above logic, it causes format and interface group to be
> removed because of the error.
> 
> This patch moves the three events groups to the end of the attr groups,
> and if create_events_from_catalog() fails to set their attributes, we
> set them to NULL in attr_groups.

But why are we continuing at all if create_events_from_catalog() fails?

Shouldn't that just be a fatal error and we bail?

cheers
