Date: Mon, 24 Mar 2003 18:42:52 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E7F3BE0.7020300@slac.stanford.edu>
To: Till Straumann <strauman@slac.stanford.edu>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEGIFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> >>>Hi list
> >>>
> -- snip --
>
> >>>  I even
> >>>removed the TLB change bit hack by Tom Rini and everything works.
> >>>
> -- snip --
>
> >
> >I removed the "copy DAR to MD_EPN" part in the DTLB Error handler and my systems
> >runs fine.
> >
>
> How exactly do you know that "everything works fine" ???
>
> Please note that
>
>     a) you may have bug-free hardware.
>     b) you may have a valid TLB entry at the time 'dcbz' is executed.
>     c) you may end up with a bogus mapping but not notice it.

Every time I tried to use dcbz on user space it failed HARD directly.
Whenever I tried to "undo" any hacks that were there to compensate for
buggy dcxx instructions, the kernel would not boot.

Now I can boot and run my app and even run a user space app which clears
memory with dcbz. I can remove HWWRITE bit setting on kernel space address and
remove the copying of DAR to MD_EPN in the DTLB Error handler.

I think I am on to something here, don't you?
>
> You really should first confirm that your hardware suffers from the bug by
> running a _simple_ test program in a _simple_ environment (NOT linux).

I don't have a simple environment. I have ppcboot on my board which doesn't
use the MMU at all.

>
> Then, you should confirm that your workaround solution is correct by
> testing it in the same simple environment.
>
> Just because you are able to use 'dcbz' on linux repeatedly without
> crashing does'nt prove that your hardware is buggy but linux handles
> it correctly.

Yes, I know that and that's why I write to this list to seek input from
others that know more than I do and have a simple test environment(hint, hint :-)

>
> -- Till
>
> PS: please CC me on any replies; I'm not subscribed to this list
>
> >
> >   Jocke
> >

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
