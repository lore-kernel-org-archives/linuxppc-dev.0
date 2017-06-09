Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkdFK3SWZzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 20:04:53 +1000 (AEST)
Date: Fri, 9 Jun 2017 12:04:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aleksa Sarai <asarai@suse.de>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Valentin Rothberg <vrothberg@suse.com>
Subject: Re: [PATCH v4 2/2] tty: add TIOCGPTPEER ioctl
Message-ID: <20170609100442.GA1405@kroah.com>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-3-asarai@suse.de>
 <20170609092659.GA26933@kroah.com>
 <44c2b6c7-63ee-5c7f-cc77-5e1bcd69eea4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44c2b6c7-63ee-5c7f-cc77-5e1bcd69eea4@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 09, 2017 at 07:50:43PM +1000, Aleksa Sarai wrote:
> > > When opening the slave end of a PTY, it is not possible for userspace to
> > > safely ensure that /dev/pts/$num is actually a slave (in cases where the
> > > mount namespace in which devpts was mounted is controlled by an
> > > untrusted process). In addition, there are several unresolvable
> > > race conditions if userspace were to attempt to detect attacks through
> > > stat(2) and other similar methods [in addition it is not clear how
> > > userspace could detect attacks involving FUSE].
> > > 
> > > Resolve this by providing an interface for userpace to safely open the
> > > "peer" end of a PTY file descriptor by using the dentry cached by
> > > devpts. Since it is not possible to have an open master PTY without
> > > having its slave exposed in /dev/pts this interface is safe. This
> > > interface currently does not provide a way to get the master pty (since
> > > it is not clear whether such an interface is safe or even useful).
> > > 
> > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > Cc: Valentin Rothberg <vrothberg@suse.com>
> > > Signed-off-by: Aleksa Sarai <asarai@suse.de>
> > 
> > Is this going to be documented anywhere?  Is there a man page update
> > that also goes along with this?
> 
> I will add one, I didn't know where the man-pages project is hosted / where
> patches get pushed? What is the ML?

>From the MAINTAINERS file:
  MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
  M:      Michael Kerrisk <mtk.manpages@gmail.com>
  W:      http://www.kernel.org/doc/man-pages
  L:      linux-man@vger.kernel.org
  S:      Maintained

> > What userspace program wants to use this?
> 
> LXC (Christian is on Cc) will use this, runC will most likely use it,
> pending on some design discussions (as well as some future container
> runtimes I'm planning on working on). Effectively any container runtime that
> wants to safely create terminals and spawn containers inside an existing
> container's namespaces will likely want to use this.
> 
> [ As an aside, I /would/ argue this is a security fix (it fixes an interface
> problem that made doing certain operations securely possible) but I didn't
> want to Cc stable@ because it's a feature and not a strict bugfix. ]

Yeah, it's a new feature, so stable doesn't really fit here.  And as
people who use containers are all keeping up to date with their kernel
versions, this shouldn't be that big of a deal, not like the Android
kernel mess :)

thanks,

greg k-h
