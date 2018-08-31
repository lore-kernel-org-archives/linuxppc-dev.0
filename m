Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421wRS17rwzF38g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 20:22:59 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7VAG2Tu141473
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 06:22:56 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m73s688c1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 06:22:56 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 31 Aug 2018 11:22:54 +0100
Date: Fri, 31 Aug 2018 03:22:48 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andre Wild <wild@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] sched/topology: Use Identity node only if required
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1533712172-11428-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20180808075840.GO2494@hirez.programming.kicks-ass.net>
 <20180810164533.GB42350@linux.vnet.ibm.com>
 <20180829084348.GO24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180829084348.GO24124@hirez.programming.kicks-ass.net>
Message-Id: <20180831102248.GA8437@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <peterz@infradead.org> [2018-08-29 10:43:48]:

> On Fri, Aug 10, 2018 at 09:45:33AM -0700, Srikar Dronamraju wrote:
>=20
> > ....
> > CPU302 attaching NULL sched-domain.
> > CPU303 attaching NULL sched-domain.
> > BUG: arch topology borken
> >      the DIE domain not a subset of the NODE domain
>=20
> ^^^^^ CLUE!!
>=20
> but nowhere did you show what it thinks the DIE mask is.
>=20
> >  CPU0 attaching sched-domain(s):
> >    domain-2: sdA, span=3D0-303 level=3DNODE
> >     groups: sg=3DsgL 0:{ span=3D0-7,32-39,64-71,96-103,128-135,160-167,=
192-199,224-231,256-263,288-295 cap=3D81920 }, sgM 8:{ span=3D8-15,40-47,72=
-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303 cap=3D81920 }, =
sdN 16:{ span=3D16-23,48-55,80-87,112-119,144-151,176-183,208-215,240-247,2=
72-279 cap=3D73728 }, sgO 24:{ span=3D24-31,56-63,88-95,120-127,152-159,184=
-191,216-223,248-255,280-287 cap=3D73728 }
> > CPU1  attaching sched-domain(s):
> >    domain-2: sdB, span=3D0-303 level=3DNODE
> > [  367.739387]     groups: sg=3DsgL 0:{ span=3D0-7,32-39,64-71,96-103,1=
28-135,160-167,192-199,224-231,256-263,288-295 cap=3D81920 }, sgM 8:{ span=
=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239,264-271,296-303=
 cap=3D81920 }, sdN 16:{ span=3D16-23,48-55,80-87,112-119,144-151,176-183,2=
08-215,240-247,272-279 cap=3D73728 }, sgO 24:{ span=3D24-31,56-63,88-95,120=
-127,152-159,184-191,216-223,248-255,280-287 cap=3D73728 }
>=20
> You forgot to provide the rest of it... what's domain-[01] look like?

At boot: Before topology update.

