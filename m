Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
	[66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id 0775FB6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 08:59:09 +1000 (EST)
Subject: Re: linux-next: build failure in Linus' tree
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110830083218.1819a5d73c3a33e5053e8312@canb.auug.org.au>
References: <20110829104451.1c777e24ff72823d1e399f12@canb.auug.org.au>
	<20110830083218.1819a5d73c3a33e5053e8312@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Aug 2011 15:50:42 -0700
Message-ID: <1314658242.3078.18.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Cc: "J. Bruce Fields" <bfields@redhat.com>, linux-parisc@vger.kernel.org,
	NeilBrown <neilb@suse.de>, Linus <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-30 at 08:32 +1000, Stephen Rothwell wrote:
> Hi Linus,
> 
> On Mon, 29 Aug 2011 10:44:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the fixes tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > arch/powerpc/kernel/built-in.o: In function `.sys_call_table':
> > (.text+0xbd00): undefined reference to `.sys_nfsservctl'
> > arch/powerpc/kernel/built-in.o: In function `.sys_call_table':
> > (.text+0xbd08): undefined reference to `.compat_sys_nfsservctl'
> > 
> > Caused by commit f5b940997397 ("All Arch: remove linkage for
> > sys_nfsservctl system call") which also missed parisc.
> > 
> > I will apply this patch for today:
> 
> Will you please appply this?  (repeated for ease of inclusion)
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 29 Aug 2011 10:38:57 +1000
> Subject: [PATCH] remove remaining references to nfsservctl
> 
> These were missed in commit f5b940997397 "All Arch: remove linkage
> for sys_nfsservctl system call" due to them having no sys_ prefix
> (presumably).
> 
> Cc: NeilBrown <neilb@suse.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for finding this ... definitely acked by me if necessary.

James
