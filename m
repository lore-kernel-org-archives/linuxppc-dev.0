Return-Path: <tytso@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 532CCDDF12
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:50:04 +1100 (EST)
Date: Tue, 25 Mar 2008 18:49:23 -0400
From: Theodore Tso <tytso@MIT.EDU>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-ID: <20080325224923.GC24980@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fXStkuK2IQBfcDe+"
In-Reply-To: <20080326092657.8b65e5ea.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2008 at 09:26:57AM +1100, Stephen Rothwell wrote:
> However, have you made any progress on Christoph's suggestion:
>
> "The real fix is that ext4 shouldn't be using ZERO_PAGE().  Please use
> the same zeroing helpers all the other filesystems and drivers use."

When Aneesh asked for clarification about Christoph's suggestion, he
got the following response (see attached).

						- Ted


--fXStkuK2IQBfcDe+
Content-Type: message/rfc822
Content-Disposition: inline

Date: Thu, 20 Mar 2008 04:35:12 -0400
From: Christoph Hellwig <hch@infradead.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Subject: Re: ZERO_PAGE(0) usage in ext4
Message-ID: <20080320083512.GB27854@infradead.org>
References: <20080317175230.GA9325@skywalker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080317175230.GA9325@skywalker>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2008 at 11:22:30PM +0530, Aneesh Kumar K.V wrote:
> Hi Christoph,
> 
> I have changes pending for ext4 which uses ZERO_PAGE(0) to zero out
> file system blocks.
> 
> http://repo.or.cz/w/ext4-patch-queue.git?a=blob;f=ext4-fallocate-full-fs-ENOSPC-handling.patch;h=e14ec2a53f008c3f4b80544a897165de4bb5d360;hb=HEAD
> 
> The changes are needed to make sure we allow writing to prealloc space
> even when there are no space left in the file system to insert new
> extent details. To use ZERO_PAGE in ext4 i would need patches to export
> some of the variables. I found that you answered Ted's patch at
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052956.html
> 
> I have a patch that does the same thing for multiple arch. Can you help
> me understand what you meant by zeroing helpers ?

Ok, you're actually sending down the page and not copying from it.
This is probab;y okay.

--fXStkuK2IQBfcDe+--
