Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 23516B7182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 04:56:06 +1100 (EST)
Message-ID: <4E9331A3.9080805@freescale.com>
Date: Mon, 10 Oct 2011 12:55:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Suzuki Poulose <suzuki@in.ibm.com>
Subject: Re: [PATCH 1/3] [powerpc32] Process dynamic relocations for kernel
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095432.16589.32935.stgit@suzukikp.in.ibm.com>
 <4E930BFA.5030701@freescale.com> <4E932897.2060907@in.ibm.com>
In-Reply-To: <4E932897.2060907@in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@au1.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/10/2011 12:17 PM, Suzuki Poulose wrote:
> On 10/10/11 20:45, Scott Wood wrote:
>> On 10/10/2011 04:55 AM, Suzuki K. Poulose wrote:
>>> The following patch implements the dynamic relocation processing for
>>> PPC32 kernel. relocate() accepts the target virtual address and
>>> relocates
>>>   the kernel image to the same.
>>
>> How much overhead is involved in a true relocatable kernel?  Is it worth
>> preserving the old "relocatable" booke behavior under a different name?
> 
> There are '75782' on an ebony kernel with minimal config. So thats a
> pretty big
> number for small embedded chips. I guess, preserving the 'old
> relocatable' (page
> aligned approach) would be a good idea for the architectures which can
> afford it.
> e.g, places where TLB size is 64M or less.

The systems we've been using this option on aren't *that* small -- I was
thinking more about runtime overhead (beyond the time taken at boot to
process relocations).

-Scott
