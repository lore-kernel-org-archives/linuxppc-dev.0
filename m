Return-Path: <tytso@thunk.org>
Received: from imap.thunk.org (imap.thunk.org
 [IPv6:2600:3c02::f03c:91ff:fe96:be03])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttwHv6mTxzDqN5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 02:50:19 +1100 (AEDT)
Date: Wed, 4 Jan 2017 10:28:37 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, jack@suse.cz,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, axboe@fb.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, torvalds@linux-foundation.org
Subject: Re: ext4 filesystem corruption with 4.10-rc2 on ppc64le
Message-ID: <20170104152837.wdh7cdncs7gyged7@thunk.org>
References: <20170104161808.5ad7b4fd@kryten>
 <6085340.JSrffQ0Szo@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6085340.JSrffQ0Szo@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 11:32:42AM +0530, Chandan Rajendra wrote:
> On Wednesday, January 04, 2017 04:18:08 PM Anton Blanchard wrote:
> > I'm consistently seeing ext4 filesystem corruption using a mainline
> > kernel. It doesn't take much to trigger it - download a ppc64le Ubuntu
> > cloud image, boot it in KVM and run:
> > 
> > sudo apt-get update
> > sudo apt-get dist-upgrade
> > sudo reboot
> > 
> > And it never makes it back up, dying with rather severe filesystem
> > corruption.
> 
> The patch at https://patchwork.kernel.org/patch/9488235/ should fix the
> bug.

It looks like this patch is already queued up on the "for-linus"
branch on the linux-block.git tree.

Chandra, thanks for pointing this out!  I had missed your e-mail from
Christmas day, and it was on my todo list to figure out why I was
seeing lots of 1k block regressions on gce-xfstests post-merge window
that wasn't showing up on the ext4.git tree before I sent my pull
request to Linus.

Jens, could you expedite a pull request to Linus?  This is affecting
ext4 on 1k block file systems on x86/x86_64, so this is not a ppc-only
regression.  

Anton or Chandan, could you do me a favor and verify whether or not
64k block sizes are working for you on ppcle on ext4 by running
xfstests?  Light duty testing works for me but when I stress ext4 with
pagesize==blocksize on ppcle64 via xfstests, it blows up.  I suspect
(but am not sure) it's due to (non-upstream) device driver issues, and
a verification that you can run xfstests on your ppcle64 systems using
standard upstream device drivers would be very helpful, since I don't
have easy console access on the machines I have access to at $WORK.  :-(

And of course, if there are still blocksize==pagesize issues on ext4
on ppc64le, it would be good to know that too.

Many thanks!!
						- Ted

P.S.  And for those people who are doing storage work, let me put in a
plug for "gce-xfstests full".  It's cheap and finds lots of problems
before I and others have to.  And if the $1.50 USD is the problem, let
me know and I'll try to work something out.  :-) :-)
