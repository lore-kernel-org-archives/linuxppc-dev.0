Date: Sat, 15 Jun 2002 11:33:46 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Documentation/Changes needs to be updated to indicate requirement for newer modutils
Message-Id: <20020615113346.6759a642.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It would appear that Documentation/Changes needs to be updated to
reflect a requirement for a newer version of modutils (see attached
message).  I'm not sure what the minimum version of modutils needs
to be, but only that the YDL 2.2 modutils-2.4.13-0.7.1a worked fine
for me.

						-Bill

P.S.  I'm running a 2.4.19-pre8-ben0 kernel.



--------------------------------------------------------------------------------
Begin forwarded message:

Date: Sat, 15 Jun 2002 11:05:01 -0400
From: Bill Fink <billfink@mindspring.com>
To: Bill Fink <billfink@mindspring.com>
Subject: unresolved vmalloc_to_page symbol in video1394 and dv1394


On Fri, 14 Jun 2002, Bill Fink wrote:

> On Fri, 14 Jun 2002, Bill Fink wrote:
>
> > On Fri, 14 Jun 2002, Ben Collins wrote:
> >
> > > > OK.  I tried the 507 tarball which was a no go:
> > > >
> > > > # modprobe dv1394
> > > > /lib/modules/2.4.19-pre8-ben0-bill/kernel/drivers/ieee1394/dv1394.o: unresolved
> > > > symbol vmalloc_to_page
> > > > /lib/modules/2.4.19-pre8-ben0-bill/kernel/drivers/ieee1394/dv1394.o: insmod /lib/modules/2.4.19-pre8-ben0-bill/kernel/drivers/ieee1394/dv1394.o failed
> > > > /lib/modules/2.4.19-pre8-ben0-bill/kernel/drivers/ieee1394/dv1394.o: insmod dv1394 failed
> > >
> > > You'll need a 2.4.19-pre kernel for the repo.
> >
> > See above.  I have a 2.4.19-pre8-ben0 kernel.  That's why I was surprised
> > to get the error.
>
> Now I'm even more perplexed since vmalloc_to_page *IS* in my kernel and
> System.map.
>
> % grep vmalloc_to_page /boot/System.map
> c002988c T vmalloc_to_page
> c02b8668 ? __kstrtab_vmalloc_to_page
> c02e847c ? __ksymtab_vmalloc_to_page
>
> % nm /boot/vmlinux | grep vmalloc_to_page
> c02b8668 ? __kstrtab_vmalloc_to_page
> c02e847c ? __ksymtab_vmalloc_to_page
> c002988c T vmalloc_to_page

Mystery solved.  I noticed:

% grep vmalloc_to_page /proc/ksyms
c002988c GPLONLY_vmalloc_to_page

And in checking:

% grep GPL /usr/src/linux/kernel/ksyms.c
EXPORT_SYMBOL_GPL(vmalloc_to_page);

So vmalloc_to_page is the only GPL symbol in kernel/ksyms.c.  vmalloc_to_page
is only used by drivers/media/video/meye.c (Motion Eye video4linux driver
for Sony Vaio PictureBook) and by fairly recent SVN video1394 and dv1394
drivers, so I guess that's why this hasn't been bumped into much.

The fix was simply to upgrade to modutils-2.4.13-0.7.1a.  Note that I had
previously been running modutils-2.4.3-1b.ppc.rpm, which should have been
recent enough according to Documentation/Changes which indicates that you
need to have version 2.4.2 of modutils, so it would seem that
Documentation/Changes needs to be updated (although I don't know
what the minimum version of modutils needs to be but only what worked
for me).

So I'm now happily running the ieee1394-507 SVN tarball code (plus the
PPC byte swapping patch for dv1394)!

						-Bill

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink

_______________________________________________
mailing list linux1394-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux1394-devel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
