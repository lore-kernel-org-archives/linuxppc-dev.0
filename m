Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4D30067EEE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 11:29:07 +1000 (EST)
In-Reply-To: <20050821235524.GE6746@dmt.cnet>
References: <43062C9D.5060703@ru.mvista.com> <20050821235524.GE6746@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b3aa1ae4c201e865b6dfbef68253983b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 21 Aug 2005 21:28:56 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx pq platform system descriptions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 21, 2005, at 7:55 PM, Marcelo Tosatti wrote:

> - Do you have any plans on actually using device model information by
> drivers (as was done in the mpc8xxx/gianfar) on m8xx? Its not very 
> clear
> to me what are the the practical advantages of that?

It may be nice if we can do that.  We have to be careful about sharing
CPM drivers between the 8xx and CPM2 (82xx/83xx/85xx).  It's tempting,
but I still believe the differences outweigh the similarities.  The 
overhead
of trying to use common drivers would be quite costly on the 8xx.

> - I don't know whether its possible to retrieve 8xx CPUID information
> (if there is any). Can't find anything in the manual.

We really can't.  The PVR only represents the processor core 
information,
and for the most part they are all the same.  It used to be we could use
the CPM microcode version, but these are now nearly the same.  Some
attempts have been made to probe for CPM peripherals that don't exist,
but it seems on some parts the CPM is the same and the signals just 
aren't
bonded out of the chip.

For the most part, the person doing the kernel configuration just simply
has to know what part they are using.  You have to select the proper
peripherals, and you need the board support for the IO pin routing.
In an embedded environment where resources still need to be
carefully managed, I don't think this is unrealistic.

Thanks.

	-- Dan
