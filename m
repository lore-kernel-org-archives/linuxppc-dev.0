Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22B771A006B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 06:09:33 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 14:09:31 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6422219D8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 14:09:15 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85K9SwC24117356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 22:09:28 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s85KDq3d022094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 14:13:53 -0600
Date: Fri, 5 Sep 2014 13:09:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905200926.GW5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
 <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <540A0DF3.8030802@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540A0DF3.8030802@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 03:24:35PM -0400, Peter Hurley wrote:
> On 09/05/2014 03:05 PM, Paul E. McKenney wrote:
> > On Fri, Sep 05, 2014 at 02:50:31PM -0400, Peter Hurley wrote:
> >> On 09/05/2014 02:09 PM, Paul E. McKenney wrote:
> 
> [cut]
> 
> >>> ------------------------------------------------------------------------
> >>>
> >>> documentation: Record limitations of bitfields and small variables
> >>>
> >>> This commit documents the fact that it is not safe to use bitfields as
> >>> shared variables in synchronization algorithms.  It also documents that
> >>> CPUs must provide one-byte and two-byte load and store instructions
> >>                    ^
> >>                 atomic
> > 
> > Here you meant non-atomic?  My guess is that you are referring to the
> > fact that you could emulate a one-byte store on pre-EV56 Alpha CPUs
> > using the ll and sc atomic-read-modify-write instructions, correct?
> 
> Yes, that's what I meant. I must be tired and am misreading the commit
> message, or misinterpreting it's meaning.

Very good, got it!

							Thanx, Paul
