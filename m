Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A410B70D4
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2010 12:33:20 +1100 (EST)
Message-ID: <4CBCF5C9.5070209@windriver.com>
Date: Tue, 19 Oct 2010 09:35:05 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common
	to	elbc	devices
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>	<4CBC0B95.9010300@windriver.com>
	<20101018110631.22d6f081@udp111988uds.am.freescale.net>
In-Reply-To: <20101018110631.22d6f081@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Mon, 18 Oct 2010 16:55:49 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> Looks you always iounmap(fsl_lbc_ctrl_dev->regs) on position 'err' but here
>> of_iomap() is already failed you should skip iounmap() fsl_lbc_ctrl_dev->regs
>> again. So you should improve that as the following on 'err', or layout 'err' in
>> gain.
>> ------
>> 	if(fsl_lbc_ctrl_dev->regs)
>> 		iounmap(fsl_lbc_ctrl_dev->regs);
>>
> 
> It looks like iounmap(NULL) is a no-op, just like kfree(NULL).
> 

Absolutely, I know what you mean :)

But I think we should take care of every line as one normal progress/rule. That
will make us understand easily, and maybe we also would benefit a little good
performance from those codes.

Tiejun

> -Scott
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
