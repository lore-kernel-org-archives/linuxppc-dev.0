Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C79FDDE24
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 05:16:09 +1000 (EST)
Date: Thu, 7 Jun 2007 21:15:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 07/18] PS3: Make ps3av.h usable from user space
Message-ID: <20070607191553.GA30351@lst.de>
References: <20070606024407.786638029@am.sony.com>>
	<46662337.9060908@am.sony.com> <20070606074609.GA31975@lst.de>
	<4666E453.2000302@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4666E453.2000302@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christoph Hellwig <hch@lst.de>,
	Masashi Kimoto <Masashi_Kimoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 06, 2007 at 09:44:03AM -0700, Geoff Levand wrote:
> Christoph Hellwig wrote:
> > On Tue, Jun 05, 2007 at 08:00:07PM -0700, Geoff Levand wrote:
> >> The user applications to manage the PS3 AV modes can use values
> >> defined in this header.
> > 
> > NACK.  First please don't introduce new unifdef-y headers but always
> > separated them.  Second I don't see any of the values actually used
> > in a user<->kerne interface.  If the application only happens to use
> > the same values it should ship a copy of the header intead.
> 
> Yes, they are currently used with ioctl for video mode selection
> by the ps3videomode utility.
> 
> OK, you recommend having two headers one for the kernel and one for
> the application or library, then keeping them in sync.  I think
> in some ways that is easier for the package user also, since there
> is no dependency on kernel headers.  It does mean that the package
> definitions need to be kept up to date.

Now that we're actually using it for the ioctls it's fine to export
it.  But please use a separate header that contains just these bits
instead of introducing more headers that need unifdefing.
