Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B273EB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2012 16:31:29 +1100 (EST)
To: Mai La <mla@apm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] powerpc/44x: Fix PCI MSI support for Maui APM821xx
 SoC and Bluestone board
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <1331524918-22515-1-git-send-email-mla@apm.com>
References: <1331524918-22515-1-git-send-email-mla@apm.com>
Date: Mon, 12 Mar 2012 06:31:12 +0100
Message-Id: <20120312053112.B5643202BE9@gemini.denx.de>
Cc: Michael Neuling <mikey@neuling.org>, open-source-review@apm.com,
 Tirumala R Marri <tmarri@apm.com>, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Mai La,

In message <1331524918-22515-1-git-send-email-mla@apm.com> you wrote:
> This patch consists of:
> - Enable PCI MSI as default for Bluestone board
> - Change definition of number of MSI interrupt as it depends on SoC
> - Fix returning ENODEV as finding MSI node
> - Fix MSI physical high and low address
> - Keep MSI data logically
> 
> Signed-off-by: Mai La <mla@apm.com>

This is an updated version of your patch of March 09, right -
http://article.gmane.org/gmane.linux.kernel/1264255  ??

If so, you should mark ot as patch V2 in the Subject:, and add a
description of what you changed.

> -	SDR0_WRITE(sdr_addr, (u64)res.start >> 32);	 /*HIGH addr */
> -	SDR0_WRITE(sdr_addr + 1, res.start & 0xFFFFFFFF); /* Low addr */
> -
> +	mtdcri(SDR0, *sdr_addr, upper_32_bits(res.start));	/*HIGH addr */
> +	mtdcri(SDR0, *sdr_addr + 1, lower_32_bits(res.start));	/* Low addr */
...
> +	msi->msi_addr_hi = (u32)(msi_phys >> 32);
> +	msi->msi_addr_lo = (u32)(msi_phys & 0xffffffff);

Is there any reason for not using upper_32_bits() / lower_32_bits()
consistently?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Real computer scientists despise the idea of actual  hardware.  Hard-
ware has limitations, software doesn't. It's a real shame that Turing
machines are so poor at I/O.
