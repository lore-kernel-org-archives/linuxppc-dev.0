Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9AEA1007D3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 04:58:04 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAUHrQU0004276
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 12:53:26 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAUHw0FN1908804
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 12:58:00 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAUHvxoO005126
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 12:58:00 -0500
Date: Mon, 30 Nov 2009 12:57:50 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix DEBUG_HIGHMEM build break from d4515646699
Message-ID: <20091130175750.GD2937@zod.rchland.ibm.com>
References: <1259015333-23485-1-git-send-email-beckyb@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259015333-23485-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 23, 2009 at 04:28:53PM -0600, Becky Bruce wrote:
>Code was added to mm/higmem.c that depends on several
>kmap types that powerpc does not support.  We add dummy
>invalid definitions for KM_NMI, KM_NM_PTE, and KM_IRQ_PTE.
>
>According to list discussion, this fix should not be needed
>anymore starting with 2.6.33.  The code is commented to this
>effect so hopefully we will remember to remove this.
>
>Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>

Ben, I see you have this queued up in you 'next' branch, but this seems to be
impacting 2.6.32 and according to the comments won't be needed in 2.6.33.
Right now, 2.6.32 doesn't build for a general Fedora ppc32 kernel because of
this bug.  Should this be sent to Linus for .32?

( http://ppc.koji.fedoraproject.org/koji/getfile?taskID=31439&name=build.log
for the curious among you that want to look at the build log)

josh
