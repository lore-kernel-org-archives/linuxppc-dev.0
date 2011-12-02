Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 981B1B6F62
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 14:25:36 +1100 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 1 Dec 2011 22:25:33 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB23PTnJ3399802
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2011 22:25:30 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB23PToG004736
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Dec 2011 22:25:29 -0500
Date: Thu, 1 Dec 2011 19:25:25 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][v2] Enable CONFIG_STRICT_DEVMEM support for Powerpc
Message-ID: <20111202032525.GA17615@us.ibm.com>
References: <20111202001141.GA14860@us.ibm.com>
 <1322789207.3729.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322789207.3729.45.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt [benh@kernel.crashing.org] wrote:
| And an additional comment regarding the rtas bit:
| > +int devmem_is_allowed(unsigned long pfn)
| > +{
| > +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
| > +		return 0;
| > +	if (!page_is_ram(pfn))
| > +		return 1;
| > +	if (page_is_rtas(pfn))
| > +		return 1;
| > +	return 0;
| > +}
| 
| This calls it unconditionally... you just broke the build of all !rtas
| platforms. Additionally, putting an extern definition like that in a .c
| file is gross at best....

Oh, Sorry.

| 
| Please instead, put in a header something like
| 
| #ifdef CONFIG_PPC_RTAS
| extern int page_is_rtas(unsigned long pfn);
| #else
| static inline int page_is_rtas(unsigned long pfn) { }
| #endif
| 
| And while at it, call it page_is_rtas_user_buf(); to make it clear what
| we are talking about, ie, not RTAS core per-se but specifically the RMO
| buffer.

Ok. I will rename, move the declaration to <asm/rtas.h> and resend the
incremental patch.

Sukadev
