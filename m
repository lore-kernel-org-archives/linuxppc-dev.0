Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E75661A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 20:40:22 +1000 (AEST)
Message-ID: <1441708821.13127.0.camel@ellerman.id.au>
Subject: Re: [Qemu-devel] [PATCH 19/23] userfaultfd: activate syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: bharata@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Sanidhya Kashyap
 <sanidhya.gatech@gmail.com>, linux-mm@kvack.org, Andrea Arcangeli
 <aarcange@redhat.com>, zhang.zhanghailiang@huawei.com, Pavel Emelyanov
 <xemul@parallels.com>, Hugh Dickins <hughd@google.com>, Mel Gorman
 <mgorman@suse.de>, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Andres Lagar-Cavilla
 <andreslc@google.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Dave
 Hansen <dave.hansen@intel.com>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andy
 Lutomirski <luto@amacapital.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Feiner <pfeiner@google.com>
Date: Tue, 08 Sep 2015 20:40:21 +1000
In-Reply-To: <1441696463.4689.1.camel@ellerman.id.au>
References: <1431624680-20153-1-git-send-email-aarcange@redhat.com>
 <1431624680-20153-20-git-send-email-aarcange@redhat.com>
 <20150811100728.GB4587@in.ibm.com> <20150811134826.GI4520@redhat.com>
 <20150812052346.GC4587@in.ibm.com>
 <1441692486.14597.17.camel@ellerman.id.au>
 <20150908063948.GB678@in.ibm.com> <1441696463.4689.1.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-09-08 at 17:14 +1000, Michael Ellerman wrote:
> On Tue, 2015-09-08 at 12:09 +0530, Bharata B Rao wrote:
> > On Tue, Sep 08, 2015 at 04:08:06PM +1000, Michael Ellerman wrote:
> > > Hmm, not for me. See below.
> > > 
> > > What setup were you testing on Bharata?
> > 
> > I was on commit a94572f5799dd of userfault21 branch in Andrea's tree
> > git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
> > 
> > #uname -a
> > Linux 4.1.0-rc8+ #1 SMP Tue Aug 11 11:33:50 IST 2015 ppc64le ppc64le ppc64le GNU/Linux
> > 
> > In fact I had successfully done postcopy migration of sPAPR guest with
> > this setup.
> 
> OK, do you mind testing mainline with the same setup to see if the selftest
> passes.

Ah, I just tried it on big endian and it works. So it seems to not work on
little endian for some reason, /probably/ a test case bug?

cheers
