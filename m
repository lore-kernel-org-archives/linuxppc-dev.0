Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDV1p0y4mzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 17:09:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] powerpc/pseries: Manage single copy of ibm,
 dynamic-memory
In-Reply-To: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <20160826210312.44862.37838.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Thu, 02 Feb 2017 17:08:59 +1100
Message-ID: <87vastazus.fsf@concordia.ellerman.id.au>
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

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:

> The ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory property
> of the device-tree can be fairly big on systems with a large amount
> of memory. A system with 1 TB of memory (256 MB LMBs) the property
> size is 94k, this equates to roughly a 30MB property size for a 32 TB
> system. This file size is not neccessarily huge, but the need to update
> this property every time we DLPAR add or remove an LMB could be
> problematic.
>
> Every time the property is updated a new copy of the property is made
> with the previous copy being added to the old_properties list. Due to
> the lack of reference counting on properties old versions of a property
> are never free'ed. One a large 32TB system we could easilty do
> several thousands of memory add/remove operations and thus create
> several thousand of copies of this property. This seems a bit wasteful
> with respect to system resources.
>     
> Patch 1/3:
> This patch changes the pseries hotplug memory code to maintain a static
> reference to this property instead of creating a new copy for every LMB
> that we add or remove. In doing this we have to ensure that the property
> remains in BE format so a set of accessor methods are provided to
> get/set values from the property in the proper cpu format.

I missed this when you sent it, and now it doesn't apply anymore. Can
you do a rebase and resend it ?

cheers
