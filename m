Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 90A831A0279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 11:24:11 +1100 (AEDT)
In-Reply-To: <1425522338-14271-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/pseries: Introduce api_version to migration sysfs
 interface
Message-Id: <20150324002410.F126B140188@ozlabs.org>
Date: Tue, 24 Mar 2015 11:24:10 +1100 (AEDT)
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Cyril Bur <cyrilbur@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-03 at 02:25:38 UTC, Tyrel Datwyler wrote:
> The /sys/kernel/mobility/migration interface was added all the way back
> in 2.6.37. However, the drmgr userspace tool was never augmented to use
> this interface to perfrom migrations. Instead it has continued using a
> faux rtas call coupled with performing the device tree update processing
> in userspace and communicating it back to the kernel via the ugly
> /proc/ppc64/ofdt interface.
> 
> Up until 3.12 the device tree update code in the kernel was badly broken
> and bit rotting. This code was fixed in 3.12 and is now utilized by the
> kernel suspend code as of 3.15. The kernel is now better suited to
> handle the post-mobility fixup of the device tree and drmgr should be
> transitioned to using the sysfs migration interface.
> 
> This patch introduces the api_version sysfs file to /sys/kernel/mobility
> as a means for drmgr to query the current implementation level of the
> kernel migration code. This initial versioning indicates it is capable
> of perfroming all current PAPR requirements for migration including the
> post-mobility firmware activation and device tree update.

I've put this in next.

Please send a follow-up patch that adds documentation for this and the other
sysfs files in Documentation/ABI.

cheers
