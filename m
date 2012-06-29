Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 511F9B6FBD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 07:45:48 +1000 (EST)
Message-ID: <1341006336.2563.35.camel@pasglop>
Subject: Re: [PATCH -V1 4/9] arch/powerpc: Use vsid and segment offset to
 represent virtual address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 30 Jun 2012 07:45:36 +1000
In-Reply-To: <1340979457-26018-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1340979457-26018-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-29 at 19:47 +0530, Aneesh Kumar K.V wrote:
>  
> +/* 78 bit power virtual address */
>  struct virt_addr {
> -       unsigned long addr;
> +       unsigned long vsid;
> +       unsigned long seg_off;
>  };

Do we really need to do that ? It's really nasty...

We are trying to add only a few bits, we get 12 for free by just using a
page number (4k based always, not PAGE_SHIFT based btw) no ? That should
get us going for a while....

Cheers,
Ben.
