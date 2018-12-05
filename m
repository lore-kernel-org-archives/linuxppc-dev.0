Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43A9C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:58:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5382C208E7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Azvp2XQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5382C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439B0B4DvFzDqMP
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:58:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Azvp2XQL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b85e487f93f41cff5125+5582+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Azvp2XQL"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4391lP5MKyzDqhY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 01:46:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=izkeDFYCg9JW+KZB90A0xHQw2XyUqv1UsTlxLf4A5Rc=; b=Azvp2XQLrZxHxCPYvn04ytyEU
 28PHg8jHB1kW5LUAWpa8HLDBBh5Ziid+KRbI9apZcgAsOv0UHyptqCHwmQM1yMA/Jedq0G7zv7zeh
 SYr8jJn545yOlPSerdEUtVBnHRzp1RyH6wTlP66xkAlqiFEa3h02yrZdBx4cmTVtH1Pv5llj657Br
 Yuo+cuTBtZv6WpPeHo3hvpIwLyabyjAc9K+TLjKtTkNN22iE/FJe5bC2OsVGecMtMDC7KYGyabqFl
 Ohhi5YEhJ71BZR+1bIy+bsUI2jYwnHIA/eQoa6Xs64YlZc3I73e5V0CBEw2fmybN7NTcToM1ZtVLQ
 hqmy+Cx7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gUYPm-000829-8M; Wed, 05 Dec 2018 14:44:38 +0000
Date: Wed, 5 Dec 2018 06:44:38 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] arch: remove redundant generic-y defines
Message-ID: <20181205144438.GA30692@infradead.org>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 06 Dec 2018 07:53:18 +1100
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Daniel Borkmann <daniel@iogearbox.net>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Fenghua Yu <fenghua.yu@intel.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-xtensa@linux-xtensa.org,
 Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greentime Hu <green.hu@gmail.com>,
 nios2-dev@lists.rocketboards.org, Stafford Horne <shorne@gmail.com>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Richard Kuo <rkuo@codeaurora.org>,
 linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Borislav Petkov <bp@alien8.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Ley Foon Tan <lftan@altera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 05, 2018 at 08:28:06PM +0900, Masahiro Yamada wrote:
> Now that Kbuild automatically creates asm-generic wrappers for missing
> mandatory headers, it is redundant to list the same headers in
> generic-y and mandatory-y.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Oh, that is very useful, especially as maintainance of those
generic-y lines has been a mess!

Acked-by: Christoph Hellwig <hch@lst.de>
