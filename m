Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFAC51A1634
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 06:43:17 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 14:43:15 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B89953E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 14:43:14 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85KhEhb24051912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 22:43:14 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s85KlcXp002441
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 14:47:39 -0600
Date: Fri, 5 Sep 2014 13:43:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905204312.GA5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <5408E458.3@zytor.com> <54090AF4.7060406@hurleysoftware.com>
 <54091B30.2090509@zytor.com> <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com> <540A1E6C.2020005@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540A1E6C.2020005@zytor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>, Michael Cree <mcree@orcon.net.nz>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marc Gauthier <marc@cadence.com>, Paul Mackerras <paulus@samba.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>,
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

On Fri, Sep 05, 2014 at 01:34:52PM -0700, H. Peter Anvin wrote:
> On 09/05/2014 01:14 PM, Peter Hurley wrote:
> > 
> > Here's how I read the two statements.
> > 
> > First, the commit message:
> > 
> > "It [this commit] documents that CPUs [supported by the Linux kernel]
> > _must provide_ atomic one-byte and two-byte naturally aligned loads and stores."
> > 
> > Second, in the body of the document:
> > 
> > "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> > older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."
> > 
> 
> Does this apply in general or only to SMP configurations?  I guess
> non-SMP configurations would still have problems if interrupted in the
> wrong place...

And preemption could cause problems, too.  So I believe that it needs
to be universal.

							Thanx, Paul
