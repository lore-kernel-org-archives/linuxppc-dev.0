Date: Sun, 11 Nov 2001 14:28:03 +0100
From: Jure Menart <jure@kom.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 -- a little console help, part 2
Message-ID: <20011111142803.A1888@hannanges.teden-mladih.com>
References: <3BEA8A5D.50A75CE7@midrivers.com> <3BEAA8D3.51ADDCC8@mvista.com> <20011109114403.J27549@zax> <3BEBDCC9.62669CF1@midrivers.com> <20011110005349.F3141@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011110005349.F3141@zax>; from david@gibson.dropbear.id.au on Sat, Nov 10, 2001 at 12:53:49AM +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
On Sat, Nov 10, 2001 at 12:53:49AM +1100, David Gibson wrote:
> I've checked the fix into the latest linuxppc_2_4_devel.  Failing
> that, look in do_page_fault() in arch/ppc/mm/fault.c, look for a test
> against vma->flags & VM_EXEC, and remove it.
>
I've got similiar problem, just that Seg faults form Dynamically linked
programs is just a beginning...
When I boot from ramdisk all programs work fine... aka mount, ls, bash...
but when I try to boot from disk (root=/dev/hda2 for example) my init prints
'Bug in dynamic linker: dynamic-link.h in line 62' (it might be slightly
changed because I wrote it from head, but error describes same informations).
So I checked in glibcs what this error is and I found out that assertion was
caused because of 'bad dynamic tag'.
If I mount disk from ramdisk and try to execute programs the same happens...
if they are dynamically compiled the same bug ('bad dynamic tag') happens.
I use linuxppc_2_4_devel kernel from mvista, daytagged from last wednesday
(7.11.2001), glibcs from HardHat linux (precompiled for IBM 405 gp).

Has anyone same problems? Could it be another bug in standard libarires?
Anywhere else in cross-compiler enviroment... binutils maybe?

Regards, Jure

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
