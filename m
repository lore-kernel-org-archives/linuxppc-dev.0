To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 13 Oct 2001 21:20:53 +1000."
             <15304.9109.488577.697206@cargo.ozlabs.ibm.com>
Date: Sun, 14 Oct 2001 17:44:48 +0200
Message-Id: <20011014154453.1829E10887@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Paul,

in message <15304.9109.488577.697206@cargo.ozlabs.ibm.com> you wrote:
>
> Am I right in thinking that you are the author of PPCBoot?

No exactly: PPCBoot is an Open Source project and has many roots  and
authors; but I'm coordinating all the efforts.

> The thing about the wrappers is that they are all maintained in the
> one tree along with the kernel.  If we want to make a change to the
> interface between the wrappers and the kernel we can easily do that in
> a coordinated fashion, without creating any compatibility problems -
> old kernels naturally use the old wrapper and new kernels use the new
> wrapper.  The wrapper can provide any translation necessary between
> what the firmware passes in and what the kernel expects.

That's fine. But there other things to keep in mind, too:

* Especially with embedded systems  the  memory  footprint  is  often
  critical.  Adding an extra bootstrap loader which includes it's own
  versions of functions like serial console driver and de-compression
  code is just wasted memory.

  In systems where a reliable remote software upgrade must be guaran-
  teed you might find even more than one kernel image in the system -
  then the effect of this waste of memory multiplies.

* When porting Linux to new hardware the wrapper adds  an  additional
  layer which must be adapted and ported. If you have PPCBoot running
  on  a  board,  all  that's  needed to "port" Linux to that board is
  copying things like ethernet intialization from the PPCBoot sources
  - since PPCBoot is based on Linux device driver  code,  this  is  a
  simple copy & paste.

* With PPCBoot, you can use the same kernel image on different boards
  without need to recompile it just because you want differend  default
  boot arguments.

* With PPCBoot, you can use the same kernel image in combination with
  different ramdisk images without need to recompile it.

Etc. etc. It was one of our design goals with PPCBoot to get  rid  of
all the (IMHO) unneccessary maintenance of the bootstap loader code.


I can understand that the wrappers make sense for  boards  that  come
with  some  firmware that cannot or shall not be changed; but this is
the only reason I see for it's existence.


Your argumentation sounds as if you expect many frequent  changes  of
the kernel boot interface. Is that true? In sucha case I'd suggest we
spend some more thoughts on that interface before changing it.

> That's great, but I wonder what happens when someone upgrades their
> PPCBoot to your new version and then wants to boot the old 2.4.2
> kernel that they have lying around to check whether it shows a
> particular problem they're chasing.

This is not the first incompatible change we've  seen:  for  instance
the  switch  from passing the clock frequencies in HZ (instead of MHz
as it was before Patch 1.1.1.6) is such an incompatible change of the
kernel interface.

We will deal with it.

> If we absolutely *have* to boot a vmlinux directly without a wrapper,
> then probably the best thing is to use bi_recs and pass in a pointer
> to them, since that is reasonably flexible and can be made to be
> forwards and backwards compatible without too much pain.  Changing to

It was my assumption from the  previous  discussions  that  this  was
going  to  happen. I like it because you have the option to chose the
implementation that fits best: if a wrapper seems appropriate it  can
be  used  easily; if another solution seems simpler this can be used,
too. Enforcing want to be forced to use of a wrapper  in  all  cases.
want.

> this scheme is going to cause considerable pain in the short term,
> though.

I don't see much difference to the status quo: f or all  the  systems
using  a  wrapper  it is a transparent change like any other; for the
other systems it's a new, incompatible  kernel  interface  just  like
what happened with the Mhz / Hz change.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"We don't care.  We don't have to.  We're the Phone Company."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
