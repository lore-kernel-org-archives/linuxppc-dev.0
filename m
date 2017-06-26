Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxMYR4dDyzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 07:26:03 +1000 (AEST)
To: Arnd Bergmann <arnd@arndb.de>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-3-logang@deltatee.com>
 <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Suresh Warrier <warrier@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0746dbb0-9fc1-d24c-89c0-b079a3cd0c7b@deltatee.com>
Date: Mon, 26 Jun 2017 15:25:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 2/7] iomap: implement ioread64 and iowrite64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/26/2017 2:43 PM, Arnd Bergmann wrote:
> This hardcodes the behavior of include/linux/io-64-nonatomic-hi-lo.h, which
> I find rather confusing, as only about one in five drivers wants this
> behavior.
>
> I'd suggest you don't add it in lib/iomap.c at all for 32-bit architectures,
> but rather use the same logic that we have for readq/writeq in
> io-64-nonatomic-hi-lo.h and io-64-nonatomic-lo-hi.h, adding
> {lo_hi,hi_lo}_{ioread,iowrite}{,be} to the same files, and provide
> the {ioread,iowrite}{,be} macros only if they have not been defined
> at that point.

Thanks Arnd. Yes, I'm already reworking this patchset to do exactly that.

Logan