For  CPU 0=20
domain-0: span=3D0-7 level=3DSMT
 groups: 0:{ span=3D0 }, 1:{ span=3D1 }, 2:{ span=3D2 }, 3:{ span=3D3 }, 4:=
{ span=3D4 }, 5:{ span=3D5 }, 6:{ span=3D6 }, 7:{ span=3D7 }
 domain-1: span=3D0-303 level=3DDIE
  groups: 0:{ span=3D0-7 cap=3D8192 }, 8:{ span=3D8-15 cap=3D8192 }, 16:{ s=
pan=3D16-23 cap=3D8192 }, 24:{ span=3D24-31 cap=3D8192 }, 32:{ span=3D32-39=
 cap=3D8192 }, 40:{ span=3D40-47 cap=3D8192 }, 48:{ span=3D48-55 cap=3D8192=
 }, 56:{ span=3D56-63 cap=3D8192 }, 64:{ span=3D64-71 cap=3D8192 }, 72:{ sp=
an=3D72-79 cap=3D8192 }, 80:{ span=3D80-87 cap=3D8192 }, 88:{ span=3D88-95 =
cap=3D8192 }, 96:{ span=3D96-103 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8=
192 }, 112:{ span=3D112-119 cap=3D8192 }, 120:{ span=3D120-127 cap=3D8192 }=
, 128:{ span=3D128-135 cap=3D8192 }, 136:{ span=3D136-143 cap=3D8192 }, 144=
:{ span=3D144-151 cap=3D8192 }, 152:{ span=3D152-159 cap=3D8192 }, 160:{ sp=
an=3D160-167 cap=3D8192 }, 168:{ span=3D168-175 cap=3D8192 }, 176:{ span=3D=
176-183 cap=3D8192 }, 184:{ span=3D184-191 cap=3D8192 }, 192:{ span=3D192-1=
99 cap=3D8192 }, 200:{ span=3D200-207 cap=3D8192 }, 208:{ span=3D208-215 ca=
p=3D8192 }, 216:{ span=3D216-223 cap=3D8192 }, 224:{ span=3D224-231 cap=3D8=
192 }, 232:{ span=3D232-239 cap=3D8192 }, 240:{ span=3D240-247 cap=3D8192 }=
, 248:{ span=3D248-255 cap=3D8192 }, 256:{ span=3D256-263 cap=3D8192 }, 264=
:{ span=3D264-271 cap=3D8192 }, 272:{ span=3D272-279 cap=3D8192 }, 280:{ sp=
an=3D280-287 cap=3D8192 }, 288:{ span=3D288-295 cap=3D8192 }, 296:{ span=3D=
296-303 cap=3D8192 }

For  CPU 1=20
domain-0: span=3D0-7 level=3DSMT
 groups: 1:{ span=3D1 }, 2:{ span=3D2 }, 3:{ span=3D3 }, 4:{ span=3D4 }, 5:=
{ span=3D5 }, 6:{ span=3D6 }, 7:{ span=3D7 }, 0:{ span=3D0 }
 domain-1: span=3D0-303 level=3DDIE
  groups: 0:{ span=3D0-7 cap=3D8192 }, 8:{ span=3D8-15 cap=3D8192 }, 16:{ s=
pan=3D16-23 cap=3D8192 }, 24:{ span=3D24-31 cap=3D8192 }, 32:{ span=3D32-39=
 cap=3D8192 }, 40:{ span=3D40-47 cap=3D8192 }, 48:{ span=3D48-55 cap=3D8192=
 }, 56:{ span=3D56-63 cap=3D8192 }, 64:{ span=3D64-71 cap=3D8192 }, 72:{ sp=
an=3D72-79 cap=3D8192 }, 80:{ span=3D80-87 cap=3D8192 }, 88:{ span=3D88-95 =
cap=3D8192 }, 96:{ span=3D96-103 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8=
192 }, 112:{ span=3D112-119 cap=3D8192 }, 120:{ span=3D120-127 cap=3D8192 }=
, 128:{ span=3D128-135 cap=3D8192 }, 136:{ span=3D136-143 cap=3D8192 }, 144=
:{ span=3D144-151 cap=3D8192 }, 152:{ span=3D152-159 cap=3D8192 }, 160:{ sp=
an=3D160-167 cap=3D8192 }, 168:{ span=3D168-175 cap=3D8192 }, 176:{ span=3D=
176-183 cap=3D8192 }, 184:{ span=3D184-191 cap=3D8192 }, 192:{ span=3D192-1=
99 cap=3D8192 }, 200:{ span=3D200-207 cap=3D8192 }, 208:{ span=3D208-215 ca=
p=3D8192}, 216:{ span=3D216-223 cap=3D8192 }, 224:{ span=3D224-231 cap=3D81=
92 }, 232:{ span=3D232-239 cap=3D8192 }, 240:{ span=3D240-247 cap=3D8192 },=
 248:{ span=3D248-255 cap=3D8192 }, 256:{ span=3D256-263 cap=3D8192 }, 264:=
{ span=3D264-271 cap=3D8192 }, 272:{ span=3D272-279 cap=3D8192 }, 280:{ spa=
n=3D280-287 cap=3D8192 }, 288:{ span=3D288-295 cap=3D8192 }, 296:{ span=3D2=
96-303 cap=3D8192 }


