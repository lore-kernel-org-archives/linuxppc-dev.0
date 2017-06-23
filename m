Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvQSz1S1dzDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 03:30:27 +1000 (AEST)
Date: Sat, 24 Jun 2017 02:30:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Update multiple kprobes test for
 powerpc
Message-Id: <20170624023021.92f2f90f0e09314ac9bdb87a@kernel.org>
In-Reply-To: <20170622170325.qznheui7eydkdnmv@naverao1-tp.localdomain>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <f49dbddfbc7dee2f68a610bba468c39a4d017feb.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622180738.e97092d4fa6458b9199a03d7@kernel.org>
 <20170622170325.qznheui7eydkdnmv@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jun 2017 22:33:25 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/06/22 06:07PM, Masami Hiramatsu wrote:
> > On Thu, 22 Jun 2017 00:20:28 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > KPROBES_ON_FTRACE is only available on powerpc64le. Update comment to
> > > clarify this.
> > > 
> > > Also, we should use an offset of 8 to ensure that the probe does not
> > > fall on ftrace location. The current offset of 4 will fall before the
> > > function local entry point and won't fire, while an offset of 12 or 16
> > > will fall on ftrace location. Offset 8 is currently guaranteed to not be
> > > the ftrace location.
> > 
> > OK, these part seems good to me.
> > 
> > > 
> > > Finally, do not filter out symbols with a dot. Powerpc Elfv1 uses dot
> > > prefix for all functions and this prevents us from testing some of those
> > > symbols. Furthermore, with the patch to derive event names properly in
> > > the presence of ':' and '.', such names are accepted by kprobe_events
> > > and constitutes a good test for those symbols.
> > 
> > Hmm, the reason why I added such filter was to avoid symbols including
> > gcc-generated suffixes like as .constprop or .isra etc.
> 
> I see.
> 
> I do wonder -- is there a problem if we try probing those symbols? On my 
> local x86 vm, I don't see an issue probing it especially with the 
> previous patch to enable probing with symbols having a '.' or ':'.
> 
> Furthermore, since this is for testing kprobe_events, I feel it is good 
> to try probing those symbols too to catch any weird errors we may hit.

Yes, and that is not what this testcase is aiming to. That testcase should
be a separated one, with correct error handling.

Thank you,

> 
> Thanks for the review!
> - Naveen
> 
> 
> > So if the Powerpc Elfv1 use dot prefix, that is OK, in that case,
> > could you update the filter as "^.*\\..*" ?
> > 
> > Thank you,
> > 
> > > 
> > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > ---
> > >  tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > > index f4d1ff785d67..d209c071b2c0 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> > > @@ -2,16 +2,16 @@
> > >  # description: Register/unregister many kprobe events
> > >  
> > >  # ftrace fentry skip size depends on the machine architecture.
> > > -# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc
> > > +# Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
> > >  case `uname -m` in
> > >    x86_64|i[3456]86) OFFS=5;;
> > > -  ppc*) OFFS=4;;
> > > +  ppc64le) OFFS=8;;
> > >    *) OFFS=0;;
> > >  esac
> > >  
> > >  echo "Setup up to 256 kprobes"
> > > -grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
> > > -head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
> > > +grep t /proc/kallsyms | cut -f3 -d" " | head -n 256 | \
> > > +while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
> > >  
> > >  echo 1 > events/kprobes/enable
> > >  echo 0 > events/kprobes/enable
> > > -- 
> > > 2.13.1
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu <mhiramat@kernel.org>
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
