Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQCmH2yXczDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 00:59:59 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Benjamin LaHaise <bcrl@kvack.org>, linux-next <linux-next@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: build failure after merge of the aio tree
Date: Wed, 16 Mar 2016 14:59:38 +0100
Message-ID: <4892345.flKnDo9XDS@wuerfel>
In-Reply-To: <CAHp75VcxkBTSKY_bVg3jaUPUtcyxKZ14sbu=uJK403xRmTYbbQ@mail.gmail.com>
References: <20160315174634.6766cd88@canb.auug.org.au>
 <15874870.hBfxUomX5V@wuerfel>
 <CAHp75VcxkBTSKY_bVg3jaUPUtcyxKZ14sbu=uJK403xRmTYbbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 16 March 2016 13:12:36 Andy Shevchenko wrote:
> 
> > I've also sent a patch that fixes the link error on ARM and that should
> > work on all other architectures too.
> 
> In case of avr32 signalfd_read() fails. Does your patch help with it as well?
> 
> P.S. Bisecting shows same culprit: 150a0b4905f1 ("aio: add support for
> async openat()")

I don't know. What is the symptom on avr32? My patch only removes the
get_user() instances on 64-bit values and replaces them with a
single copy_from_user() call.

	Arnd
