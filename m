Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from accolon.hansenpartnership.com (accolon.hansenpartnership.com
	[76.243.235.52]) by ozlabs.org (Postfix) with ESMTP id 78E60DDDA2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 00:57:54 +1100 (EST)
Subject: Re: Next March 25: Boot failure on powerpc [recursive locking
	detected]
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <49CB2200.50703@in.ibm.com>
References: <20090325191229.0e17eaf6.sfr@canb.auug.org.au>
	<49CA3BF4.3050801@in.ibm.com>  <49CB2200.50703@in.ibm.com>
Content-Type: text/plain
Date: Thu, 26 Mar 2009 08:50:03 -0500
Message-Id: <1238075403.3342.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-26 at 12:04 +0530, Sachin Sant wrote:
> Sachin Sant wrote:
> > Today's next failed to boot on a powerpc box
> > (Power6 blade IBM,7998-61X) with following recursive locking message.
> >
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 2.6.29-next-20090325 #1
> After bisecting the failure seems to be because of the following
> patch from James ( block: move SCSI timeout check into block )
> 
> http://patchwork.kernel.org/patch/8017/
> 
> If i back out the above mentioned patch, the machine boots fine
> without any problems.

Yes, that patch already got dropped for other reasons:

http://marc.info/?t=123740773700002

I'm going to see if I can redo it in a better way, since moving this
type of timeout checking from scsi to block is a useful generalisation.

James
