Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE4F71A007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 10:13:19 +1000 (EST)
Message-ID: <1400631189.3986.145.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 21 May 2014 10:13:09 +1000
In-Reply-To: <537B5D85.3010305@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <537B4740.6090806@suse.de> <20140520124504.GB28441@shangw>
 <537B5D85.3010305@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-20 at 15:49 +0200, Alexander Graf wrote:
> Instead of
> 
>    if (passed_flag)
>      return;
> 
> you would do
> 
>    if (trigger_irqfd) {
>      trigger_irqfd();
>      return;
>    }
> 
> which would be a much nicer, generic interface.

But that's not how PAPR works.

Cheers,
Ben.
