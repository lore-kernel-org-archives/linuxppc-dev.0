Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A4C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:33:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6B420851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YxjYNFSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6B420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zLBg1kh6zF3Rv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YxjYNFSc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rere.qmqm.pl
 (client-ip=91.227.64.183; helo=rere.qmqm.pl;
 envelope-from=mirq-linux@rere.qmqm.pl; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YxjYNFSc";
 dkim-atps=neutral
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zL824nn8zF3Q4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 07:30:56 +1100 (AEDT)
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 42zL6Z3LyMz9F;
 Mon, 19 Nov 2018 21:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1542659385; bh=5Z1JxtP6t2MpmKGXF4akUMNKBd1blEAW0J6fQjaV5EI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YxjYNFSccw0zzZInPSoLJET4HYympSS2jElCLv6epc0NGHrvfbhnY9K0+GrvaAskc
 uUvO4dIk3xEpBb6V7Q67UoPw1ScREh1oJcY+QNpTnOoUdnVQlIV3br7/VS+zt/Q8sH
 2rV4Q6ZHO/lfmv8EczBRrXZHarKER7cdAp90mpqsxu3xHZqAsutSDDAHF5+mntAZaS
 +OyE17c2rTFcN3M7ofG9ELkxhlmN8ywKZ93K/qwbjLU/j4b9r8Jpx98oecBW7mwfpu
 D68sjn6gGxLJN6Pi3NXpylcfDZBaWQ5On2I9mbmHIIBbQZUUHFQvG3enDEvckiTlEF
 Y/gLd+eWq1+uQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Mon, 19 Nov 2018 21:30:46 +0100
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 2/6] net/bpf: split VLAN_PRESENT bit handling
 from VLAN_TCI
Message-ID: <20181119203046.GA7067@qmqm.qmqm.pl>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <b7fed809fc44d0b439adeb69d0fe98dd036b05e8.1541876179.git.mirq-linux@rere.qmqm.pl>
 <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c420b7a8-73df-3e9c-962a-a295ad0a6139@iogearbox.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 netdev@vger.kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 19, 2018 at 12:26:46PM +0100, Daniel Borkmann wrote:
> On 11/10/2018 07:58 PM, Micha³ Miros³aw wrote:
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> 
> Why you have empty commit messages for non-trivial changes like this in
> 4 out of 6 of your patches ...
> 
> How was it tested on the JITs you were changing? Did you test on both,
> big and little endian machines?

I have only x86 boxes currently so didn't try to test others. I hope
upstreaming the series through net-next will allow us to find any
fallouts, if any. The changes are very simple, though: they move
code around (the "splitting" part) and eventually change a vlan_present
flag's position in a skbuff structure. Dependency on CPU endianness is
removed by using byte loads for the flag.

Best Regards,
Micha³ Miros³aw
