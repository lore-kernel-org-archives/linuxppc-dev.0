Return-Path: <ebs@ebshome.net>
Date: Fri, 25 Mar 2005 12:37:31 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Tolunay Orkun <listmember@orkun.us>
Message-ID: <20050325203731.GB14444@gate.ebshome.net>
References: <712A2DEC228C7448978CBD7A7AD5B090012EE448@fever.wardrobe.irobot.com>
	<42444D00.80401@orkun.us> <20050325183126.GA2539@gate.ebshome.net>
	<424469C2.2070906@orkun.us> <42446F00.90000@orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42446F00.90000@orkun.us>
Cc: linuxppc-embedded@ozlabs.com
Subject: Re: Question regarding Interrupt "delivery" to user mode process
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 25, 2005 at 02:05:20PM -0600, Tolunay Orkun wrote:
> This would not be a problem for level triggered interrupts if 
> enable_irq() cleared the pending IRQ bit before re-enabling the 
> interrupt system if that particular interrupt was level triggered.
> 
> If there is a valid request still pending (i.e. external IRQ line is 
> still asserted at the appropriate level) this would not cause loss of 
> interrupt but in case there is no requester (i.e. all interrupts are 
> properly acknowledged), the spurious interrupt due to delayed processing 
> would be avoided.

Hmm, I think I agree with you. Let me think a little more and I'll 
probably add this additional ACK to 4xx PIC code.

Only thing which bothers me is that such hack will be 4xx specific, as 
none of PIC handlers I looked at (in arch/ppc) do this. So, I'm not 
quite sure it worth adding at all. After all, the way you use 
enable_irq/disable_irq isn't quite standard anyway :).

--
Eugene
