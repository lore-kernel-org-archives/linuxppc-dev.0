Message-Id: <v03010d0cb43a9d52cd3e@[192.168.1.16]>
In-Reply-To: 
 <Pine.LNX.4.10.9910251916060.5902-100000@modemcable220.93-200-24.mtl.mc.vi
 deotron.net>
References: <199910252231.PAA08775@sade.ddi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 25 Oct 1999 16:53:52 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Rob Barris <rbarris@quicksilver.com>
Subject: Re: question about altivec registers
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The flag is to actually tell the kernel that your application is using
>the Altivec registers, so that it can save time by not saving and
>restoring them when the interrupted or swapped application is not using
>them. It is supposed to be dynamic so only routines actually using Altivec
>should set (and clear) it. I am not sure of the details so look into the
>manual for the hardware support. I think the kernel should enforce the
>use of this flag since moving the full Altivec register set is time
>consuming (16 bytes X 32 registers = 1/2 KB).

   I worked this out once, the extra 512 bytes of register context,
multiplied by (say) a thousand context switches per second only add up to
about a MB of memory traffic per second - a fraction of a percent of the
available memory bandwidth in a G4 machine.  Most of that will sit in cache
anyway depending on the working set size of the processes involved.

   Wiggling the mouse probably causes more memory traffic than that (code
fetches and ISR handling).

   And this is with a very high hypothetical context switch rate which I
suspect may never be seen in real life use.

--
Rob Barris       Quicksilver Software Inc.      rbarris@quicksilver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
