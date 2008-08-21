Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] powerpc/cell/oprofile: fix mutex locking for
	spu-oprofile
Date: Thu, 21 Aug 2008 10:14:42 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808201519.19453.arnd@arndb.de>
	<18604.60738.523963.886786@drongo.ozlabs.ibm.com>
In-Reply-To: <18604.60738.523963.886786@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808211014.42683.arnd@arndb.de>
Cc: Robert Richter <robert.richter@amd.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	oprofile-list@lists.sourceforge.net, cel <cel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 21 August 2008, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > Paul, any chance we can still get this into 2.6.27?
> 
> Possibly.  We'll need a really good explanation for Linus as to why
> this is needed (what regression or serious bug this fixes) and why it
> is late.  Can you send me something explaining that?

The patch does not fix a regression, the spu-oprofile code basically never
worked. With the current code in Linux, samples in the profile buffer
can get corrupted because reader and writer to that buffer use different
locks for accessing it. It took us several iterations to come up with
a solution that does not introduce other problems and I didn't want to
push an earlier version that would need more fixups.

Since rc4 is out now, I understand if you feel more comfortable with
putting the patch into -next instead of -merge.
Note that the second patch is trivial and fixes an oopsable condition
of the kernel, so at least that should still go into 2.6.27.

> > I've added the Ack and uploaded it again for you to
> > pull from
> > 
> >  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge
> 
> Are you sure you actually managed to update that?

No, but it's there now. I was missing the '-f' for git-push.

	Arnd <><
