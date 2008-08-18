Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6AB6FDDF0A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 04:34:25 +1000 (EST)
Message-ID: <48A9BF9C.80108@freescale.com>
Date: Mon, 18 Aug 2008 13:29:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Eran Liberty <liberty@extricom.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
>> Should use a "b" constraint for %2, or you could get r0. 
> 
> I will make an updated patch.
> 
>> Or, use an "m"
>> constraint with %U2%X2 after the lwz/stw. 
> 
> The 'b' seems easier ;-)

The advantage of the latter is that it allows GCC to choose indexed or 
update instructions -- but that's merely an optimization.  Switching to 
"b" is enough to avoid the potential bug.

>> %1 also needs to be an early clobber.
> 
> Not exactly sure what you mean by the above.

%1 is written to before some inputs are consumed, so you need to use 
"=&r" rather than "=r" so that GCC won't use the same register for both.

-Scott
