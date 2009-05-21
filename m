Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 8F561DE1C9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 01:22:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How to debug a hung multi-core system....
Date: Thu, 21 May 2009 11:23:30 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110F53C57@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90110EFACB2@EMPBEDEX.empirix.com>
	<C966FFF1-23FD-4581-A001-79F6961F8E49@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110F53A79@EMPBEDEX.empirix.com>
	<27AB6AE2-F8BA-4F05-9597-BCE0F98C1126@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Morrison, Tom" <tmorrison@empirix.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	"Young, Andrew" <andrew.young@windriver.com>, "Brown,
	Jeff" <jbrown@empirix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just had a little conference with several co-workers...to go over
results

We think that LT0 (the one that maps the kernel) has been corrupted:

       Entry  EPN          RPN    TID  TMASK   WIMGE  TSIZ U0:3  X0:1
       ---------------------------------------------------------------
       LT0  C0000000     00000000 00     0FF     04     9     0     0

       PID  TS  PROT SHEN   UR   UW   UX   SR   SW   SX  TIDZ VAL
       ---------------------------------------------------------------
       0    0    P    P    E    E    D    E    E    D    D    V

Is absolutely wrong - this is TLB for the kernel - and as you can see=20
...it does NOT have execution privileges (and in fact the user space=20
HAS executive privileges for this area (complete opposite of what it=20
should be)...

This is why it is stuck AT that instruction (can't even single step
from that location)..

(one of) The first problem(s) is how can/when did this TLB get
corrupted!

Tom
