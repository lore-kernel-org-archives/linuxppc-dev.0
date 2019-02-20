Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F900C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:23:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF64206B7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 11:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="OW+ZdkOE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UtQ2lZMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF64206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Fb85nrczDqGl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:23:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.26; helo=out2-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="OW+ZdkOE"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="UtQ2lZMj"; dkim-atps=neutral
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444FVF1rFszDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:19:00 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 1DD9222252;
 Wed, 20 Feb 2019 06:18:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 20 Feb 2019 06:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
 CmK2mZyoLDBVYU2WvgqG8AVzTVks0pLifb2VmQmXr7I=; b=OW+ZdkOE3aqKOO79
 j+O+itUdmUEu/OXAyUL9i3I40fECDtxDqzrkbnNHT8u1QPb6KkVSKxEEnQoXJimN
 VaP0ZJjVMvkkOVY0atclAeexptA6B9XFnf8Wfrkd2/CxK9G5iIdC/b9iDi76yBBs
 L+dIezjjKZ9QP2WbmcmWCWCj3qvRHmSUiAy4C7f3QXAHFuk1b9xEbBFTrtL25PHU
 XLKDnPMHBN+qa0MDYDbyTbSQqDi7UdxjQhzRsfG8Y4AlSQE4osCCQq2aCEWEO5Sd
 0WT1L+fCsoKP3GMkxJ+WBiwpUzPZ9A9LxFut+t6hBWUoR2Csra3s1w+geUdHDJdS
 PP6WDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; bh=CmK2mZyoLDBVYU2WvgqG8AVzTVks0pLifb2VmQmXr
 7I=; b=UtQ2lZMjj9XMV64/a67l4sGTTM6A8h0LnA2xdBwbIY4PnJVzahHFNq8gj
 iutWp8t2M7Ye2tlk/VUY5LwGR6JssynahnoAHf5e+cn6fTJCW0vYgL61WJ5EAVn+
 grBFSt7uFXHolXmBZwl7qMM1NKQ4N5dw9sBgKLOx+6izRwszn5UPNO4sJvjfv4uf
 KBtCsvS1Gu+HN4N8v8CqxPacQo7POBbWOwEHBTPMDabD6ZtTochsVWUnCej/cOnw
 okbDU2OC6acnEEpI8ipFLWsaVAUBcWz5Dzh6Pcz9/cf1/kNNA0EsiTPDQYuHUqdB
 bUg1BbInNc07599+HVP+LnkRg/eFA==
X-ME-Sender: <xms:oDdtXPra1uPSiNnRanC_AREUBwL_eT3VkF5xeBygGskT1e9dpl58TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdeigddvheculddtuddrgedtledrtddtmd
 cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddt
 reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
 hsvghllhdrtggtqeenucfkphepuddvuddrgeehrddvudelrdefnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsthgvrhfuih
 iivgeptd
X-ME-Proxy: <xmx:oDdtXGfoXRhVj3DbSQV_yXNRbN7dbkNLHhLC6kKNB0efihwP99csOw>
 <xmx:oDdtXAYDZhhrRu6EU2vIEXSmrcXI680gA12vDwbVWTmS3RsVBn8YLQ>
 <xmx:oDdtXBAXTjRa8BI_NpJRh_v_odNoaZBEUm65vDQxEleNN7Jm13TTGg>
 <xmx:oTdtXOWJK76JenIZPqa2Ht9-_2RSS3_BMn0tNZI0wWUEi8Qx_Af9zA>
Received: from crackle.ozlabs.ibm.com
 (ppp121-45-219-3.bras1.cbr2.internode.on.net [121.45.219.3])
 by mail.messagingengine.com (Postfix) with ESMTPA id B51C410310;
 Wed, 20 Feb 2019 06:18:54 -0500 (EST)
Message-ID: <275066ee653036b139a548de70965015062f4c48.camel@russell.cc>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
From: Russell Currey <ruscur@russell.cc>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>
Date: Wed, 20 Feb 2019 22:18:51 +1100
In-Reply-To: <20190220060353.GA21952@aks.ibm>
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
 <87o97njdjg.fsf@concordia.ellerman.id.au>
 <1550549702.xfczazszdw.astroid@bobo.none> <20190220060353.GA21952@aks.ibm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-20 at 11:34 +0530, Akshay Adiga wrote:
> On Tue, Feb 19, 2019 at 02:21:04PM +1000, Nicholas Piggin wrote:
> > Michael Ellerman's on February 8, 2019 11:04 am:
> > > Nicholas Piggin <npiggin@gmail.com> writes:
> > > > Russell Currey's on February 6, 2019 4:28 pm:
> > > > > Without restoring the IAMR after idle, execution prevention
> > > > > on POWER9
> > > > > with Radix MMU is overwritten and the kernel can freely
> > > > > execute userspace without
> > > > > faulting.
> > > > > 
> > > > > This is necessary when returning from any stop state that
> > > > > modifies user
> > > > > state, as well as hypervisor state.
> > > > > 
> > > > > To test how this fails without this patch, load the lkdtm
> > > > > driver and
> > > > > do the following:
> > > > > 
> > > > >    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-
> > > > > crash/DIRECT
> > > > > 
> > > > > which won't fault, then boot the kernel with powersave=off,
> > > > > where it
> > > > > will fault.  Applying this patch will fix this.
> > > > > 
> > > > > Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel
> > > > > execution of user
> > > > > space")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > > > 
> > > > Good catch and debugging. This really should be a quirk, we
> > > > don't want 
> > > > to have to restore this thing on a thread switch.
> > > 
> > > I'm not sure I follow. We don't context switch it on Radix, but
> > > we do
> > > on hash if pkeys are enabled.
> > 
> > Badly worded, I mean a hardware quirk. It should follow thread
> > switches. Still, avoiding it for the no-loss case is better than
> > nothing. We can just revisit it as an optimization if future
> > hardware does not require the restore.
> 
> Apparently, the POWER9 Processor User’s Manual v2.0 documents that
> IAMR can be lost, and that is not just the end.
> 
> Pasting excerpt from "Section 23.5.9.2 State Loss and
> Restoration,Page 309"
> 
>   On the POWER9 core, the only state that can be lost for
>   Stop levels less than four, when PSSCR[ESL] = ‘1’ are the
>   following SPRs: CR, FPSCR, VSCR, XER, DSCR, AMR, IAMR, UAMOR,
>   AMOR, DAWR, DAWRX.
> 
> My observation is that AMOR is being used in kernel as of today
> and AMOR is also lost (recreated in similar scenarios where
> IAMR is lost).
> 

I can add AMOR to this patch (or you can send a patch, either way).

