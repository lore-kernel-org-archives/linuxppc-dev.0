Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 451AC1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 23:52:03 +1100 (AEDT)
Date: Fri, 8 Jan 2016 09:51:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 jolsa@redhat.com, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20160108125157.GC19314@kernel.org>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
 <20151217050714.GB21524@naverao1-tp.ibm.com>
 <20151217121939.GH19926@kernel.org>
 <20160107065709.GA2459@naverao1-tp.ibm.com>
 <20160107203957.GG18457@kernel.org>
 <20160108053854.GB2459@naverao1-tp.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160108053854.GB2459@naverao1-tp.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Jan 08, 2016 at 11:09:35AM +0530, Naveen N. Rao escreveu:
> On 2016/01/07 05:39PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 07, 2016 at 12:28:15PM +0530, Naveen N. Rao escreveu:
> > > On 2015/12/17 09:19AM, Arnaldo Carvalho de Melo wrote:
> > > > Em Thu, Dec 17, 2015 at 10:37:14AM +0530, Naveen N. Rao escreveu:
> > > > > On 2015/12/17 09:29AM, Wang Nan wrote:
> > > > > > The whole thread is:
> > > > > > 
> > > > > > [PATCH v3 0/3] perf build: PowerPC: Fix build breakage due to libbpf:
> > > > > > http://lkml.kernel.org/g/1450150557-127942-1-git-send-email-wangnan0@huawei.com
> > > > > > 
> > > > > > [PATCH v3 1/3] perf tools: Fix PowerPC native building
> > > > > > http://lkml.kernel.org/g/1450150557-127942-2-git-send-email-wangnan0@huawei.com
> > > > > > 
> > > > > > [PATCH v3 2/3] tools: Move Makefile.arch from perf/config to tools/scripts
> > > > > > http://lkml.kernel.org/g/1450150557-127942-3-git-send-email-wangnan0@huawei.com
> > > > > > 
> > > > > > [PATCH v3 3/3] perf: bpf: Fix build breakage due to libbpf
> > > > > > http://lkml.kernel.org/g/1450150557-127942-4-git-send-email-wangnan0@huawei.com
> > > > > > 
> > > > > > and [PATCH v3 3/3] breaks local building because the usage of "srctree", and
> > > > 	     ^^
> > > > > You mean v4 here.
> > > > 
> > > > > Anyway, now that you've sent v4, it should be much clearer.
> > > > 
> > > > Right, I should've read it more thoroughly, but anyway, I'll process it
> > > > today.
> > > 
> > > Bump.
> > > 
> > > Arnaldo,
> > > Can you please push at least the initial 3 patches of this for v4.4?  
> > > Wang Nan has posted v6 here:
> > > http://thread.gmane.org/gmane.linux.kernel/2110626
> > 
> > So I tried it again today, from the v6, the latest patch with that
> > subject line in my inbox, and I get this, after applying the first three
> > patches:
> > 
> > [acme@zoo linux]$ make -C tools clean > /dev/null
> > [acme@zoo linux]$ make -C tools/perf build-test
> 
> Thanks, and sorry for the slip-up there - I should've caught that.

The important thing is that it gets caught before getting to Ingo, let
alone Linus, but if you get it before me, I'd appreciate as well 8-)

- Arnaldo
 
> > make: Entering directory '/home/git/linux/tools/perf'
> > Testing Makefile
> > tests/make:15: /scripts/Makefile.arch: No such file or directory
> > make[2]: *** No rule to make target '/scripts/Makefile.arch'.  Stop.
> > tests/make:5: recipe for target 'all' failed
> > make[1]: *** [all] Error 2
> > Makefile:81: recipe for target 'build-test' failed
> > make: *** [build-test] Error 2
> > make: Leaving directory '/home/git/linux/tools/perf'
> > [acme@zoo linux]$
> > 
> > [acme@zoo linux]$ git log --oneline | head -10
> 
> FWIW, git log --oneline -10 works too :-)

Thanks! perf also has this syndrom of wanting to do a lot of things 8-)
