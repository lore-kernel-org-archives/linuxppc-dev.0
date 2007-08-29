Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B8F1BDDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 07:40:53 +1000 (EST)
Date: Wed, 29 Aug 2007 14:40:50 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: melinda develey <melinda.develey70@yahoo.com>
Subject: Re: spin_lock doesn't work?!?
References: <177333.15506.qm@web63904.mail.re1.yahoo.com>
In-Reply-To: <177333.15506.qm@web63904.mail.re1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20070829214050.8C47A1A2804D@mail19-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Melinda,

depending on how your kernel is configured spin_locks will compileinto
nothing. For example, if you are compiling a kernel for a single
processor platform without preemptive scheduling then the spin_lock()
calls will be compiled into no-op as they are unnecessary on a non-SMP,
non-preemptive system.

You should still put the spin_lock calls into your code because you
never know if someone else will compile it and for another target. If
someone would, for example, compile the same code for a SMP machine then
the spin_lock will actually lock.

Cheers,
   Wolfgang

melinda develey wrote:
> I discovered that I called spin_lock two times consecutively without
> calling spin_unlock but my code didn't lock (I was managing an ioctl).
> Probably I didn't understand how spin_lock works!!!!
> 
> Any help?
> 
> ------------------------------------------------------------------------
> Need a vacation? Get great deals to amazing places
> <http://us.rd.yahoo.com/evt=48256/*http://travel.yahoo.com/;_ylc=X3oDMTFhN2hucjlpBF9TAzk3NDA3NTg5BHBvcwM1BHNlYwNncm91cHMEc2xrA2VtYWlsLW5jbQ-->on
> Yahoo! Travel.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
