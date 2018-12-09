Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E67C07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:55:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E722081F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 22:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E722081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ChP95cfkzDqpM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 09:55:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=stevens-zone.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=stevens-zone.net
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=darren@stevens-zone.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=stevens-zone.net
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ChLw0Vq1zDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:53:11 +1100 (AEDT)
Received: from mintppc.lan ([80.189.87.228]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.163]) with ESMTPA (Nemesis) id
 1Md6V1-1h5SPe3VTP-00aFVs; Sun, 09 Dec 2018 23:47:42 +0100
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Date: Sun, 09 Dec 2018 22:47:15 +0000 (GMT)
Message-ID: <4d015c642f3.12487343@auth.smtp.1and1.co.uk>
In-Reply-To: <4c6da03cac4.3957dfc0@auth.smtp.1and1.co.uk>
References: <4c6da03cac4.3957dfc0@auth.smtp.1and1.co.uk>
User-Agent: YAM/2.9p1 (AmigaOS4; PPC; rv:20140418r7798)
Subject: Re: [PATCH NEXT v2 1/4] powerpc/pasemi: Add PCI initialisation for
 Nemo board.
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:zYdhFo66QQWxeV8zJdO0Eb0Tj9FBYewia4XE42Xs1zQBTrTTf3J
 Ws0LSveW5JlKhS6FKqeUE1BPYUNmGq77GmuOk557lT39U6fuvVLzwLVyEpoNCywTThybs4h
 yKNhu2z3BbdfYtfYsYaX1Qf8md70wj28yoXlQSF8UmQndA98gHAPF+dWHBpBPsuamZkHSG4
 j9rJvM5csfzYrQMAFc8hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WIdBvcVDLIM=:88pmS4ddqYh+vqX0M3MtSG
 ZJuwOXRkbf/VAKpRK8GuvQ81zBEPUhPEBl3CWp2BEVl83Q7sLxs656LVH4LiOcDsW78oBgb7B
 wsBA5hEySqzr/DUKcoLtiaRf0OAjUEwmWa75CcgsN2pE44B9Z+xYOfzAbmZxyne7wkBKpiZzY
 LIhaJXeLC9vCyYdMIpg1pzhActkoCPScAdZQl738S2HKauFTTkkfXdX5RYPvl90Q6ax14hTW7
 bwvhpAZKga21eIn00BkbmfiA850rryN/zFtWtVwSIQH21L6ajDv8Wq6BpRAVH8Ch4lqZ6dnBm
 jghmd9WPdisDtCFiR1nIuwAyC4e0HNUqofYC5dWqwLYWRdX1p5UbYygKsc9U1vW4j2/iaFPoJ
 gr00GVjsW6mStI7XOzo7VhQMnZeG3nognDrA7/i4M8JkwGbcX5rzlLhDjXQ2DgccbSSGDo6r/
 XhwegPkKUGttlmIQNbcsLrgZ5/tIJlRuUv+fJ2fOh8xyorfGxVX1KS+wvGFt+F7kIQ+bF4L+T
 4tulbfYW+JBy8PKq6hch2ZcB2fR2Kg1z3wZdsPQiiolOBdojXIcl0D+fkFYlOcvh34kjpT7XS
 XZ3lOe71rEIuWJBJE3oKOhPL3WpIDYb/F4sGjgPgNxCn98cTnKyDvYx8TsTn5eePCMyuxR0Bd
 rYq5zINbSaJ2sbh62FR2iNWQ1TsE0dGCb4ZzgJwZ8ytpQ70A+vPO7LtXx1IlipfzUJKP82ORf
 3c+8fMvnZxobhF63RMb1rwTq2NVxfgLidaT1DUEE6GMiWouE5GmcH4zpxow=
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
Cc: chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael,

Any comments on these?

On 19/08/2018, Darren Stevens wrote:
> The A-Eon Amigaone X1000's Nemo motherboard has an AMD SB600
> connected to one of the PCI-e root ports on its PaSemi
> Pwrficient 1628M SoC. Normally the SB600 southbridge would be
> connected to a hidden PCI-e port on the system's northbridge,
> and as a result doesn't fully comply with the PCI-e spec.
>     
> Add code to relax the PCI-e detection in both the root port
> and the Linux kernel allowing on board devices to be detected.
>     
> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
>
> ---
>
> Changes made:
>
> v2: Replaced sb600_bus with a define, moved iob_mapbase into 
>     sb600_set_flag()
>     Created some register/Flag names (as I don't have the docs
>     for the PA6T-1682M)

