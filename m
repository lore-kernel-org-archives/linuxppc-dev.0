Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
 [216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A1B56B6F6B
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2011 04:21:49 +1100 (EST)
Message-ID: <4EB812E8.9090107@freescale.com>
Date: Mon, 7 Nov 2011 11:18:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <ananth@in.ibm.com>
Subject: Re: [PATCH] powerpc: Export PIR data through sysfs
References: <20111107044750.GB4361@in.ibm.com>
In-Reply-To: <20111107044750.GB4361@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/06/2011 10:47 PM, Ananth N Mavinakayanahalli wrote:
> The Processor Identification Register (PIR) on powerpc provides
> information to decode the processor identification tag. Decoding
> this information platform specfic.
> 
> Export PIR data via sysfs.
> 
> (Powerpc manuals state this register is 'optional'. I am not sure
> though if there are any Linux supported powerpc platforms that
> don't have it. Code in the kernel referencing PIR isn't under
> a platform ifdef).

Those references are in platform-specific files, under #ifdef
CONFIG_SMP, often in areas that would only be executed in the presence
of multiple CPUs (e.g. secondary release).  The reference in misc_32.S
is inside #ifdef CONFIG_KEXEC and is fairly recent -- it may not have
been tested on these systems.

I don't see PIR (other than in the acronym definition section) in
manuals for UP-only cores such as e300, 8xx, and 750.

What use does userspace have for this?  If you want to return the
currently executing CPU (which unless you're pinned could change as soon
as the value is read...), why not just return smp_processor_id() or
hard_smp_processor_id()?

-Scott