For  CPU 8
domain-0: span=3D8-15 level=3DSMT
 groups: 8:{ span=3D8 }, 9:{ span=3D9 }, 10:{ span=3D10 }, 11:{ span=3D11 }=
, 12:{ span=3D12 }, 13:{ span=3D13 }, 14:{ span=3D14 }, 15:{ span=3D15 }
 domain-1: span=3D0-303 level=3DDIE
  groups: 8:{ span=3D8-15 cap=3D8192 }, 16:{ span=3D16-23 cap=3D8192 }, 24:=
{ span=3D24-31 cap=3D8192 }, 32:{ span=3D32-39 cap=3D8192 }, 40:{ span=3D40=
-47 cap=3D8192 }, 48:{ span=3D48-55 cap=3D8192 }, 56:{ span=3D56-63 cap=3D8=
192 }, 64:{ span=3D64-71 cap=3D8192 }, 72:{ span=3D72-79 cap=3D8192 }, 80:{=
 span=3D80-87 cap=3D8192 }, 88:{ span=3D88-95 cap=3D8192 }, 96:{ span=3D96-=
103 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8192 }, 112:{ span=3D112-119 c=
ap=3D8192 }, 120:{ span=3D120-127 cap=3D8192 }, 128:{ span=3D128-135 cap=3D=
8192 }, 136:{ span=3D136-143 cap=3D8192 }, 144:{ span=3D144-151 cap=3D8192 =
}, 152:{ span=3D152-159 cap=3D8192 }, 160:{ span=3D160-167 cap=3D8192 }, 16=
8:{ span=3D168-175 cap=3D8192 }, 176:{ span=3D176-183 cap=3D8192 }, 184:{ s=
pan=3D184-191 cap=3D8192 }, 192:{ span=3D192-199 cap=3D8192 }, 200:{ span=
=3D200-207 cap=3D8192 }, 208:{ span=3D208-215 cap=3D8192 }, 216:{ span=3D21=
6-223 cap=3D8192 }, 224:{ span=3D224-231 cap=3D8192 }, 232:{ span=3D232-239=
 cap=3D8192 }, 240:{ span=3D240-247 cap=3D8192 }, 248:{ span=3D248-255 cap=
=3D8192 }, 256:{ span=3D256-263 cap=3D8192 }, 264:{ span=3D264-271 cap=3D81=
92 }, 272:{ span=3D272-279 cap=3D8192 }, 280:{ span=3D280-287 cap=3D8192 },=
 288:{ span=3D288-295 cap=3D8192 }, 296:{ span=3D296-303 cap=3D8192 }, 0:{ =
span=3D0-7 cap=3D8192 }

