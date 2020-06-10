Return-Path: <SRS0=USe9=7X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AFFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8311C20734
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="SZcvJGGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8311C20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49hh4B553KzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 19:08:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=81.169.146.161;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=SZcvJGGv; 
 dkim-atps=neutral
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49hh1Z758czDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2020 19:06:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591779979;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=V/KfU/nTqORthPVcQdWEMFg6kLwS51muw3gmi3LY60s=;
 b=SZcvJGGv76Imm/m7VyPj8+w3P+rs5TzJjaAwhzet/OqjOy28Ci5uUj+D3x0k3JdLyv
 LZJ3kom4QLH/iyXymWAJkWssZJxRyW67hheqN0696G23kqcO5WqY0yMPplx3DzaIgOAq
 bHO/e6Lj7OUZQ0wdH+L29eADPlRKqzbIViOiTKzq+C+4jwkMgRZZgTnMPSlRc+Sk7uQN
 EAX5RLlrgSba6DZlcx0aks5mSV/y72G0AhflpqH8UOpFcePLwVReYXIz8HNp9gEOOFCV
 e4KpzrPmiXnY0tIg8PbsWp+lbn/qYKXvgy6SLObijEIIcDTXD72y8+/4HsdTfP6Hm0DM
 GKQQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhULixgof02dbhCpxWMvAhDPENxAg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:7861:bbbd:4630:8cf0]
 by smtp.strato.de (RZmta 46.9.1 AUTH) with ESMTPSA id w06ffew5A96HZ2e
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 10 Jun 2020 11:06:17 +0200 (CEST)
Subject: Re: PowerPC KVM-PR issue
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <f7f1b233-6101-2316-7996-4654586b7d24@csgroup.eu>
 <067BBAB3-19B6-42C6-AA9F-B9F14314255C@xenosoft.de>
 <014e1268-dcce-61a3-8bcd-a06c43e0dfaf@csgroup.eu>
 <7bf97562-3c6d-de73-6dbd-ccca275edc7b@xenosoft.de>
 <87tuznq89p.fsf@linux.ibm.com>
 <f2706f5f-62b8-9c52-08f4-59f91da48fa6@xenosoft.de>
Message-ID: <cf99a8c0-3bad-d089-de54-e02d3dba7f72@xenosoft.de>
Date: Wed, 10 Jun 2020 11:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f2706f5f-62b8-9c52-08f4-59f91da48fa6@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: Darren Stevens <darren@stevens-zone.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10 June 2020 at 00:18 am, Christian Zigotzky wrote:
> Hello,
>
> KVM-PR doesn't work anymore on my Nemo board [1]. I figured out that 
> the Git kernels and the kernel 5.7 are affected.
>
> Error message: Fienix kernel: kvmppc_exit_pr_progint: emulation at 700 
> failed (00000000)
>
> I can boot virtual QEMU PowerPC machines with KVM-PR with the kernel 
> 5.6 without any problems on my Nemo board.
>
> I tested it with QEMU 2.5.0 and QEMU 5.0.0 today.
>
> Could you please check KVM-PR on your PowerPC machine?
>
> Thanks,
> Christian
>
> [1] https://en.wikipedia.org/wiki/AmigaOne_X1000

I figured out that the PowerPC updates 5.7-1 [1] are responsible for the 
KVM-PR issue. Please test KVM-PR on your PowerPC machines and check the 
PowerPC updates 5.7-1 [1].

Thanks

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d38c07afc356ddebaa3ed8ecb3f553340e05c969



