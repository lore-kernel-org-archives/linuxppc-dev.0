Return-Path: <nish.aravamudan@gmail.com>
Received: from mail-vc0-x22a.google.com (mail-vc0-x22a.google.com
 [IPv6:2607:f8b0:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0AB51A07E8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 03:42:32 +1000 (EST)
Received: by mail-vc0-f170.google.com with SMTP id lf12so7862926vcb.29
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 10:42:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140718112039.GA8383@htj.dyndns.org>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
 <20140718112039.GA8383@htj.dyndns.org>
Date: Fri, 18 Jul 2014 10:42:29 -0700
Message-ID: <CAOhV88PyBK3WxDjG1H0hUbRhRYzPOzV8eim5DuOcgObe-FtFYg@mail.gmail.com>
Subject: Re: [RFC 0/2] Memoryless nodes and kworker
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Tejun Heo <tj@kernel.org>
Content-Type: multipart/alternative; boundary=001a11c3cef2048c0804fe7b484c
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Jiang Liu <jiang.liu@linux.intel.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c3cef2048c0804fe7b484c
Content-Type: text/plain; charset=UTF-8

Hi Tejun,

On Fri, Jul 18, 2014 at 4:20 AM, Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Jul 17, 2014 at 04:09:23PM -0700, Nishanth Aravamudan wrote:
> > [Apologies for the large Cc list, but I believe we have the following
> > interested parties:
> >
> > x86 (recently posted memoryless node support)
> > ia64 (existing memoryless node support)
> > ppc (existing memoryless node support)
> > previous discussion of how to solve Anton's issue with slab usage
> > workqueue contributors/maintainers]
>
> Well, you forgot to cc me.

Ah I'm very sorry! That's what I get for editing e-mails... Thank you for
your reply!

> ...
> > It turns out we see this large slab usage due to using the wrong NUMA
> > information when creating kthreads.
> >
> > Two changes are required, one of which is in the workqueue code and one
> > of which is in the powerpc initialization. Note that ia64 may want to
> > consider something similar.
>
> Wasn't there a thread on this exact subject a few weeks ago?  Was that
> someone else?  Memory-less node detail leaking out of allocator proper
> isn't a good idea.  Please allow allocator users to specify the nodes
> they're on and let the allocator layer deal with mapping that to
> whatever is appropriate.  Please don't push that to everybody.

I didn't send anything for the workqueue logic anytime recently. Jiang sent
out a patchset for x86 memoryless node support, which may have touched
kernel/workqueue.c.

So, to be clear, this is not *necessarily* about memoryless nodes. It's
about the semantics intended. The workqueue code currently calls
cpu_to_node() in a few places, and passes that node into the core MM as a
hint about where the memory should come from. However, when memoryless
nodes are present, that hint is guaranteed to be wrong, as it's the nearest
NUMA node to the CPU (which happens to be the one its on), not the nearest
NUMA node with memory. The hint is correctly specified as cpu_to_mem(),
which does the right thing in the presence or absence of memoryless nodes.
And I think encapsulates the hint's semantics correctly -- please give me
memory from where I expect it, which is the closest NUMA node.

I guess we could also change tsk_fork_get_node to return
local_memory_node(tsk->pref_node_fork), but that can be a bit expensive, as
it generates a new zonelist each time to determine the first fallback node.
We get the exact same semantics (because cpu_to_mem() caches the result of
local_memory_node) by using cpu_to_mem directly.

Again, apologies for not Cc'ing you originally.

-Nish

--001a11c3cef2048c0804fe7b484c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Tejun,<br><br>On Fri, Jul 18, 2014 at 4:20 AM, Tej=
un Heo &lt;<a href=3D"mailto:tj@kernel.org">tj@kernel.org</a>&gt; wrote:<br=
>&gt;<br>&gt; On Thu, Jul 17, 2014 at 04:09:23PM -0700, Nishanth Aravamudan=
 wrote:<br>
&gt; &gt; [Apologies for the large Cc list, but I believe we have the follo=
wing<br>&gt; &gt; interested parties:<br>&gt; &gt;<br>&gt; &gt; x86 (recent=
ly posted memoryless node support)<br>&gt; &gt; ia64 (existing memoryless n=
ode support)<br>
&gt; &gt; ppc (existing memoryless node support)<br>&gt; &gt; previous disc=
ussion of how to solve Anton&#39;s issue with slab usage<br>&gt; &gt; workq=
ueue contributors/maintainers]<br>&gt;<br>&gt; Well, you forgot to cc me.<b=
r>
<br>Ah I&#39;m very sorry! That&#39;s what I get for editing e-mails... Tha=
nk you for your reply!<br><br>&gt; ...<br>&gt; &gt; It turns out we see thi=
s large slab usage due to using the wrong NUMA<br>&gt; &gt; information whe=
n creating kthreads.<br>
&gt; &gt;<br>&gt; &gt; Two changes are required, one of which is in the wor=
kqueue code and one<br>&gt; &gt; of which is in the powerpc initialization.=
 Note that ia64 may want to<br>&gt; &gt; consider something similar.<br>
&gt;<br>&gt; Wasn&#39;t there a thread on this exact subject a few weeks ag=
o? =C2=A0Was that<br>&gt; someone else? =C2=A0Memory-less node detail leaki=
ng out of allocator proper<br>&gt; isn&#39;t a good idea. =C2=A0Please allo=
w allocator users to specify the nodes<br>
&gt; they&#39;re on and let the allocator layer deal with mapping that to<b=
r>&gt; whatever is appropriate. =C2=A0Please don&#39;t push that to everybo=
dy.<br><br>I didn&#39;t send anything for the workqueue logic anytime recen=
tly. Jiang sent out a patchset for x86 memoryless node support, which may h=
ave touched kernel/workqueue.c.<br>
<br>So, to be clear, this is not *necessarily* about memoryless nodes. It&#=
39;s about the semantics intended. The workqueue code currently calls cpu_t=
o_node() in a few places, and passes that node into the core MM as a hint a=
bout where the memory should come from. However, when memoryless nodes are =
present, that hint is guaranteed to be wrong, as it&#39;s the nearest NUMA =
node to the CPU (which happens to be the one its on), not the nearest NUMA =
node with memory. The hint is correctly specified as cpu_to_mem(), which do=
es the right thing in the presence or absence of memoryless nodes. And I th=
ink encapsulates the hint&#39;s semantics correctly -- please give me memor=
y from where I expect it, which is the closest NUMA node.<br>
<br></div><div>I guess we could also change tsk_fork_get_node to return loc=
al_memory_node(tsk-&gt;pref_node_fork), but that can be a bit expensive, as=
 it generates a new zonelist each time to determine the first fallback node=
. We get the exact same semantics (because cpu_to_mem() caches the result o=
f local_memory_node) by using cpu_to_mem directly.<br>
<br>Again, apologies for not Cc&#39;ing you originally.<br><br>-Nish</div><=
/div>

--001a11c3cef2048c0804fe7b484c--
