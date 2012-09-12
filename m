Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3D832C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:40:52 +1000 (EST)
Received: by ieje13 with SMTP id e13so2358964iej.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 20:40:50 -0700 (PDT)
Date: Tue, 11 Sep 2012 20:38:11 -0700
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Message-ID: <20120912033811.GA1886@lizard>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <504F82C1.2000907@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C176E94@039-SN1MPN1-002.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C176E94@039-SN1MPN1-002.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2012 at 03:19:18AM +0000, Huang Changming-R66093 wrote:
[...]
> I don't think it is the best way to do it.  For the VVN2.2 or older,
> some silicon support this feature (mpc8536 and p2020), but other
> silicones don't support it (e.g. p4080, p102x).  Though, the current
> p5/p4/p3 has supported this feature, can we sure the future silicon
> support it?  So I think the best way is to specify it in device tree
> as 'sdhci,auto-cmd12'

In addition to your current patches, you could just add another patch
that blacklists affected SOC revisions based on the info from PVR/SVR.

For example, see gfar_detect_errata() in
drivers/net/ethernet/freescale/gianfar.c.

That way you could help users that don't have the newest device trees.

Thanks,
Anton.
