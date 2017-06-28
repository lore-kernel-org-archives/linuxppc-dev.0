Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyHY40cMczDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:28:55 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S9Sif0145694
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 05:28:54 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bc8p8kqrc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 05:28:53 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 28 Jun 2017 19:28:51 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5S9Sncd5636546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:28:49 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5S9Skqm009744
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 19:28:47 +1000
Date: Wed, 28 Jun 2017 14:58:46 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/ftrace: Update multiple kprobes test for
 powerpc
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <f49dbddfbc7dee2f68a610bba468c39a4d017feb.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622180738.e97092d4fa6458b9199a03d7@kernel.org>
 <20170622170325.qznheui7eydkdnmv@naverao1-tp.localdomain>
 <20170624023021.92f2f90f0e09314ac9bdb87a@kernel.org>
 <20170624200610.f3aee818b8f6ff2631e0d56a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170624200610.f3aee818b8f6ff2631e0d56a@kernel.org>
Message-Id: <20170628092846.uwc55zuq7dsbrzho@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/24 08:06PM, Masami Hiramatsu wrote:
> On Sat, 24 Jun 2017 02:30:21 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 22 Jun 2017 22:33:25 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > On 2017/06/22 06:07PM, Masami Hiramatsu wrote:
> > > > On Thu, 22 Jun 2017 00:20:28 +0530
> > > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > > 
> > > > > KPROBES_ON_FTRACE is only available on powerpc64le. Update comment to
> > > > > clarify this.
> > > > > 
> > > > > Also, we should use an offset of 8 to ensure that the probe does not
> > > > > fall on ftrace location. The current offset of 4 will fall before the
> > > > > function local entry point and won't fire, while an offset of 12 or 16
> > > > > will fall on ftrace location. Offset 8 is currently guaranteed to not be
> > > > > the ftrace location.
> > > > 
> > > > OK, these part seems good to me.
> > > > 
> > > > > 
> > > > > Finally, do not filter out symbols with a dot. Powerpc Elfv1 uses dot
> > > > > prefix for all functions and this prevents us from testing some of those
> > > > > symbols. Furthermore, with the patch to derive event names properly in
> > > > > the presence of ':' and '.', such names are accepted by kprobe_events
> > > > > and constitutes a good test for those symbols.
> > > > 
> > > > Hmm, the reason why I added such filter was to avoid symbols including
> > > > gcc-generated suffixes like as .constprop or .isra etc.
> > > 
> > > I see.
> > > 
> > > I do wonder -- is there a problem if we try probing those symbols? On my 
> > > local x86 vm, I don't see an issue probing it especially with the 
> > > previous patch to enable probing with symbols having a '.' or ':'.
> > > 
> > > Furthermore, since this is for testing kprobe_events, I feel it is good 
> > > to try probing those symbols too to catch any weird errors we may hit.
> > 
> > Yes, and that is not what this testcase is aiming to. That testcase should
> > be a separated one, with correct error handling.

Ok, I will re-send the patch by changing the pattern.

> 
> Hi Naveen,
> 
> Here is the testcase which I meant above. This may help if there is any
> regression related to this specific issue.

Nice!
I tested this and there are a few small issues on powerpc...

> 
> Thank you,
> 
> -----
> 
> selftests: ftrace: Add a testcase for kprobe event naming
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Add a testcase for kprobe event naming. This testcase
> checks whether the kprobe events can automatically ganerate
> its event name on normal function and dot-suffixed function.
> Also it checks whether the kprobe events can correctly
> define new event with given event name and group name.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_eventname.tc       |   28 ++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> new file mode 100644
> index 0000000..d259031
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# description: Kprobe event auto/manual naming
> +
> +disable_events
> +echo > kprobe_events
> +
> +:;: "Add an event on function without name" ;:
> +
> +FUNC=`grep -m 10 " [tT] [^.]*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`

On powerpc, this always ends up using a blacklisted function. So, I 
think we need a way to find a function that is not black listed.  
However, one of the issues is that debugfs does not show all the address 
ranges that are blacklisted. I am coming up with a way to address that 
and will post patches once I have it working.

With those patches, we should be able to select symbols that are not 
blacklisted.

> +echo p $FUNC > kprobe_events
> +test -d events/kprobes/p_${FUNC}_0 || exit_failure
> +
> +:;: "Add an event on function with new name" ;:
> +
> +echo p:event1 $FUNC > kprobe_events
> +test -d events/kprobes/event1 || exit_failure
> +
> +:;: "Add an event on function with new name and group" ;:
> +
> +echo p:kprobes2/event2 $FUNC > kprobe_events
> +test -d events/kprobes2/event2 || exit_failure
> +
> +:;: "Add an event on dot function without name" ;:
> +
> +FUNC=`grep -m 10 " [tT] .*\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> +echo p $FUNC > kprobe_events
> +EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:` || exit_failure
> +test -d events/$EVENT || exit_failure

Probably good to add 'echo > kprobe_events' at the end just to clean up?


Thanks,
Naveen
