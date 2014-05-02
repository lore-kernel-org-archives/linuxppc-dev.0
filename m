Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D754140106
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 01:32:48 +1000 (EST)
Message-ID: <1399044759.15726.45.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 4/4] KVM: PPC: Bookehv: Get vcpu's last instruction
 for emulation
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 2 May 2014 10:32:39 -0500
In-Reply-To: <53637D3B.4010205@suse.de>
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-5-git-send-email-mihai.caraman@freescale.com>
 <53636CFA.5050006@suse.de>
 <063D6719AE5E284EB5DD2968C1650D6D0F705051@AcuExch.aculab.com>
 <53637D3B.4010205@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-02 at 13:10 +0200, Alexander Graf wrote:
> On 05/02/2014 12:12 PM, David Laight wrote:
> > You also probably want the page mapped uncached - no point polluting the data
> > cache.

We can't do that without creating an architecturally illegal alias
between cacheable and non-cacheable mappings.

> Do e500 chips have a shared I/D cache somewhere?

Yes.  Only L1 is separate.

-Scott
