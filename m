From: tom_gall@vnet.ibm.com
Message-ID: <3A6C822F.7DB50A58@vnet.ibm.com>
Date: Mon, 22 Jan 2001 18:55:43 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: Tom Gall <tgall@rochcivictheatre.org>
CC: Troy Benjegerdes <hozer@drgw.net>, Dan Malek <dan@mvista.com>,
        linuxppc_commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net> <3A6BB971.7F128273@rochcivictheatre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Gall wrote:
>
> Troy Benjegerdes wrote:
>
> > On Fri, Jan 19, 2001 at 09:27:44PM -0500, Dan Malek wrote:
> > >
> > > I just heard about the bug Tom Gall fixed in "context_overflow"
> > > by testing for current->mm == NULL.
> > >
> > > I believe the proper solution is to use 'current->active_mm'
> > > instead of 'current->mm' (and you never get a null pointer).
> > > This way, the proper 'active' context is updated with a new
> > > context even though a kernel thread has stolen it from somewhere
> > > else to use.  I think skipping the selection of a new context
> > > in this case could be logically incorrect for some PowerPC cores.
> >
> > Since this got no response, I'm cross-posting to linuxppc-commit.
>
> I will look into this tomorrow.  It's an important fix, I don't want to rush.

Hi All,

  Ok here's the explaination and I beg forgivness if this isn't clear or needs
more filled in.

  current->mm I believe is correct. active_mm for tasks in user space just point
back to mm. kernel space tasks will have an mm of NULL yet their active_mm will
point back to the last user space task they ran.

  The reason for this patch is in the case where the idle task comes in on one
processor and on another processor it has encountered a context overflow. The
idle task on processor 0 detects the overflow as well and that's when things get
interesting, and why the change.

  So anyway that's the situation from my neck of the woods. These other
processor cores make me worried. What cores are you refering too? Are they SMP?
How and in what ways are they different?

  Many thanks to Pat McCarthy who is my local guru on this topic and also the
author of the fix in question.

  Regards,

  Tom
--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
