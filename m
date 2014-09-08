Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by lists.ozlabs.org (Postfix) with ESMTP id 0B8541A01DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 08:39:57 +1000 (EST)
Message-ID: <1410215994.2027.86.camel@jarvis.lan>
Subject: Re: bit fields && data tearing
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 08 Sep 2014 15:39:54 -0700
In-Reply-To: <540DFFB2.4000509@zytor.com>
References: <5408C0AB.6050801@hurleysoftware.com>
 <20140905001751.GL5001@linux.vnet.ibm.com>
 <1409883098.5078.14.camel@jarvis.lan>
 <5409243C.4080704@hurleysoftware.com>
 <20140905040645.GO5001@linux.vnet.ibm.com>
 <1410066442.12512.13.camel@jarvis.lan>
 <20140907162146.GK5001@linux.vnet.ibm.com>
 <1410116687.2027.19.camel@jarvis.lan>
 <20140907230019.GO5001@linux.vnet.ibm.com>
 <6092b453-e0c9-4f6d-922b-48bce988f774@email.android.com>
 <20140907233655.GR5001@linux.vnet.ibm.com>
 <154b540a-df47-4f3e-bdda-ab5d2e72723a@email.android.com>
 <1410155802.2027.36.camel@jarvis.lan> <540DF17C.9080509@zytor.com>
 <1410203369.2027.56.camel@jarvis.lan> <540DFFB2.4000509@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-09-08 at 12:12 -0700, H. Peter Anvin wrote:
> On 09/08/2014 12:09 PM, James Bottomley wrote:
> > 
> > Um, I think you need to re-read the thread; that's not what I said at
> > all. It's even written lower down: "PA can't do atomic bit sets (no
> > atomic RMW except the ldcw operation) it can do atomic writes to
> > fundamental sizes (byte, short, int, long) provided gcc emits the
> > correct primitive".  The original question was whether atomicity
> > required native bus width access, which we currently assume, so there's
> > no extant problem.
> > 
> 
> The issue at hand was whether or not partially overlapped (but natually
> aligned) writes can pass each other.  *This* is the aggressive
> relaxation to which I am referring.

I don't understand what you mean by "pass each other".  Atomicity
guarantees are not ordering guarantees in a SMP environment.  The
guarantee is that if you follow the rules when two CPUs update the same
natural width aligned object simultaneously using the same primitive,
the result is either one or the other of their updates.  Which one wins
(the ordering) isn't defined.

James


> I would guess that that is a very unusual constraint.
