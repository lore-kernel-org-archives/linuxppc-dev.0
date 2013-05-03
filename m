Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A40272C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 23:01:46 +1000 (EST)
Message-ID: <1367586018.4389.67.camel@pasglop>
Subject: Re: [PATCH -V7 02/10] powerpc/THP: Implement transparent hugepages
 for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
Date: Fri, 03 May 2013 23:00:18 +1000
In-Reply-To: <20130503115428.GW13041@truffula.fritz.box>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503045201.GO13041@truffula.fritz.box>
 <1367569143.4389.56.camel@pasglop>
 <20130503115428.GW13041@truffula.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 21:54 +1000, David Gibson wrote:
> > _PAGE_BUSY is more like a read lock. It means it's being hashed, so what
> > is not stable is _PAGE_HASHPTE, slot index, _ACCESSED and _DIRTY. The
> > rest is stable and usually is what pmd_same looks at (though I have a
> > small doubt vs. _ACCESSED and _DIRTY but at least x86 doesn't care since
> > they are updated by HW).
> 
> Ok.  It still seems very odd to me that _PAGE_BUSY would be in the THP
> version of _PAGE_HASHPTE, but not the normal one.

Oh I agree, we should be consistent and it shouldn't be there, I was just
correcting some other aspect of your statement :-)

Cheers,
Ben.
