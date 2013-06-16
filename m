Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97ADE2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jun 2013 15:12:22 +1000 (EST)
Message-ID: <1371359531.21896.128.camel@pasglop>
Subject: Re: [PATCH 21/27] powerpc/eeh: Process interrupts caused by EEH
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 16 Jun 2013 15:12:11 +1000
In-Reply-To: <1371286998-2842-22-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371286998-2842-22-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-06-15 at 17:03 +0800, Gavin Shan wrote:
> On PowerNV platform, the EEH event is produced either by detect
> on accessing config or I/O registers, or by interrupts dedicated
> for EEH report. The patch adds support to process the interrupts
> dedicated for EEH report.
> 
> Firstly, the kernel thread will be waken up to process incoming
> interrupt. The PHBs will be scanned one by one to process all
> existing EEH errors. Besides, There're mulple EEH errors that can
> be reported from interrupts and we have differentiated actions
> against them:
> 
> - If the IOC is dead, all PCI buses under all PHBs will be removed
>   from the system.
> - If the PHB is dead, all PCI buses under the PHB will be removed
>   from the system.
> - If the PHB is fenced, EEH event will be sent to EEH core and
>   the fenced PHB is expected to be resetted completely.
> - If specific PE has been put into frozen state, EEH event will
>   be sent to EEH core so that the PE will be resetted.
> - If the error is informational one, we just output the related
>   registers for debugging purpose and no more action will be
>   taken.

Getting better.... but:

 - I still don't like having a kthread for that. Why not use schedule_work() ?

 - We already have an EEH thread, why not just use it ? IE send it a special
type of message that makes it query the backend for error info instead ?

 - I'm not fan of exposing that EEH private lock. I don't entirely understand
why you need to do that either.

Generally speaking, I'm thinking this file should contain less stuff, most of
it should move into the ioda backend, the interrupt just turning into some
request down to the existing EEH thread.

Cheers,
Ben.
