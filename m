Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5CC11A0010
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:26:16 +1000 (EST)
Message-ID: <1404041166.31323.2.camel@pasglop>
Subject: Re: [PATCH 0/6] Use virtual page class key protection mechanism for
 speeding up guest page fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 29 Jun 2014 21:26:06 +1000
In-Reply-To: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-06-29 at 16:47 +0530, Aneesh Kumar K.V wrote:

> To achieve the above we use virtual page calss protection mechanism for
> covering (2) and (3). For both the above case we mark the hpte
> valid, but associate the page with virtual page class index 30 and 31.
> The authority mask register is configured such that class index 30 and 31
> will have read/write denied. The above change results in a key fault
> for (2) and (3). This allows us to forward a NO_HPTE fault directly to guest
> without doing the expensive hash pagetable lookup.

So we have a measurable performance benefit (about half a second out of
8) but you didn't explain the drawback here which is to essentially make
it impossible for guests to exploit virtual page class keys, or did you
find a way to still make that possible ?

As it-is, it's not a huge issue for Linux but we might have to care with
other OSes that do care...

Do we have a way in PAPR to signify to the guest that the keys are not
available ?

Cheers,
Ben.
