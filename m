Return-Path: <SRS0=VNWk=56=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23307C2BBC7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49992076D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 12:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49992076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 491lpC34qNzDqfF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Apr 2020 22:55:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=elvis.franken.de (client-ip=193.175.24.41; helo=elvis.franken.de;
 envelope-from=tsbogend@alpha.franken.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=alpha.franken.de
X-Greylist: delayed 985 seconds by postgrey-1.36 at bilbo;
 Tue, 14 Apr 2020 22:09:25 AEST
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by lists.ozlabs.org (Postfix) with ESMTP id 491kn15K2GzDqbg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2020 22:09:25 +1000 (AEST)
Received: from uucp (helo=alpha)
 by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
 id 1jOK7V-0002BV-00; Tue, 14 Apr 2020 13:52:49 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 68F61C0108; Tue, 14 Apr 2020 13:52:35 +0200 (CEST)
Date: Tue, 14 Apr 2020 13:52:35 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost: do not enable VHOST_MENU by default
Message-ID: <20200414115235.GA13675@alpha.franken.de>
References: <20200414024438.19103-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414024438.19103-1-jasowang@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailman-Approved-At: Tue, 14 Apr 2020 22:51:52 +1000
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
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 geert@linux-m68k.org, Paul Mackerras <paulus@samba.org>,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 14, 2020 at 10:44:38AM +0800, Jason Wang wrote:
> We try to keep the defconfig untouched after decoupling CONFIG_VHOST
> out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
> ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
> default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
> without the caring of CONFIG_VHOST.
> 
> But this will leave a "CONFIG_VHOST_MENU=y" in all defconfigs and even
> for the ones that doesn't want vhost. So it actually shifts the
> burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
> not set". So this patch tries to enable CONFIG_VHOST explicitly in
> defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  arch/mips/configs/malta_kvm_defconfig  |  1 +

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
