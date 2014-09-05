Return-Path: <mcree@orcon.net.nz>
Received: from mail.orcon.net.nz (unknown [219.88.242.62])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 237D01A006B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 07:33:26 +1000 (EST)
Date: Sat, 6 Sep 2014 09:27:27 +1200
From: Michael Cree <mcree@orcon.net.nz>
To: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905212727.GA6169@omega>
References: <54090AF4.7060406@hurleysoftware.com> <54091B30.2090509@zytor.com>
 <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com> <20140905203951.GA4053@omega>
 <540A273C.7020804@hurleysoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540A273C.7020804@hurleysoftware.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>, David Laight <David.Laight@ACULAB.COM>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marc Gauthier <marc@cadence.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
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

On Fri, Sep 05, 2014 at 05:12:28PM -0400, Peter Hurley wrote:
> On 09/05/2014 04:39 PM, Michael Cree wrote:
> > On Fri, Sep 05, 2014 at 04:14:48PM -0400, Peter Hurley wrote:
> >> Second, in the body of the document:
> >>
> >> "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> >> older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."
> > 
> > Let's be clear here, the pre-EV56 Alpha CPUs do provide an atomic
> > one-byte and two-byte load and store; it's just that one must use
> > locked load and store sequences to achieve atomicity.  The point,
> > I think, is that the pre-EV56 Alpha CPUs provide non-atomic one-byte
> > and two-byte load and stores as the norm, and that is the problem.
> 
> I'm all for an Alpha expert to jump in here and meet the criteria;
> which is that byte stores cannot corrupt adjacent storage (nor can
> aligned short stores).
> 
> To my mind, a quick look at Documentation/circular-buffers.txt will
> pretty much convince anyone that trying to differentiate by execution
> context is undoable.
> 
> If someone wants to make Alphas do cmpxchg loops for every byte store,
> then ok. Or any other solution that doesn't require subsystem code
> changes.

I am not suggesting that anyone do that work.  I'm certainly not going
to do it.

All I was pointing out is that the claim that "_do not provide_" made
above with emphasis is, strictly interpreted, not true, thus should not
be committed to the documentation without further clarification.

Cheers
Michael.
