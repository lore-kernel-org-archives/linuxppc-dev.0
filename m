To: Jeff Mintz <jmintz@ghs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Network problem when using jtag debugger on EP8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Nov 2003 17:16:37 PST."
             <3FBD6775.C471A57B@ghs.com>
Date: Fri, 21 Nov 2003 16:51:15 +0100
Message-Id: <20031121155120.8A52BC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jeff,

in message <3FBD6775.C471A57B@ghs.com> you wrote:
>
> using a COP JTAG debugger.  I am encountering a behavior where when I halt
> the kernel, and resume, the kernel's ability to access the network seems to
> be disturbed.  I am wondering if anyone has seen something like this before.

Yes, we have seen this before. It is kind of a know problem.

> My primary goal is to fix Case 1.  I do not want to lose network access
> when I halt the kernel when it is idle.  Case 2 gives me hope that this
> is possible, because this is a case where I can halt the Linux kernel
> without disturbing the network access.
>
> The JTAG debugger I am using is a Green Hills Probe.  I have also tried
> with
> an Agilent E5900B Emulation Probe and seen similar behavior.

We use the BDI2000, and see the same. This is independed of the brand
of JTAG debugger used.

> Some questions:
> - Has anyone seen this before?  If so, is there a known remedy or
> workaround?  (For example, is there a kernel patch?  Is there a way to
> recover from this slowed network state?)  If not, does anyone have
> a theory to explain why I am seeing this behavior?

Yes, we have seen this.

Here is the theory:

When the debugger halts the CPU, it does NOT stop the  CPM.  Actually
ther  eis no way to stop the CPM. So if you have set up your ethernet
driver and provided it with a list of  buffer  descriptors,  the  CPM
will  continue to receive packets from the net and stuff theminto the
avialiable buffers. But when the CPU is stopped (in debug mode), than
the  coherence  between  cache  and  external  memory  is  no  longer
maintained.  The CPM during that time continues to work as programmed
and uses it's BDs sequentially, but the cache does not  get  updated.
When  the  CPU resumes operation, the cache contents is incorrect and
this is the cause of the driver problem.

We implemented a workaround once, but I don;t think we checked it  in
into  our  source  tree  because  it  involves  a certail performance
overhead (although it was quite useful during debugging).

If you're interested I think I can dig it out again.

> - Does this occur on the BDI2000 debugger?  I don't have access to one

Yes, it does.

> those, but I hear that is the best JTAG debugger for Linux.  If anyone can

Yes, it is :-)

But this is a problem of the CPU/CPM, not of the debugger.

> - Is there any reason to think that the scenario I described in Case 1,
> halting the target while at the shell prompt, is something that users
> typically don't do (and hence, I shouldn't worry about it)?

The easiest way to avoid the problem is to use  a  separated  network
for  the target - if only the target itself accesses the net (for NFS
root operation) all traffic will stop when you stop  the  CPU  -  but
make  sure there are no broadcast packets on it (i.e. don't work in a
windoze environment).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A witty saying proves nothing, but saying  something  pointless  gets
people's attention.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
