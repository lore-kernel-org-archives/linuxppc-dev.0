Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 81DC8DE04A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 07:08:47 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 16 Jan 2007 21:08:38 +0100
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH][v2] atomic_dec_if_positive sign extension fix
Message-ID: <20070116200838.GA22381@iram.es>
References: <20070114225502.GA21471@austin.ibm.com>
	<20070116181604.GA24756@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070116181604.GA24756@austin.ibm.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 16, 2007 at 12:16:05PM -0600, Robert Jennings wrote:
> Paul,
> 
> Here is v.2 for the patch. 
> Please apply for 2.6.20.  If an atomic counter is explicitly set to a
> negative value the atomic_dec_if_positive function will decrement and
> store the next smallest value in the atomic counter contrary to it's
> intended operation.
> 
> The comparison to determine if the decrement will make the result
> negative is done by the "addic." operation which operates on a 64-bit
> value.  I've changed the addic to an addi (changing "=&r" to "=&g" in

I think the proper constraint is "=&b". 

	Gabriel
