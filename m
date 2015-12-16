Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 405E71A0066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 06:42:41 +1100 (AEDT)
Date: Wed, 16 Dec 2015 16:42:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20151216194234.GA19926@kernel.org>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151215114046.GG23726@naverao1-tp.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Dec 15, 2015 at 05:10:46PM +0530, Naveen N. Rao escreveu:
> On 2015/12/15 08:51AM, Wang Nan wrote:
> > From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > 
> > perf build is currently (v4.4-rc5) broken on powerpc:
> > 
> > bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
> > your arch.
> >  #  error __NR_bpf not defined. libbpf does not support your arch.
> >     ^
> > 
> > Fix this by including tools/scripts/Makefile.arch for the proper
> > $ARCH macro. While at it, remove redundant LP64 macro definition.
> > 
> > Also, since libbpf require $(srctree) now, detect the path of
> > srctree like perf.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Wang Nan <wangnan0@huawei.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> > 
> > v3 -> v4: Add srctree detector code so directly run 'make' in libbpf
> >           directory would not cause error.
> 
> Good catch!
> 
> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Trying to apply the patchkit:

[acme@zoo linux]$ make -C tools clean > /dev/null 2>&1
[acme@zoo linux]$ make -C tools/perf build-test
make: Entering directory '/home/git/linux/tools/perf'
Testing Makefile
tests/make:15: /scripts/Makefile.arch: No such file or directory
make[2]: *** No rule to make target '/scripts/Makefile.arch'.  Stop.
tests/make:5: recipe for target 'all' failed
make[1]: *** [all] Error 2
Makefile:81: recipe for target 'build-test' failed
make: *** [build-test] Error 2
make: Leaving directory '/home/git/linux/tools/perf'
[acme@zoo linux]$

What am I doing wrong?

- Arnaldo
