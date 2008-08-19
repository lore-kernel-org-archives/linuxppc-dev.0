Return-Path: <jeremy@goop.org>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 368D8DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 10:09:28 +1000 (EST)
Message-ID: <48AB5E36.8030400@goop.org>
Date: Tue, 19 Aug 2008 16:58:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
References: <48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>	
	<48A9AFA7.8080508@freescale.com>	
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>	
	<1219110814.8062.2.camel@pasglop>	
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>	
	<1219113549.8062.13.camel@pasglop>	
	<alpine.DEB.1.10.0808182240330.13401@gandalf.stny.rr.com>	
	<20080819024707.GA22659@Krystal>	
	<alpine.DEB.1.10.0808191247001.28232@gandalf.stny.rr.com>	
	<20080819173453.GA28239@Krystal> <1219182471.7826.16.camel@pasglop>
In-Reply-To: <1219182471.7826.16.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Scott Wood <scottwood@freescale.com>,
	Eran Liberty <liberty@extricom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Ok, there are two cases where it's ok :
>>
>> 1 - in stop_machine, considering we are not touching code executed in
>> NMI handlers.
>> 2 - when using my replace_instruction_safe() which uses a temporary
>> breakpoint when doing the instruction replacement.
>>
>> In those cases you could use text_poke_early().
>>     
>
> Note that vmap/vunmap will be very slow.
>   

Don't we have Nick's speedups now?

    J
