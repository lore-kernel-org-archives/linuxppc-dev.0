Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0550B7BF8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Dec 2009 17:31:11 +1100 (EST)
Date: Mon, 7 Dec 2009 22:31:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: + iseries-convert-to-proc_fops.patch added to -mm tree
Message-Id: <20091207223101.64a81509.akpm@linux-foundation.org>
In-Reply-To: <1260247339.10809.31.camel@pasglop>
References: <200912012205.nB1M5Z3n025210@imap1.linux-foundation.org>
	<1260247339.10809.31.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, adobriyan@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 08 Dec 2009 15:42:19 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2009-12-01 at 14:05 -0800, akpm@linux-foundation.org wrote:
> > The patch titled
> >      iseries: convert to proc_fops
> > has been added to the -mm tree.  Its filename is
> >      iseries-convert-to-proc_fops.patch
> 
> I was looking at that patch since It was in my queue, and while I
> have no firm objection, I started wondering what was the point :-)
> 
> IE. What does seq_file buys us here since the conversion adds more
> code than it removes and adds a hope via kmalloc that isn't necessary
> before the said conversion ?
> 
> Those files are only ever one line long (and one of them is only one
> character) so the seq_file doesn't really gets us any benefit does it ?


Might be related to this:

: Convert code away from ->read_proc/->write_proc interfaces.  Switch to
: proc_create()/proc_create_data() which make addition of proc entries
: reliable wrt NULL ->proc_fops, NULL ->data and so on.
:
: Problem with ->read_proc et al is described here commit
: 786d7e1612f0b0adb6046f19b906609e4fe8b1ba "Fix rmmod/read/write races in
: /proc entries"

but the real answer is: I have no idea.

Hopefully Andrey is now cured of his tendency to send unchangelogged
patches.

Andrey, please send along changelogs for

iseries-convert-to-proc_fops.patch
via-pmu-convert-to-proc_fops-seq_file.patch
proc_fops-convert-av7110.patch
proc_fops-convert-cpia.patch
proc_fops-convert-drivers-isdn-to-seq_file.patch
uml-convert-to-seq_file-proc_fops.patch
clps711xfb-convert-to-proc_fops.patch
