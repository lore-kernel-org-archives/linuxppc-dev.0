Return-Path: <SRS0=Y1I/=GS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 18:34:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29E723A58
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Jan 2021 18:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29E723A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHVFT6TD8zDvWb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Jan 2021 05:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iW5vxKMW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHS5H0m18zDsbR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2021 03:56:50 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7979C20738;
 Fri, 15 Jan 2021 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610729807;
 bh=65KME7dlQ6ZxSIcs/tBhxcihrYV+4nzB/aZGW3JS39U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iW5vxKMW9vNDJos4it09xTOONBPZKklsLnEyxEmE4xEDwArUAAIjUc6JNJFqx7Ijw
 DyGUNyWEQI19X/6El61kkAvRhz4DXcIaGio0nqsD8aSOld7nU8cL2WOHM817fNloUF
 bRJsslHS7zn51K8eZee/SERyxtjaG9PT8mU/+Iz6VtMcwkYZgkiVusJE1xYp8IpK3c
 Y7pJgKlcI/1XyLYRlU4875q9xrd8YpE2GDuJM3JPykPxcZ+5gKYBq/0Zl5nJ/pZvRr
 7iH+PfMh+QvJHiDK9j99EYhdStd2dpM7vx3ND4d8ntZqm8bBB7rXitiWgoecnzTKQk
 oBFQNYyCMINqA==
Date: Fri, 15 Jan 2021 08:56:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/7] Rid W=1 warnings in Ethernet
Message-ID: <20210115085645.0f27864a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210115133848.GK3975472@dell>
References: <20210113164123.1334116-1-lee.jones@linaro.org>
 <20210113183551.6551a6a2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210114083349.GI3975472@dell>
 <20210114091453.30177d20@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210114195422.GB3975472@dell> <20210115111823.GH3975472@dell>
 <bc775cc3-fda3-0280-5f92-53058996f02f@csgroup.eu>
 <20210115133848.GK3975472@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Paul Durrant <paul@xen.org>, Kurt Kanzenbach <kurt@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Cammaert <pc@denkart.be>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.ibm.com>, Wei Liu <wei.liu@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Utz Bacher <utz.bacher@de.ibm.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Santiago Leon <santi_leon@yahoo.com>, xen-devel@lists.xenproject.org,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Daris A Nevil <dnevil@snmc.com>,
 Lijun Pan <ljp@linux.ibm.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
 Nicolas Pitre <nico@fluxnic.net>, Geoff Levand <geoff@infradead.org>,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erik Stahlman <erik@vt.edu>, John Allen <jallen@linux.vnet.ibm.com>,
 Dany Madden <drt@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Russell King <rmk@arm.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 15 Jan 2021 13:38:48 +0000 Lee Jones wrote:
> Okay, so what would you like me to do?  Would you like me to re-submit
> the set based only on net-next

Yes, rebase your patches on net-next, recheck everything builds okay
and resubmit. You should always develop against the tree that will
merge your patches. I appreciate for your janitorial work using
linux-next is more expedient, but as you can see it causes trouble,
this is not the first time your patches don't apply to net-next IIRC.
