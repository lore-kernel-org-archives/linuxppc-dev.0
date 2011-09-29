Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E137B6F81
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 06:43:53 +1000 (EST)
Message-ID: <4E84D898.3020006@embedded-sol.com>
Date: Thu, 29 Sep 2011 23:44:08 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
	<CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
	<20110929172737.GF6800@ponder.secretlab.ca>
In-Reply-To: <20110929172737.GF6800@ponder.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On 09/29/2011 08:27 PM, Grant Likely wrote:
> On Wed, Sep 28, 2011 at 08:52:30PM +0000, Tabi Timur-B04825 wrote:
>> On Tue, Sep 27, 2011 at 1:29 PM, Grant Likely<grant.likely@secretlab.ca>  wrote:
>>
>>> The solution is to make the gpio driver register as a regular
>>> interrupt handler, and not as a chained handler.
>> I was wondering about that.
>>
>> What exactly is a chained handler?  How is it different from a regular handler?
> A chained handler has an expedited path through the interrupt code for
> handling it (basically, it skips handling it at the parent controller
> and passes through to the child, but it cannot handle multiple chained
> children on a single irq input.
>
> g.
>
I may be missing something, but please see this discussion:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/76025

Chained handler is suggested as the solution for very similar problem.
(several peripherals sharing the same hardware IRQ line. If it's possible
on ARM, it should be doable on powerpc, right ?

Felix.
