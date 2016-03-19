Return-Path: <linus971@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qSHYX1HdQzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2016 09:57:52 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id v123so2285551ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Mar 2016 15:57:52 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1458302850.10432.2.camel@ellerman.id.au>
References: <1458302850.10432.2.camel@ellerman.id.au>
Date: Sat, 19 Mar 2016 15:57:48 -0700
Message-ID: <CA+55aFwcVx5+oaBXqFT=+DPeTOx2xUKGr0nJ6GPpxzf6a5wSwA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.6-1 tag
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Igal.Liberman@freescale.com, Zhiqiang.Hou@freescale.com,
 adam.buchbinder@gmail.com, aik@ozlabs.ru, alessio.bogani@elettra.eu,
 andrew.donnellan@au1.ibm.com,
 "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 chenhui.zhao@freescale.com,
 Christophe Leroy <christophe.leroy@c-s.fr>, clombard@linux.vnet.ibm.com,
 cyrilbur@gmail.com,
 david@gibson.dropbear.id.au, dongsheng.wang@freescale.com,
 dougmill@linux.vnet.ibm.com, Torsten Duwe <duwe@lst.de>, duwe@suse.de,
 fbarrat@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
 Ian Munsie <imunsie@au1.ibm.com>, Jeremy Kerr <jk@ozlabs.org>, joel@jms.id.au,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, leoyang.li@nxp.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 luis.henriques@canonical.com, maddy@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, Michael Neuling <mikey@neuling.org>,
 mrochs@linux.vnet.ibm.com,
 oss@buserror.net, Paul Mackerras <paulus@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 qiang.zhao@nxp.com, raghav.dogra@nxp.com, ruscur@russell.cc,
 saurabh.truth@gmail.com, sjitindarsingh@gmail.com, stewart@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com,
 Richard Yang <weiyang@linux.vnet.ibm.com>, xinhui.pan@linux.vnet.ibm.com,
 xuelin.shi@nxp.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2016 at 5:07 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> I couldn't convince git request-pull to generate a sane diffstat below, it
> seems to be confused because I merged powerpc-4.5-4 into my next.

Yes, if there are multiple merge bases (particularly cross-merges, but
you can get it just from internal merges of work that started at
different points), a plain "git diff" will often be unable to give
reasonable results.

> So I just did the merge and took that diffstat. Hopefully that makes sense.

Yes, that's the way to get a reliable diff if you have more complex history.

Some people do that merge by default (ie both the networking tree and
the ARM SoC trees tend to do this), not just to get the reliable diff,
but also to inform me of the conflicts that they encountered.

So it's actually "good practice", as long as you then send me the
pre-merge state - I still want to do the merge myself to see what's
going on.

Exactly like you did, in other words.

At the same time, it's absolutely not required. So if the diffstat
looks odd, you can just send me the incorrect diffstat and just tell
me so.  Yes, I will get a different diffstat when I do the merge, but
I can still tell that it's what you intended to send me by just doing
the non-merge diff.

In general, the trees I pull tend to fall into two main camps:

 (a) "simple history" maintainers

     These maintainers don't pull from sub-maintainers, and that don't
ever hit the issue with "plain git diff cannot give the right end
result".

     The plain "git diff" that pull-request does always works for the
simple history case, and I really don't expect these maintainers to do
merges for me anyway, since they should have linear history and just
generally use a simplified git model.

     In fact, I will complain loudly if they start doing odd things
like cross-merging etc, because they really really shouldn't, and they
aren't ready and aware of the pain they cause.

 (b) the "complex top-level maintainer"

     This group does pulls of their own from submaintainers, and can
have fairly complex histories just within their own tree.

     This group can encounter the "oops, I don't have a simple merge
base, so 'gid diff' will not give sane results" situation.

     This group is also usually savvy enough that they then can handle
it and do the whole "let's do a test merge to see what conflicts I
get, and get a good diff even if there are multiple merge bases".

Of course, it's not _really_ that black-and-white, but it's a
simplified model and close enough.

Basically you should never hit that complicated case unless you are
already using workflows that means that you can handle it, and by then
you usually also end up understanding why clean history and avoiding
back-merges is a good idea etc.

Welcome to that second group.

               Linus
