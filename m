Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0FAAFDDF02
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 09:09:00 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LCi63-0005l7-Sb
	for linuxppc-dev@ozlabs.org; Tue, 16 Dec 2008 14:08:55 -0800
Message-ID: <21042870.post@talk.nabble.com>
Date: Tue, 16 Dec 2008 14:08:55 -0800 (PST)
From: bterrell <bterrell@empirix.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8572 - IPR Register
In-Reply-To: <A7BF6E08-786A-4D00-BBEA-1568939722E9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
	<A7BF6E08-786A-4D00-BBEA-1568939722E9@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Kumar Gala-3 wrote:
> 
> 
> <1. Which PCIe port is the device on?
> 2. is this a INT-X style or MSI interrupt?
> 3. if INT-X is INT-A, B, C, D?
> 
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

He was posting a question for me.  The external device (PLX8616
non-transparent bridge) which is sending the interrupt is connected to the
first PCIE controller.  The PCIE controller is configured in RC mode and is
"x4".  I'm using legacy (INTx) interrupts from the external switch NTB port. 
The NTB port always generates INTA, but is swizzled by the upstream port of
the PLX8616 switch, so it comes to the PCIE controller as INTB I believe.

It works fine when the the 8572 and 8616 both start after power-on reset. 
Can send multiple interrupts and each is acknowledged properly.  However,
after I generate a "hot reset" event from the PCIE controller to the
upstream port on the 8616 (or link goes down/up), it no longer seems to
propagate the INTx interrupt to the CPU.  Either the 8616 is not sending the
interrrupt or the 8572 is ignoring/masking it.  I'm trying to determine
which device is at fault.  I don't have access to a PCIE analyzer at the
moment.  Looking for some more visibility into received interrupts within
the 8572 PCIE or MPIC.  

FYI, I have not tried MSI yet but will soon.

thanks,
Bill
-- 
View this message in context: http://www.nabble.com/MPC8572---IPR-Register-tp21040440p21042870.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
