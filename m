Return-Path: <djbw@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2600B2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 01:26:10 +1000 (EST)
Message-ID: <1346251975.27020.2.camel@localhost.localdomain>
Subject: Re: [PATCH v7 0/8] Raid: enable talitos xor offload for improving
 performance
From: Dan Williams <djbw@fb.com>
To: Liu Qiang-B32616 <B32616@freescale.com>
Date: Wed, 29 Aug 2012 07:52:55 -0700
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70FC3CA@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1344500375-8457-1-git-send-email-qiang.liu@freescale.com>
 <20120809170307.GG14264@ovro.caltech.edu>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70E3D47@039-SN2MPN1-013.039d.mgd.msft.net>
 <CAA9_cme4tHrx14JaSaHwgcGq79qQK5bv8E205fbC3ega5OpUiQ@mail.gmail.com>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70FC3CA@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "arnd@arndb.de" <arnd@arndb.de>, "Ira W.
 Snyder" <iws@ovro.caltech.edu>, "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-08-29 at 11:15 +0000, Liu Qiang-B32616 wrote:
> Hi Dan,
> 
> Ping?
> Can you apply these patches? Thanks.
> 

I'm working my way through them.

The first thing I notice is that xor_chan->desc_lock is taken
inconsistently.  I.e. spin_lock_irqsave() in talitos_process_pending()
and spin_lock_bh() everywhere else.  Have you run these patches with
lockdep?

--
Dan
