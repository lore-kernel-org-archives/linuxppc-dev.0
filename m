Date: Tue, 26 Jan 1999 16:35:18 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: David Edelsohn <dje@watson.ibm.com>,
        "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Help from Kernel Gurus needed!!! 
In-Reply-To: <Pine.LNX.4.03.9901252224310.29711-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.990126162935.2291G-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 25 Jan 1999, Geert Uytterhoeven wrote:

> 
> On Mon, 25 Jan 1999, David Edelsohn wrote:
> > 	If you are just trying to copy r1 into r0, why not use move
> > regsiter instead of add immediate as the following:
> > 
> > 	__asm__ ("mr %0,1" : "=r" (p) : );
> 
> Hehe, the clue is that IBM/Motorola didn't implement instructions that perform
> operations that can be done in a different manner, too.
> 
> `mr' is just an alias for add with zero.

No, mr %0,%1 is an alias for ori %0,%1,0 because addi does not work when
the source register is r0. OTOH, li and lis are aliases for addi and addis
with r0 as second operand, it is clearer in the POWER mnemonics where they
are called cal and cau for compute address {lower,upper} which directly 
shows that they use the same convention as the addressing mode noted 
as (rA|0) in the documentation.

	Greetings,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
