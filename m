Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from imagateway.smiths-aerospace.com (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 866E42BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 01:06:28 +1100 (EST)
Message-ID: <41DAA2D7.5000408@smiths-aerospace.com>
Date: Tue, 4 Jan 2005 09:06:15 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <000401c4f261$dca2c1e0$1269cb0a@bgcw301>
In-Reply-To: <000401c4f261$dca2c1e0$1269cb0a@bgcw301>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: Linux Kernel boot problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Srivatsan wrote (badly quoted):
> * *
> *Well, what are the last readable messages you can find in the buffer?*
> * *
> *The last readable message which I see in the log buffer is *
> * *
> 
> *00138BD4: 3C 36 3E 4D 65 6D 6F 72  79 20 42 41 54 20 6D 61  |<6>Memory BAT ma|*
> *00138BE4: 70 70 69 6E 67 3A 20 42  41 54 32 3D 31 36 4D 62  |pping: BAT2=16Mb|*
> *00138BF4: 2C 20 42 41 54 33 3D 30  4D 62 2C 20 72 65 73 69  |, BAT3=0Mb, resi|*
> *00138C04: 64 75 61 6C 3A 20 30 4D  62 0A 00 00 00 00 00 00  |dual: 0Mb.......|*
> 
> *Any pointers will surely help me with the problem. *
> 
> *I have tried with all serial ports, I find that the porting is done 
> fine. I checked with the MPC860 porting document available on the web. *
> 
> *Any pointers will surely help me. Thanks Mr.Wolfgang and everyone for 
> sparing me time.*
> 
> *Best regards,*
> *C.R.*Srivatsan

I don't have a clue, but The Source Knows (TSK).  The following is very 
generic advice...

The "<6>" is a progress stamp put out by the kernel start up code.  Find 
where it is printed and/or where the BAT mapping message is printed and 
look what the kernel does next.  Somewhere between "<6>" and where "<7>" 
would be printed if your kernel didn't crash is where the problem lies. 
  If the crash location isn't obvious, move the "<7>" back in the code 
until you see it coming out, which will further narrow down the error area.

My totally uneducated guess (TUG) is that you have problems with your 
BAT configuration.  Compare your memory map to how your BATs are set up 
by the linux kernel.  Also, verify that EVERY piece of hardware 
(ESPECIALLY the uart hardware) is mapped properly (probably by a BAT) at 
this point in time.  My TUG is that you are trying to access a piece of 
hardware (likely a uart or a blinking LED) that isn't mapped and thus 
you are getting a memory map fault.  At this point in time, memory map 
faults are very silent and very deadly.

gvb
P.S. Sorry for all the bad TLA humor ;-)
