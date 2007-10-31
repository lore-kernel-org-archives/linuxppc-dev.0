Return-Path: <jacmet@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 2E1ECDDD0D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 01:45:41 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so19844and
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 07:45:40 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] Uartlite: speed up console output
References: <20071023042353.30309.93118.stgit@trillian.cg.shawcable.net>
	<20071023042746.30309.15188.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 31 Oct 2007 15:45:02 +0100
In-Reply-To: <20071023042746.30309.15188.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Mon\, 22 Oct 2007 22\:27\:46 -0600")
Message-ID: <87mytz4a35.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Change the wait_tx routine to call cpu_relax() instead of udelay() to
 Grant> reduce console output latency and test for the TXFULL bit instead of
 Grant> TXEMPTY.  That way the FIFO doesn't need to by 100% flushed before
 Grant> writing the next character.

Sorry for the slow response - I had a misunderstanding with the
phone company, and I'm now without inet :/

Looks good to me. I gave it a quick spin to check the speed
difference:

Old:
[    0.453101] Freeing unused kernel memory: 52k init

New:
[    0.433686] Freeing unused kernel memory: 52k init

So it shaves off ~20ms (~4%) of bootup.

It ofcause means that the console routines return before the data is
actually transmitted on the wire, but I guess you have to screw
seriously up for the UART to die before emptying it's FIFO.

 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
