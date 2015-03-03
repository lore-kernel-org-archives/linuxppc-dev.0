Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29A761A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 17:24:04 +1100 (AEDT)
Message-ID: <1425363843.20929.2.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/pseries: Expose post-migration in kernel
 device tree update to drmgr
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 03 Mar 2015 17:24:03 +1100
In-Reply-To: <1425090283-27694-4-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-4-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
> Traditionally after a migration operation drmgr has coordinated the device tree
> update with the kernel in userspace via the ugly /proc/ppc64/ofdt interface. This
> can be better done fully in the kernel where support already exists. Currently,
> drmgr makes a faux ibm,suspend-me RTAS call which we intercept in the kernel so
> that we can check VASI state for suspendability. After the LPAR resumes and
> returns to drmgr that is followed by the necessary update-nodes and
> update-properties RTAS calls which are parsed and communitated back to the kernel
> through /proc/ppc64/ofdt for the device tree update. The drmgr tool should
> instead initiate the migration using the already existing
> /sysfs/kernel/mobility/migration entry that performs all this work in the kernel.
> 
> This patch adds a show function to the sysfs "migration" attribute that returns
> 1 to indicate the kernel will perform the device tree update after a migration
> operation and that drmgr should initiated the migration through the sysfs
> "migration" attribute.

I don't understand why we need this?

Can't drmgr just check if /sysfs/kernel/mobility/migration exists, and if so it
knows it should use it and that the kernel will handle the whole procedure?

cheers
