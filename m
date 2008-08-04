Return-Path: <neilb@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D70BDDDDE
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 14:08:21 +1000 (EST)
From: Neil Brown <neilb@suse.de>
To: Paul Collins <paul@burly.ondioline.org>
Date: Mon, 4 Aug 2008 14:08:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18582.32935.501672.689845@notabene.brown>
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
In-Reply-To: message from Paul Collins on Monday August 4
References: <87tze38vzt.fsf@burly.wgtn.ondioline.org>
	<20080802184554.GB715@fieldses.org>
	<87abfvm4cc.fsf@burly.wgtn.ondioline.org>
	<877iayy4qc.fsf@burly.wgtn.ondioline.org>
	<18581.40960.737792.454035@notabene.brown>
	<87r696l1yo.fsf@burly.wgtn.ondioline.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linuxppc-dev@ozlabs.org,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday August 4, paul@burly.ondioline.org wrote:
> Neil Brown <neilb@suse.de> writes:
> >
> > What filesystem is being exported here?
> 
> Boring old ext3 (on LVM, on dm-crypt).


Good.  That makes it easier.
> 
> > Can you get an assembly version of exportfs_decode_fh, so we can check
> > what is happening at 0xa8 (and 0x4c).
> 

Thanks.

bctrl appears to be the indirect-function-call opcode.  There are
three of them one each for
  ->fh_to_dentry
  acceptable
  ->fh_to_parent

0xa8 is 'acceptable'.

In the first traceback, the crash was a call from very early in 
find_acceptable_alias,  The first significant thing it does is call
the 'acceptable' function.

So it seems clear that 'acceptable' is NULL.
It is equally clear that we never ever set it to NULL in the code.
The logical conclusion is "compiler error".
We can confirm (hopefully) by looking at a disassembly of fh_verify.

Maybe because nfsd_acceptable is 'static' and never explicitly called,
gcc gets confused and optimises it away.  Maybe a disassembly of 
nfsd_acceptable would be informative ... particularly if it turns out
to be empty.

Could you try removing the 'static' declaration for nfsd_acceptable
and recompile?
Or maybe try a different compiler?

Thanks,
NeilBrown
