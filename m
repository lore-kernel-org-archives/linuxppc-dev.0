To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial console ports on systems with no console connected. 
In-Reply-To: Message from Arun Dharankar <ADharankar@ATTBI.Com>
   of "Thu, 25 Jul 2002 20:58:04 -0400." <200207252058.04074.ADharankar@ATTBI.Com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 12:22:13 +1000
Message-ID: <4951.1027650133@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 25 Jul 2002 20:58:04 -0400, Arun Dharankar <ADharankar@ATTBI.Com> writes:
>As for what I meant to say is that the solution for me is to use the
>SCC4 based port which has been designated as the console port
>for the boards. This one does have the flow control wired to the
>8260 and makes a difference when I use a null modem.

I dealt with this a long time ago, so the details are a bit hazy, but I seem
to recall that you could set the I/O pins on the 8260 that provided the flow
control functions to be general purpose I/O pins, which forced the flow control
functions to be tied in a default state (which I think was equivalent to the
"tied high" state on the serial port side). This way you can use a much simpler
serial cable. Check out the I/O pin init table in your board configuration (you
also have to ensure that the secondary I/O pins for the flow control functions
are not enabled).

Did you try the serial port a lower speeds? Are you running your SCC port at
115200 still? If so, what are you using as the clock source for the BRG for
the SCC port? What is your BRG clock rate (it is printed by ppcboot when the
board powers up - as brg_clk)?

The default BRG clock is the VCO_OUT clock rate divided by 16. To find out the
value of VCO_OUT can be complicated, but on my 8260, which is a 133/133/66
device (cpu/cpm/bus clocks), VCO_OUT is twice the CPM clock rate (266MHz or
rather, 266,666,664 Hz give or take a couple). So 266,666,664 / 16 = 16666666Hz
We usually use 16 times over-sampling in the SCC, hence you have a number like
1041667 which you must divide to provide all your baud rates. This is not a
nice number for baud rates (the Hymod board has an external clock source that
is programmed to run at 3686400 which gives the number 230400 after accounting
for 16 times oversampling - a nice looking number for baud rates.

I still think you will have trouble with the mismatch in baud rate at speeds
higher than 38400 when you use the default BRG_CLK. Can anyone else confirm
this? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/

To the extent permitted by law, CSIRO does not represent, warrant and/or
guarantee that the integrity of this communication has been maintained or
that the communication is free of errors, virus, interception or interference.

The information contained in this e-mail may be confidential or privileged.
Any unauthorised use or disclosure is prohibited. If you have received this
e-mail in error, please delete it immediately and notify Murray Jensen on
+61 3 9662 7763. Thank you.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
