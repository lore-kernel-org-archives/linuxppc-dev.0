Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D25411007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 00:15:14 +1100 (EST)
Date: Wed, 23 Nov 2011 18:45:01 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
Message-ID: <20111123131501.GK16665@amit-x200.redhat.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <20111123103852.GG16665@amit-x200.redhat.com>
 <20111123125657.GH16665@amit-x200.redhat.com>
 <1322053564.3581.19.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322053564.3581.19.camel@lappy>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Rusty Russell <rusty@rustcorp.com.au>, Miche Baker-Harvey <miche@google.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Anton Blanchard <anton@samba.org>, Mike Waychison <mikew@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>,
 Eric Northrup <digitaleric@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Wed) 23 Nov 2011 [15:06:04], Sasha Levin wrote:
> On Wed, 2011-11-23 at 18:26 +0530, Amit Shah wrote:
> > On (Wed) 23 Nov 2011 [16:08:52], Amit Shah wrote:
> > > With this setup, with and without patches, I can spawn two consoles
> > > via:
> > > 
> > > /sbin/agetty /dev/hvc0 9600 vt100
> > > /sbin/agetty /dev/hvc1 9600 vt100
> > > 
> > > (Strange thing is, the second one gives a 'password incorrect' error
> > > on login attempts, while the first one logs in fine.  I do remember
> > > testing multiple consoles just fine a year and a half back, so no idea
> > > why this isn't behaving as expected -- but it mostly looks like a
> > > userspace issue rather than kernel one.)
> > 
> > Right -- when I test this on the Fedora 11 VM I used back then, the
> > two consoles work just fine without these patches.  When I use
> > something newer (F14), I get the weird password rejection, with and
> > without your patches.
> 
> It's not a weird password rejection, it's probably not set as a secure
> terminal :)
> 
> Try adding hvc1 to /etc/securetty on the guest.

Ah, of course :-)

		Amit