For  CPU 9=20
domain-0: span=3D8-15 level=3DSMT
 groups: 9:{ span=3D9 }, 10:{ span=3D10 }, 11:{ span=3D11 }, 12:{ span=3D12=
 }, 13:{ span=3D13 }, 14:{ span=3D14 }, 15:{ span=3D15 }, 8:{ span=3D8 }
 domain-1: span=3D0-303 level=3DDIE
  groups: 8:{ span=3D8-15 cap=3D8192 }, 16:{ span=3D16-23 cap=3D8192 }, 24:=
{ span=3D24-31 cap=3D8192 }, 32:{ span=3D32-39 cap=3D8192 }, 40:{ span=3D40=
-47 cap=3D8192 }, 48:{ span=3D48-55 cap=3D8192 }, 56:{ span=3D56-63 cap=3D8=
192 }, 64:{ span=3D64-71 cap=3D8192 }, 72:{ span=3D72-79 cap=3D8192 }, 80:{=
 span=3D80-87 cap=3D8192 }, 88:{ span=3D88-95 cap=3D8192 }, 96:{ span=3D96-=
103 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8192 }, 112:{ span=3D112-119 c=
ap=3D8192 }, 120:{ span=3D120-127 cap=3D8192 }, 128:{ span=3D128-135 cap=3D=
8192 }, 136:{ span=3D136-143 cap=3D8192 }, 144:{ span=3D144-151 cap=3D8192 =
}, 152:{ span=3D152-159 cap=3D8192 }, 160:{ span=3D160-167 cap=3D8192 }, 16=
8:{ span=3D168-175 cap=3D8192 }, 176:{ span=3D176-183 cap=3D8192 }, 184:{ s=
pan=3D184-191 cap=3D8192 }, 192:{ span=3D192-199 cap=3D8192 }, 200:{ span=
=3D200-207 cap=3D8192 }, 208:{ span=3D208-215 cap=3D8192 }, 216:{ span=3D21=
6-223 cap=3D8192 }, 224:{ span=3D224-231 cap=3D8192 }, 232:{ span=3D232-239=
 cap=3D8192 }, 240:{ span=3D240-247 cap=3D8192 }, 248:{ span=3D248-255 cap=
=3D8192 }, 256:{ span=3D256-263 cap=3D8192 }, 264:{ span=3D264-271 cap=3D81=
92 }, 272:{ span=3D272-279 cap=3D8192 }, 280:{ span=3D280-287 cap=3D8192 },=
 288:{ span=3D288-295 cap=3D8192 }, 296:{ span=3D296-303 cap=3D8192 }, 0:{ =
span=3D0-7 cap=3D8192 }


After topology update.

For CPU 0
domain-0: span=3D0-7 level=3DSMT
 groups: 0:{ span=3D0 }, 1:{ span=3D1 }, 2:{ span=3D2 }, 3:{ span=3D3 }, 4:=
{ span=3D4 }, 5:{ span=3D5 }, 6:{ span=3D6 }, 7:{ span=3D7 }
 domain-1: span=3D0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,25=
6-263,288-295 level=3DDIE
  groups: 0:{ span=3D0-7 cap=3D8192 }, 32:{ span=3D32-39 cap=3D8192 }, 64:{=
 span=3D64-71 cap=3D8192 }, 96:{ span=3D96-103 cap=3D8192 }, 128:{ span=3D1=
28-135 cap=3D8192 }, 160:{ span=3D160-167 cap=3D8192 }, 192:{ span=3D192-19=
9 cap=3D8192 }, 224:{ span=3D224-231 cap=3D8192 }, 256:{ span=3D256-263 cap=
=3D8192 }, 288:{ span=3D288-295 cap=3D8192 }
  domain-2: span=3D0-303 level=3DNODE
   groups: 0:{ span=3D0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-23=
1,256-263,288-295 cap=3D81920 }, 8:{ span=3D8-15,40-47,72-79,104-111,136-14=
3,168-175,200-207,232-239,264-271,296-303 cap=3D81920 }, 16:{ span=3D16-23,=
48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=3D73728 }, =
24:{ span=3D24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-2=
87 cap=3D73728 }

For CPU 1
domain-0: span=3D0-7 level=3DSMT
 groups: 1:{ span=3D1 }, 2:{ span=3D2 }, 3:{ span=3D3 }, 4:{ span=3D4 }, 5:=
{ span=3D5 }, 6:{ span=3D6 }, 7:{ span=3D7 }, 0:{ span=3D0 }
 domain-1: span=3D0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-231,25=
6-263,288-295 level=3DDIE
  groups: 0:{ span=3D0-7 cap=3D8192 }, 32:{ span=3D32-39 cap=3D8192 }, 64:{=
 span=3D64-71 cap=3D8192 }, 96:{ span=3D96-103 cap=3D8192 }, 128:{ span=3D1=
28-135 cap=3D8192 }, 160:{ span=3D160-167 cap=3D8192 }, 192:{ span=3D192-19=
9 cap=3D8192 }, 224:{ span=3D224-231 cap=3D8192 }, 256:{ span=3D256-263 cap=
=3D8192 }, 288:{ span=3D288-295 cap=3D8192 }
  domain-2: span=3D0-303 level=3DNODE
   groups: 0:{ span=3D0-7,32-39,64-71,96-103,128-135,160-167,192-199,224-23=
1,256-263,288-295 cap=3D81920 }, 8:{ span=3D8-15,40-47,72-79,104-111,136-14=
3,168-175,200-207,232-239,264-271,296-303 cap=3D81920 }, 16:{ span=3D16-23,=
48-55,80-87,112-119,144-151,176-183,208-215,240-247,272-279 cap=3D73728 }, =
24:{ span=3D24-31,56-63,88-95,120-127,152-159,184-191,216-223,248-255,280-2=
87 cap=3D73728 }


