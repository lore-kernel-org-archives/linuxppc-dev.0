Return-Path: <sam@ravnborg.org>
Received: from pqueuea.post.tele.dk (pqueuea.post.tele.dk [193.162.153.9])
	by ozlabs.org (Postfix) with ESMTP id C116D679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:46:29 +1000 (EST)
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id E3D20375E48
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 06:27:23 +0200 (CEST)
Date: Tue, 10 May 2005 06:28:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050510042828.GA8398@mars.ravnborg.org>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
	<b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"<cpclark@xmission.com> <cpclark@xmission.com>" <cpclark@xmission.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> 
> On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> 
> >On Fri, 6 May 2005, Kumar Gala wrote:
> > > I tried the following w/o success:
> > >
> >> $(obj)/uImage: $(obj)/vmlinux.gz
> >>???????? $(Q)rm -f $@
> > >???????? $(call if_changed,uimage)
> >>???????? @echo '? Image: $@' $(shell if [ -f $@ ]; then echo 'is 
> >ready'; else
> > > echo 'not made'; fi)
> >
> >Couldn't you eliminate the ($shell ..) construct altogether, like 
> >this?:
> >
> >$(obj)/uImage: $(obj)/vmlinux.gz
> >??????? $(Q)rm -f $@
> > ??????? $(call if_changed,uimage)
> >??????? @echo -n '? Image: $@'
> > ??????? @if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> 
> Yes, and this seems to actually work.
> 
> Sam, does this look reasonable to you.  If so I will work up a patch.
Looks ok - but I do not see why use of $(shell ...) did not work out.
Please bring your working version forward.

	Sam
