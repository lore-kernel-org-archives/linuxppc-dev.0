To: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pci_unmap_single() and CONFIG_NOT_COHERENT_CACHE
References: <FA06AA2C99BCD511951200005A99441001E3F16E@irvexch1.sextantifs.com>
From: Roland Dreier <roland@topspin.com>
Date: 09 May 2003 11:28:12 -0700
In-Reply-To: <FA06AA2C99BCD511951200005A99441001E3F16E@irvexch1.sextantifs.com>
Message-ID: <52el38km9v.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Allen> I noticed in pci.h that pci_unmap_single() is a null
    Allen> function. (essentially does nothing) Shouldn't is call
    Allen> consistent_sync() so that flush_dcache_range() is called?

No, the cache invalidate or flush has to happen when pci_map_single()
is used.  There's nothing to do after the DMA is done (which is when
pci_unmap_single() gets called).

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
