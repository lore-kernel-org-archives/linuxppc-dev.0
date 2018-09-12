Return-Path: <lucien.xin@gmail.com>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429Bfc0Pw8zF3BY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:27:51 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id p129-v6so1562402ite.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 23:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <9183876a4a8ff0099686521d60f395a5230b67ed.1536401712.git.lucien.xin@gmail.com>
 <20180911.230105.563027666901362955.davem@davemloft.net>
In-Reply-To: <20180911.230105.563027666901362955.davem@davemloft.net>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 12 Sep 2018 14:27:38 +0800
Message-ID: <CADvbK_cH72mJmXTQMmitxffthS1=v4KksKTibK1ytWnz7Aq5Wg@mail.gmail.com>
Subject: Re: [PATCH net] powerpc: use big endian to hash len and proto in
 csum_ipv6_magic
To: davem <davem@davemloft.net>
Cc: network dev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Roopa Prabhu <roopa@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2018 at 2:01 PM David Miller <davem@davemloft.net> wrote:
>
> From: Xin Long <lucien.xin@gmail.com>
> Date: Sat,  8 Sep 2018 18:15:12 +0800
>
> > The function csum_ipv6_magic doesn't convert len and proto to big
> > endian before doing ipv6 csum hash, which is not consistent with
> > RFC and other arches.
> >
> > Jianlin found it when ICMPv6 packets from other hosts were dropped
> > in the powerpc64 system.
> >
> > This patch is to fix it by using instruction 'lwbrx' to do this
> > conversion in powerpc32/64 csum_ipv6_magic.
> >
> > Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> > Reported-by: Jianlin Shi <jishi@redhat.com>
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
>
> Xin, please address the feedback you were given.
Christophe posted another one,
https://lore.kernel.org/patchwork/patch/983905/

Sorry, I didn't notice netdev wasn't in its CC-list.
