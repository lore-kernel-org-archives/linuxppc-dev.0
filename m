Return-Path: <ananth@in.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01C2B2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 17:37:47 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Fri, 24 Aug 2012 01:37:45 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 45BA119D8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 01:37:43 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7O7bgs9190810
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 01:37:42 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q7O7bfRl006459
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 01:37:42 -0600
Date: Fri, 24 Aug 2012 13:07:38 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120824073738.GD32031@in.ibm.com>
References: <20120822082205.GA29216@in.ibm.com>
 <20120822082708.GB29216@in.ibm.com> <1345696100.3338.21.camel@concordia>
 <20120823055820.GA14603@in.ibm.com> <1345770803.13865.10.camel@concordia>
 <1345792051.29170.25.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345792051.29170.25.camel@pasglop>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2012 at 05:07:31PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2012-08-24 at 11:13 +1000, Michael Ellerman wrote:
> > 
> > Yeah. A NULL regs here is a kernel bug, so I think it's actually
> > preferable to crash than silently return. 
> 
> Or best, if you think there's a remote chance that the bug might hit:
> 
> 	if (WARN(!regs))
> 		return

Incorporated this and other suggestions from Michael in v5 I just
posted.

Ananth
