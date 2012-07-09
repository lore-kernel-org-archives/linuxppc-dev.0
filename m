Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38C712C020A
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2012 09:41:04 +1000 (EST)
Message-ID: <1341877262.6118.73.camel@joe2Laptop>
Subject: Re: [PATCH v3] printk: Have printk() never buffer its data
From: Joe Perches <joe@perches.com>
To: Kay Sievers <kay@vrfy.org>
Date: Mon, 09 Jul 2012 16:41:02 -0700
In-Reply-To: <1341876736.6118.70.camel@joe2Laptop>
References: <1340651142.7037.2.camel@gandalf.stny.rr.com>
 <20120625150722.8cd4f45d.akpm@linux-foundation.org>
 <20120625235531.GB3652@kroah.com>
 <CA+55aFwczZTA=JUahoj_Sw1fQssDwoM2LGJ6g5nPvehTLxnSpg@mail.gmail.com>
 <20120626002307.GA4389@kroah.com>
 <CA+55aFxhYRqcU2EUmcsuLrhgo4FEO6-b+mB57wB3JRiXEp3ZrA@mail.gmail.com>
 <CAPXgP10cPFSmZ5yr6Z4wVtDa+x2J1yQDF57NJXtxjUuxMHm=Lw@mail.gmail.com>
 <CA+55aFzkX=jCC1O6+2oz8meswOqZQ+Q8Ao60q8eAS1G3AuEStQ@mail.gmail.com>
 <1340726856.977.6.camel@mop> <22482.1341471787@neuling.org>
 <CAPXgP11=o5WB4WejaQCSCL-+5e4sL7tfVz_r3Khyrq3SyrMvsA@mail.gmail.com>
 <CAPXgP13u769nSvUdS1iqiVCsxG5nsQd7bNT1=-eNw156U-kPkQ@mail.gmail.com>
 <16043.1341483625@neuling.org>
 <CAPXgP11+j+fDexHHmAZbBBidtrydrpWeh3DGWOhkuoybNj9skA@mail.gmail.com>
 <1341492628.834.3.camel@mop> <30233.1341535279@neuling.org>
 <CAPXgP12_F_H2XPpo2wFmb-u3jBdV__=h67R-LVYbqHuLh7tqLg@mail.gmail.com>
 <29711.1341545979@neuling.org> <30343.1341546469@neuling.org>
 <CAPXgP10JthGjZyqD6gqn2n1rPu1uP+=mem_T-iOritXAQMstRQ@mail.gmail.com>
 <21892.1341608647@neuling.org> <1341770155.1011.27.camel@mop>
 <1341870165.6118.42.camel@joe2Laptop>
 <CAPXgP11Qsj9yGM5nSbRJ_YPFZcr2Km6w4R8wPGU1AytyQChYXQ@mail.gmail.com>
 <1341872984.6118.54.camel@joe2Laptop>
 <CAPXgP12wrORpTdzMFW0QKr0j1VqZy_PRBFRM2P=qRqPFMQ=zUA@mail.gmail.com>
 <1341876736.6118.70.camel@joe2Laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@us.ibm.com>, linuxppc-dev@ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-09 at 16:32 -0700, Joe Perches wrote:
> Then you've changed semantics and I think you need to
> fix it.
> 
> A dev_<level> call is not guaranteed to be a complete
> message.
> 
> There are dev_<level> and netdev_<level> calls
> followed by pr_cont.
> 
> Maybe these could be fixed up and then they could be
> always integral.  There don't look to be too many.
> 
> This may be most (all?) of them:

Nah, there's a bunch more:

$ git grep -E -A10 "\b(netdev|dev)_(info|warn|notice|err|alert|emerg|crit)" drivers | \
  grep -B10 -E "\bprintk\s*\(\s*(KERN_CONT|)\s*\""

All of them could be fixed up though.
