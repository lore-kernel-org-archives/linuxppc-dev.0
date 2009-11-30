Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 75EE0B6F07
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 06:54:43 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAUJkONQ027395
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 14:46:24 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAUJsdQD1843292
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 14:54:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAUJsd4X009429
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 14:54:39 -0500
Date: Mon, 30 Nov 2009 14:54:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix DEBUG_HIGHMEM build break from d4515646699
Message-ID: <20091130195435.GE2937@zod.rchland.ibm.com>
References: <1259015333-23485-1-git-send-email-beckyb@kernel.crashing.org>
	<20091130175750.GD2937@zod.rchland.ibm.com>
	<1259610583.2076.97.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259610583.2076.97.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 01, 2009 at 06:49:43AM +1100, Benjamin Herrenschmidt wrote:
>On Mon, 2009-11-30 at 12:57 -0500, Josh Boyer wrote:
>> On Mon, Nov 23, 2009 at 04:28:53PM -0600, Becky Bruce wrote:
>> >Code was added to mm/higmem.c that depends on several
>> >kmap types that powerpc does not support.  We add dummy
>> >invalid definitions for KM_NMI, KM_NM_PTE, and KM_IRQ_PTE.
>> >
>> >According to list discussion, this fix should not be needed
>> >anymore starting with 2.6.33.  The code is commented to this
>> >effect so hopefully we will remember to remove this.
>> >
>> >Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> 
>> Ben, I see you have this queued up in you 'next' branch, but this seems to be
>> impacting 2.6.32 and according to the comments won't be needed in 2.6.33.
>> Right now, 2.6.32 doesn't build for a general Fedora ppc32 kernel because of
>> this bug.  Should this be sent to Linus for .32?
>
>Why would fedora have DEBUG_HIGHMEM enabled ? I'll see what I can do.

Why shouldn't it?  Fedora generally builds rawhide kernels with all kinds of
debug options set.

When you say you'll see what you can do, do you mean you'll see if you can get
the patch into .32, or change the Fedora config?  If you mean change the Fedora
config, I can do that myself.  I was more pointing out that you have a .32
patch not needed for .33 heading for .33... ;)

josh
