Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6AFFD2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 02:36:55 +1000 (EST)
Message-ID: <1377535003.3033.6.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last
 system transaction
From: Scott Wood <scottwood@freescale.com>
To: Zhang Haijun <B42677@freescale.com>
Date: Mon, 26 Aug 2013 11:36:43 -0500
In-Reply-To: <521AA947.6080209@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
 <99E897753B6F7048BD8CCDB4661D02E13DF52C@039-SN2MPN1-022.039d.mgd.msft.net>
 <521703AB.8030702@freescale.com>
 <1377272410.20722.46.camel@snotra.buserror.net>
 <521AA947.6080209@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-26 at 09:03 +0800, Zhang Haijun wrote:
> On 08/23/2013 11:40 PM, Scott Wood wrote:
> 
> > On Fri, 2013-08-23 at 14:39 +0800, Zhang Haijun wrote:
> > > Hi, Anton and all
> > > 
> > > Is there any advice on these two patches ?
> > > 
> > > [PATCH 2/4 V2] mmc: esdhc: workaround for dma err in the last system 
> > > transaction
> > > [PATCH 3/4 V3] mmc: esdhc: Correct host version of T4240-R1.0-R2.0.
> > > 
> > > 
> > > [PATCH 1/4 V4] powerpc/85xx: Add support for 85xx cpu type detection
> > > This patch is Act-by Scott.
> > > Patch 4/4 is split to four patches and Act-by Anton.
> > > 
> > > 
> > > Thanks all.
> > > 
> > > 
> > > 
> > [snip]
> > > > > +	if (!(((SVR_SOC_VER(svr) == SVR_T4240) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_B4860) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P1010) && (SVR_REV(svr) == 0x10))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P3041) && (SVR_REV(svr) <= 0x20))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P2041) && (SVR_REV(svr) <= 0x20))
> > > > > ||
> > > > > +		((SVR_SOC_VER(svr) == SVR_P5040) && SVR_REV(svr) == 0x20)))
> > > > > +		return;
> > You need to include variants here.  If P5040 is affected, then P5021 is
> > affected.  If P2041 is affected, then P2040 is affected, etc.
> > 
> > -Scott
> > 
> > 
> Hi, Scott
> 
> This workaround is for CR:ENGR00229586: A-005055, Configs Affected
> only list these soc and its version.
> I was also wonder why only these boards?
> 
> But I can't add soc like P5021 as I think it should be. Maybe there
> are some difference between them.

The only difference between P5040 and P5021 is the number of cores
enabled.  It is physically the same silicon.  Likewise with a lot of
other variants.

-Scott
