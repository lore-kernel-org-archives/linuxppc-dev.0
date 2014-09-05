Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C3AC1A1779
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 06:42:35 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 14:42:33 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 34E491FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 14:42:30 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85KgV1j30015718
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 22:42:31 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s85KktIk000499
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 14:46:56 -0600
Date: Fri, 5 Sep 2014 13:42:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905204228.GZ5001@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com>
 <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540A19B8.4010907@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Michael Cree <mcree@orcon.net.nz>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marc Gauthier <marc@cadence.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, David Laight <David.Laight@ACULAB.COM>,
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

On Fri, Sep 05, 2014 at 04:14:48PM -0400, Peter Hurley wrote:
> On 09/05/2014 03:38 PM, Marc Gauthier wrote:
> > Paul E. McKenney wrote:
> >> On Fri, Sep 05, 2014 at 02:50:31PM -0400, Peter Hurley wrote:
> >>> On 09/05/2014 02:09 PM, Paul E. McKenney wrote:
> >>>> This commit documents the fact that it is not safe to use bitfields as
> >>>> shared variables in synchronization algorithms.  It also documents that
> >>>> CPUs must provide one-byte and two-byte load and store instructions
> >>>                    ^
> >>>                 atomic
> >>
> >> Here you meant non-atomic?  My guess is that you are referring to the
> >> fact that you could emulate a one-byte store on pre-EV56 Alpha CPUs
> >> using the ll and sc atomic-read-modify-write instructions, correct?
> >>
> >>>> in order to be supported by the Linux kernel.  (Michael Cree
> >>>> has agreed to the resulting non-support of pre-EV56 Alpha CPUs:
> >>>> https://lkml.org/lkml/2014/9/5/143.
> > [...]
> > 
> >>>> +     and 64-bit systems, respectively.  Note that this means that the
> >>>> +     Linux kernel does not support pre-EV56 Alpha CPUs, because these
> >>>> +     older CPUs do not provide one-byte and two-byte loads and stores.
> >>>                                  ^
> >>>                             non-atomic
> >>
> >> I took this, thank you!
> > 
> > Eum, am I totally lost, or aren't both of these supposed to say "atomic" ?
> > 
> > Can't imagine requiring a CPU to provide non-atomic loads and stores
> > (i.e. requiring old Alpha behavior?).
> 
> Here's how I read the two statements.
> 
> First, the commit message:
> 
> "It [this commit] documents that CPUs [supported by the Linux kernel]
> _must provide_ atomic one-byte and two-byte naturally aligned loads and stores."
> 
> Second, in the body of the document:
> 
> "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."

Hmmm...  It is a bit ambiguous.  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

documentation: Record limitations of bitfields and small variables

This commit documents the fact that it is not safe to use bitfields
as shared variables in synchronization algorithms.  It also documents
that CPUs must provide one-byte and two-byte normal load and store
instructions in order to be supported by the Linux kernel.  (Michael
Cree has agreed to the resulting non-support of pre-EV56 Alpha CPUs:
https://lkml.org/lkml/2014/9/5/143.)

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 87be0a8a78de..fe4d51b704c5 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -269,6 +269,37 @@ And there are a number of things that _must_ or _must_not_ be assumed:
 	STORE *(A + 4) = Y; STORE *A = X;
 	STORE {*A, *(A + 4) } = {X, Y};
 
+And there are anti-guarantees:
+
+ (*) These guarantees do not apply to bitfields, because compilers often
+     generate code to modify these using non-atomic read-modify-write
+     sequences.  Do not attempt to use bitfields to synchronize parallel
+     algorithms.
+
+ (*) Even in cases where bitfields are protected by locks, all fields
+     in a given bitfield must be protected by one lock.  If two fields
+     in a given bitfield are protected by different locks, the compiler's
+     non-atomic read-modify-write sequences can cause an update to one
+     field to corrupt the value of an adjacent field.
+
+ (*) These guarantees apply only to properly aligned and sized scalar
+     variables.  "Properly sized" currently means variables that are
+     the same size as "char", "short", "int" and "long".  "Properly
+     aligned" means the natural alignment, thus no constraints for
+     "char", two-byte alignment for "short", four-byte alignment for
+     "int", and either four-byte or eight-byte alignment for "long",
+     on 32-bit and 64-bit systems, respectively.  Note that this means
+     that the Linux kernel does not support pre-EV56 Alpha CPUs,
+     because these older CPUs do not provide one-byte and two-byte
+     load and store instructions.  (In theory, the pre-EV56 Alpha CPUs
+     can emulate these instructions using load-linked/store-conditional
+     instructions, but in practice this approach has excessive overhead.
+     Keep in mind that this emulation would be required on -all- single-
+     and double-byte loads and stores in order to handle adjacent bytes
+     protected by different locks.)
+
+     Alpha EV56 and later Alpha CPUs are still supported.
+
 
 =========================
 WHAT ARE MEMORY BARRIERS?