For CPU 8
 domain-0: span=3D8-15 level=3DSMT
  groups: 8:{ span=3D8 }, 9:{ span=3D9 }, 10:{ span=3D10 }, 11:{ span=3D11 =
}, 12:{ span=3D12 }, 13:{ span=3D13 }, 14:{ span=3D14 }, 15:{ span=3D15 }
  domain-1: span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239=
,264-271,296-303 level=3DDIE
   groups: 8:{ span=3D8-15 cap=3D8192 }, 40:{ span=3D40-47 cap=3D8192 }, 72=
:{ span=3D72-79 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8192 }, 136:{ span=
=3D136-143 cap=3D8192 }, 168:{ span=3D168-175 cap=3D8192 }, 200:{ span=3D20=
0-207 cap=3D8192 }, 232:{ span=3D232-239 cap=3D8192 }, 264:{ span=3D264-271=
 cap=3D8192 }, 296:{ span=3D296-303 cap=3D8192 }
   domain-2: span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-23=
9,264-271,296-303 level=3DNODE
    groups: 8:{ span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232=
-239,264-271,296-303 cap=3D81920 }
    domain-3: span=3D0-303 level=3DNUMA
     groups: 8:{ span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,23=
2-239,264-271,296-303 cap=3D81920 }, 16:{ span=3D16-23,48-55,80-87,112-119,=
144-151,176-183,208-215,240-247,272-279 cap=3D73728 }, 24:{ span=3D24-31,56=
-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=3D73728 }
ERROR: groups don't span domain->span

For CPU 9
 domain-0: span=3D8-15 level=3DSMT
  groups: 9:{ span=3D9 }, 10:{ span=3D10 }, 11:{ span=3D11 }, 12:{ span=3D1=
2 }, 13:{ span=3D13 }, 14:{ span=3D14 }, 15:{ span=3D15 }, 8:{ span=3D8 }
  domain-1: span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-239=
,264-271,296-303 level=3DDIE
   groups: 8:{ span=3D8-15 cap=3D8192 }, 40:{ span=3D40-47 cap=3D8192 }, 72=
:{ span=3D72-79 cap=3D8192 }, 104:{ span=3D104-111 cap=3D8192 }, 136:{ span=
=3D136-143 cap=3D8192 }, 168:{ span=3D168-175 cap=3D8192 }, 200:{ span=3D20=
0-207 cap=3D8192 }, 232:{ span=3D232-239 cap=3D8192 }, 264:{ span=3D264-271=
 cap=3D8192 }, 296:{ span=3D296-303 cap=3D8192 }
   domain-2: span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232-23=
9,264-271,296-303 level=3DNODE
    groups: 8:{ span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,232=
-239,264-271,296-303 cap=3D81920 }
    domain-3: span=3D0-303 level=3DNUMA
     groups: 8:{ span=3D8-15,40-47,72-79,104-111,136-143,168-175,200-207,23=
2-239,264-271,296-303 cap=3D81920 }, 16:{ span=3D16-23,48-55,80-87,112-119,=
144-151,176-183,208-215,240-247,272-279 cap=3D73728 }, 24:{ span=3D24-31,56=
-63,88-95,120-127,152-159,184-191,216-223,248-255,280-287 cap=3D73728 }
ERROR: groups don't span domain->span

--=20
Thanks and Regards
Srikar Dronamraju
