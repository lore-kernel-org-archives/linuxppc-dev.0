From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup 
In-reply-to: Your message of "Sun, 26 Aug 2001 20:04:04 MST."
             <20010826200404.E1481@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 13:13:42 +1000
Message-ID: <21473.998882022@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 26 Aug 2001 20:04:04 -0700,
Tom Rini <trini@kernel.crashing.org> wrote:
>On Mon, Aug 27, 2001 at 12:47:57PM +1000, Keith Owens wrote:
>> do_cpu_ftr_fixups() replaces unsupported code with NOP, based on the
>> table from __start___ftr_fixup to __stop___ftr_fixup which contains all
>> the data marked as section(__ftr_fixup).  Fine, but it only handles
>> section __ftr_fixup data in the kernel, it does not write NOP over
>> __ftr_fixup data in modules.  So any code marked as section __ftr_fixup
>> in a module executes unchanged.  Unless I am missing something, that is
>> a problem.
>
>After a bit more digging, I'm pretty sure it's not much of a problem.
>get_cycles seems to be either a) SMP or b) DRM or c) arcnet related.
>a and b aren't an issue for 601 (no SMP and possible but unlikely that
>DRM will work on a machine w/ a 601).  If there's an arcnet PCI card, I suppose
>it could be an issue then...  Anyhow...

It is more than just get_cycles().  Look at the places that ftr is used,
  fgrep -r BEGIN_FTR_SECTION include/asm-ppc* arch/ppc*
If any of that code ends up in a module then the problem exists.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
