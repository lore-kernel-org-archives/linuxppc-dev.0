Date: Tue, 17 Jun 2003 09:15:55 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: lowlat & preeempt
In-Reply-To: <5.1.0.14.2.20030616234808.02ddad50@mail.ebshome.net>
Message-ID: <Pine.LNX.4.56.0306170908310.18398@mag.devdep.sysgo.de>
References: <3EEE93C5.4090302@tait.co.nz> <3EEE93C5.4090302@tait.co.nz>
 <5.1.0.14.2.20030616234808.02ddad50@mail.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 16 Jun 2003, Eugene Surovegin wrote:

> >The low latency patch is now part of the kpreempt patch. A kpreempt
> >patch for 2.4.21-pre1 can be found here:
> >
> >http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/
>
> Are you sure?
>
> preempt-kernel-rml-2.4.21-pre1-1.patch doesn't have
>   - low latency stuff (http://www.zip.com.au/~akpm/linux/schedlat.html)
> or
>   - lock-breaking stuff
> (http://www.kernel.org/pub/linux/kernel/people/rml/lock-break/)

Yes, of course, lock breaking is also needed. I always use both
kpreempt and lock-break. Wrong assumption on my part.

Anyway, with this combination you don't need the low-latency patches
anymore (according to www.tech9.net/rml/linux):

  "With the preemptible kernel, the need for explicit scheduling points, like
  in the low-latency patches, are no more. However, since we can not preempt
  while locks are held, we can take a similar model as low-latency and
  "break" (drop and immediately reacquire) locks to improve system response.
  The trick is finding when and where we can safely break the locks (periods
  of quiescence) and how to safely recover. The majority of the lock
  breaking is in the VM and VFS code. This patch is for users with strong
  system response requirements affected by the worst-case latencies caused
  by long-held locks."

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.de>
Software Engineering

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.de | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
