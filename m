Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 722EFDE309
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 05:05:00 +1000 (EST)
Message-ID: <48A9C5C0.5010705@freescale.com>
Date: Mon, 18 Aug 2008 13:56:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
References: <48591941.4070408@extricom.com>
	<48A92E15.2080709@extricom.com>	<48A9901B.1080900@redhat.com>
	<20080818154746.GA26835@Krystal>	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181445160.796@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0808181445160.796@gandalf.stny.rr.com>
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
> What syntax to do that with?
> 
>   lwz %1,0(%U2)
>   stu %3, 0(%X2)
> 
> I'm new to those. (and the above does not compile)

lwz%U2%X2 %1, %2
stw%U2%X2 %3, %2

>> Why stwu with an offset of zero,
> 
> How else to do it?  stwu %3, (%2) does not compile for me.

stw %3, 0(%2)

The "u" tells it to write the effective address back to %2 -- but with 
an offset of zero, the effective address is unchanged.

-Scott
