Return-Path: <markn@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7595DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 09:44:11 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1PMi8rs002907
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 09:44:08 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n1PMiP9W1204280
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 09:44:25 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1PMi7NN015246
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 09:44:08 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Crash (ext3 ) during 2.6.29-rc6 boot
Date: Thu, 26 Feb 2009 09:45:41 +1100
References: <49A2705D.9030008@in.ibm.com>
	<200902252310.05792.markn@au1.ibm.com>
	<alpine.LRH.2.00.0902251430410.4063@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0902251430410.4063@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200902260945.41990.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Cc: Jan Kara <jack@ucw.cz>, Jan Kara <jack@suse.cz>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Feb 2009 12:31:20 am Geert Uytterhoeven wrote:
> On Wed, 25 Feb 2009, Mark Nelson wrote:
> > On Wed, 25 Feb 2009 08:50:46 pm Geert Uytterhoeven wrote:
> > > On Wed, 25 Feb 2009, Mark Nelson wrote:
> > > > On Tue, 24 Feb 2009 05:38:37 pm Sachin P. Sant wrote:
> > > > > Jan Kara wrote:
> > > > > >   Hmm, OK. But then I'm not sure how that can happen. Obviously, memcpy
> > > > > > somehow got beyond end of the page referenced by bh->b_data. So it means
> > > > > > that le16_to_cpu(entry->e_value_offs) + size > page_size. But
> > > > > > ext3_xattr_find_entry() calls ext3_xattr_check_entry() which in
> > > > > > particular checks whether e_value_offs + e_value_size isn't greater than
> > > > > > bh->b_size. So I see no way how memcpy can get beyond end of the page.
> > > > > >   Sachin, is the problem reproducible? If yes, can you send us contents
> > > > > >   
> > > > > Yes, i am able to recreate this problem easily. As i had mentioned if the
> > > > > earlier kernel is booted with selinux enabled and then 2.6.29-rc6 is booted
> > > > > i get this crash. But if i specify selinux=0 at command line, 2.6.29-rc6 boots
> > > > > without any problem.
> > > > 
> > > > Hi Sanchin and Geert,
> > > > 
> > > > Does the patch below fix the problems you're seeing? If it does I'll send
> > > > a properly written up and formatted patch to linuxppc-dev (as well as
> > > > another one to fix the same problem in copy_tofrom_user()).
> > > 
> > > Unfortunately not, now it crashes while accessing the memory pointed to by
> > > GPR16, in
> > > 
> > > NIP: copy_page_range+x0608/0x628
> > > LR:  dup_mm+0x2e4/0x428
> > > Trace: debug_table+0xcc70/0x1afe0 (unreliable)
> > > dup_mm+0x2e4/0x428
> > > copy_process+0x86c/0xf9c
> > > do_fork+0x188/0x39c
> > > sys_clone+0x58/0x70
> > > ppc_clone+0x8/0xc
> > > 
> > > However, after reverting 25d6e2d7c58ddc4a3b614fc5381591c0cfe66556, I still see
> > > similar problems as above (crash in copy_page_range()).
> > > Which makes me think that
> > >   1. Your new patch fixes the problem introduced by 25d6e2d7,
> > >   2. There's still another issue than the one introduced by 25d6e2d7.
> > 
> > Does the following patch fix the errors you're seeing? (it applies the
> > same fix as the previous patch but this time to copy_tofrom_user, which
> > I updated in a4e22f02f5b6518c1484faea1f88d81802b9feac)
> 
> Thanks, but I still get crashes in copy_page_range().
> 

Hmmm... I'm out of ideas for the moment, but thanks for testing anyway!

Mark
