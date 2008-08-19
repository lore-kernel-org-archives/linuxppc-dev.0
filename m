Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0CDBDE17F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 07:47:44 +1000 (EST)
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20080819130216.GA18001@Krystal>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <48A9BEA3.10906@extricom.com>
	<20080818184158.GA1798@Krystal> <48AA98E4.6060606@extricom.com>
	<20080819130216.GA18001@Krystal>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 07:46:44 +1000
Message-Id: <1219182404.7826.14.camel@pasglop>
Mime-Version: 1.0
Cc: Eran Liberty <liberty@extricom.com>, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Register GPR30 is always zero... (also true for the other oops)

>From my experiments, -a- non volatile register gets corrupted. Not
always the same and not always with the same value.

The corruption -seems- to happen due to corruption of the location on
the stack where it was saved to / restored from in a previous function
call or interrupt.

I haven't yet tracked down what actually whacks the stack.

Ben.
