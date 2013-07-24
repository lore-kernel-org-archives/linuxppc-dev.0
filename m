Return-Path: <rcj@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33B6C2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 00:59:56 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcj@linux.vnet.ibm.com>;
 Wed, 24 Jul 2013 20:21:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 81CF5E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:29:39 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OF0P3l17760506
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 20:30:28 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OExULT001147
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 14:59:31 GMT
Date: Wed, 24 Jul 2013 09:59:29 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: VPHN topology change updates all siblings
Message-ID: <20130724145929.GA13737@linux.vnet.ibm.com>
References: <20130723123344.GA11611@linux.vnet.ibm.com>
 <1374641175.3916.111.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1374641175.3916.111.camel@pasglop>
Cc: stable@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Jan Stancek <jstancek@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> On Tue, 2013-07-23 at 07:33 -0500, Robert Jennings wrote:
> > When an associativity level change is found for one thread, the
> > siblings threads need to be updated as well.  This is done today
> > for PRRN in stage_topology_update() but is missing for VPHN in
> > update_cpu_associativity_changes_mask().
> > 
> > All threads should be updated to move to the new node.  Without this
> > patch, a single thread may be flagged for a topology change, leaving it
> > in a different node from its siblings, which is incorrect.  This causes
> > problems for the scheduler where overlapping scheduler groups are created
> > and a loop is formed in those groups.
> > 
> > Reported-by: Jan Stancek <jstancek@redhat.com>
> > Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> > Cc: <stable@vger.kernel.org>
> 
> Patch breaks the UP build ...
> 
> Cheers,
> Ben.

Very sorry about that, a fix is on the way.
