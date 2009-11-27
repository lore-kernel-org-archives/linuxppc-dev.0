Return-Path: <ebiederm@xmission.com>
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by ozlabs.org (Postfix) with ESMTP id DB8EBB6F14
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 10:17:08 +1100 (EST)
To: Nathan Fontenot <nfont@austin.ibm.com>
References: <4B0CD70F.6090600@austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 27 Nov 2009 14:41:15 -0800
In-Reply-To: <4B0CD70F.6090600@austin.ibm.com> (Nathan Fontenot's message of
	"Wed\, 25 Nov 2009 01\:04\:47 -0600")
Message-ID: <m13a3ztwtw.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH v2 0/3] Kernel handling of Dynamic Logical Partitioning
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@austin.ibm.com> writes:

> version 2 of the patch set with updates from comments.
>
> The Dynamic Logical Partitioning (DLPAR) capabilities of the powerpc pseries
> platform allows for the addition and removal of resources (i.e. cpus,
> memory, pci devices) from a partition. The removal of a resource involves
> removing the resource's node from the device tree and then returning the
> resource to firmware via the rtas set-indicator call.  To add a resource, it
> is first obtained from firmware via the rtas set-indicator call and then a
> new device tree node is created using the ibm,configure-coinnector rtas call
> and added to the device tree.
>
> The following set of patches implements the needed infrastructure to have the
> kernel handle the DLPAR addition and removal of cpus (other DLPAR'able items to
> follow in future patches).  The framework for this is to create a set of
> probe/release sysfs files that will facilitate arch-specific call-outs to handle
> addition and removal of cpus to the system.

How does this differ from /sys/devices/system/cpu/cpuX/online ?

>From the descriptions it appears that we already have what you are trying to
add and you just need to tie it into DLPAR on ppc.

Eric
