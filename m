Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3BBCBB6F69
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 11:39:53 +1100 (EST)
Received: from mail135-ch1 (localhost [127.0.0.1])	by
 mail135-ch1-R.bigfish.com (Postfix) with ESMTP id 38E29100136	for
 <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 00:39:47 +0000 (UTC)
Received: from CH1EHSMHS019.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.242])	by mail135-ch1.bigfish.com (Postfix) with ESMTP id
 1BE99680046	for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 00:39:45 +0000
 (UTC)
Message-ID: <4EE69ED1.6040302@freescale.com>
Date: Mon, 12 Dec 2011 18:39:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add MSI support for the Freescale hypervisor
References: <1323733052-21495-1-git-send-email-timur@freescale.com>
 <4EE693C9.3080009@freescale.com> <4EE69BEB.8020208@freescale.com>
In-Reply-To: <4EE69BEB.8020208@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2011 06:27 PM, Tabi Timur-B04825 wrote:
> Scott Wood wrote:
>> Technically, it's up to the hv config file where MSIIR gets mapped.
>> After main memory is just a common way of configuring it, but won't work
>> if we're limiting the partition's memory to end at an unusual address.
> 
> I'll change the comment to reflect this.
> 
> Why can't we have the hypervisor always put MSIIR at the end of DDR, and 
> not make it configurable?

"...but won't work if we're limiting the partition's memory to end at an
unusual address."  We have to live with PAMU's iova limitations.  PAMU
setup is user-controlled in general under Topaz.

How's the hypervisor even going to know if the mem= kernel command line
argument is used to change the end of main memory (assuming that's been
taken into account by this point in the boot sequence)?

What if the user put a shared memory region immediately after the main
partition memory?

-Scott
