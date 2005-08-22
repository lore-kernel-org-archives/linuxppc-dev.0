Return-Path: <tnt@246tNt.com>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.2.91])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DE1767FD4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 23:30:53 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j7MDUjqf006723
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Aug 2005 15:30:46 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4309D3CF.4030201@246tNt.com>
Date: Mon, 22 Aug 2005 15:31:59 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <4304CE06.6080202@varma-el.com>
In-Reply-To: <4304CE06.6080202@varma-el.com>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] MPC5200 BestComm microcode [en]/[de]coding draft
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Andrey,


Andrey Volkov wrote:
> Hello Sylvain,
> 
> This a draft of Documentation/powerpc/bestcomm.txt,
> it was born since I couldn't find DRD/LCD description and
> "... graphical task builder are currently in development"
> (quotation from AN2604) :(, so I try write doco by myself.
> Here result of my reverse engineering.
> 
> If you or somebody have more information or found some
> bugs, please, fix/expand my text, especially places marked by "?".

First, yes, it's definitly a good idea to work on some documentation on
how to write microcode.

But I'm not sure including that into the Documentation/ directory is
such a good idea. Changing documentation that's there requires sending
patch to Linus and get it processed etc ... And since It's mostly
reverse engineering, it's probably going to change often as we get a
better understanding.

We could publish it as a Wiki (that's a tendency these days ;) so that
everyone can contribute easily and post code examples etc ... What do
you think ?


See comments below for the "real" comments ;)


> +All instructions of Bestcomm microcode are divided on 
> +two main types: LCD (Loop Control Descriptor) and 
> +DRD (Data Routing Descriptor). Any Task must started from 
> +LCD[EX] instruction and finished by DRD instruction (usually NOP).
> +Each of instruction types, in one's turn, are divided on two 
> +and three subtypes accordingly, which are described below:
> +
> +1) DRD1A - load/store data, and, optionally, made some operation 
> +on it (depend on what loaded to FDT). Here is fields description
> +of this DRD:
> +
> +Bits num.  Name          Desc.
> +[31:29]    		Reserved, must be 0 

Well yes, the 3 first bits indicate what type of descriptor it is ;-

> +[28:28]    MORE		?????, if set then idx/var
> +			dst/src fields are changed. I.e. 
> +			[16:10] contain SOURCE, 
> +			and [09:03] contain DESTINATION.

What I got for this bit is that if it's set that means the next DRD is
in the same LCD context, if not, it goes one LCD context before (like a
closing brace for a for loop } ).

> +[27:27]	   TFD		Transfer Frame Done. Assert frame 
> +			done Transfer Frame Done line of 
> +			selected (in INIT field) periphery.
> +[26:26]	   INT 		Interrupt. If set to 1, 
> +			then generate core interrupt

Generate the core interrupt when the bestcomm engine exits the current
LCD. Don't know why it's part of the DRD descriptors and from what a
Freescale engineer told me, he doesn't know either ;)


> +[25:21]	   INIT		Initiator (aka requestor) number.
> +[20:19]	   RS		Read Size (0 - 32bit word, 1 - byte,
> +			2 - 16 bit word, 3 - dynamic/reserved??
> +			(masked in real	time?))

IIRC, there is a field in the SDMA registers to specify what 3 means.
However, the bestcomm api replace all the 3 with the correct size in the
ucode itself. That functionnality may not work or just isn't practical.
Best to have the correct size specified when running the task anyway.

> +[18:17]	   WS		Write Size (see above)
> +[16:16]			??????????????
> +[15:15]	   		Destination index prefix, 
> +			if set (i.e. =1), then bitfield [13:10]
> +			contain index number, and [14:14] have 
> +			meaning of indirect addressing flag.
> +			If this field cleared then field 
> +			[14:10] contain	index of VARIABLE.
> +[14:14]			Indirect addressing by idx, 
> +			(and only by idx) flag, or high bit of
> +			variable index.
> +[13:10]			index of DESTINATION/SOURCE idx/var.
> +
> +[09:09]			???? For some cases 1, for another 0.????
> +
> +[08:08]			Same as in [14:10], but for source.
> +[07:03]			Same as in [14:10], but for source.
> +[02:00]	   EU3		Number of function, which will execute
> +			on EU#3.

[2:0] is FN but what do you exactly mean it is. The only thing I notice
is that if it =1 then the source is "EU3()" ... whatever that means.

Also, I'm not sure it has something to do with the FDT since there is
only 3 bits.


> +Note: For DRD1A exist special case, aka NOP, which act as 
> +task terminator. Fields, in this case, have next meanings:
> +
> +[31:28]			Reserved must be 0.
> +[27:27]	  TFD		Transfer Frame Done. 
> +[26:26]	  INT 		Interrupt.
> +[25:21]	  INIT		Initiator (aka requestor) number. Usually 0,
> +			or ALWAYS INITIATOR.
> +[16:00]	  NOP code	Must be 0x1f8 

Where did you see that that you could use theses bit in NOP ?


> +Ex. Please, pay attention to first two lines: since MORE is set,
> +codes for idx2 and var13 are in different fields, then for case
> +where MORE is not set (var4 = var2).:
> + 0x10601010 -- DRD1A: var4 = var2; FN=0 MORE init=3 WS=0 RS=0
> + 0x00008868 -- DRD1A: idx2 = var13; FN=0 init=0 WS=0 RS=0
> + 0x0404c999 -- DRD1A: *idx2 = EU3(); FN=1 INT init=0 WS=2 RS=0
> + 0x000001f8 -- DRD1A: NOP
> + 0x040001f8 -- DRD1A: INT init=0
> +
> +Next two DRDs are ALWAYS coupled, i.e it is impossible to using 
> +DRD2B1 without preceded DRD2A, but any (?fixme?) number DRD2B1 
> +may followed by DRD2A.

? AFAIU it's either
DRD2A, DRD2B1
or
DRD2A, DRDF2B2

> +2) DRD2A - setup bestcomm Execution Unit (EU)
> +Bitfields encodings:
> +
> +Bits num.  Name          Desc
> +[31:31]    MORE		?????????
> +[30:29]    EXT		must be always initialized 
> +			by 3 (binary 11)

What I have is that
[31:29] Always 011 - Indicates a DRD2A.
[28:28] MORE -  Same meaning as before. Just tells if the following
(here that's the one that is after the corresponding DRD2B{1,2}) DRD is
in the same loop or if it's in the previous loop level ?


> +[27:27]	   TFD		Transfer Frame Done.
> +[26:21]	   INIT		Initiator number.
> +[20:19]	   RS		Read Size 
> +[18:17]	   WS		Write Size
> +[16:04]			reserved, must be 0

They are the function number to use in EU#{0,1,2} but in MPC5200, only
EU3 is implemented.

> +[03:00]	   EU3		Number of function, which will execute
> +			on EU#3 at DRD2B1 time.
> +Ex:
> + 0x60140002 -- DRD2A: EU3=2 EXT init=0 WS=2 RS=2
> +
> +3) DRD2B1 - execute function and store result of it. 

Can't find the piece if paper where I wrote about DRD2B1 ...
For DRD2B2 there is only 1 example I know of, so quite hard to deduce
anything.

> +4) LCD - run followed loop microcode, or may be used for checking
> +some conditions. LCD may be nested (only two levels are supported).

Two levels ? Didn't know that but sure there is no example with 3 levels.

> +
> +Bits num.  Name          Desc
> +[31:31]	   LOOP		Loop prefix, always 1
> +[30:30]			???????????????????
> +[29:23]	   INIT1	???Initializition part of first init expression.???
> +[22:11]			???????????????????
> +[10:06]	   CMP_VAR	Variable to which idx compared. Part of
> +			Termination control.
> +[05:03]	   INC1		increment1 
> +[02:00]	   INC2		increment2, if unsused may be any value 

What I got :

bits[31:30] : 10 - identify a LCD
bit [29   ] : d  - Whether to dereferentiate init_a or not. idx_a =
deref ? *(init_a) : init_a
bits[28:27] : ta - Type of init_a : 00 -> var
                                    11 -> idx
bits[26:23] : ia - init_a : Where to find initial value for idx_a
bits[22:21] : ?? - Unknow
bits[20:19] : tb - Type of init_b
bits[18:15] : ib - init_b
bits[14:13] : cc - condition_choice : 00 - use idx_a
                                      01 - use idx_b
                                      11 - no condition
bits[12:11] : ?? - Unknow always 00
bits[10: 6] : ca - condition_arg : What to do the comparaison against
bits[ 5: 3] : sa - step_a : What inc[] to use to increment idx_a (and
also where to look for the condition code)
bits[ 2: 0] : sb - step_b


Condition codes (first 4 bits of the increments)
>=   c
>    4
once 0
!=   6
<=   a
<    2



> +5) LCDEXT - If in yours loop used more then 2 indexes, then 
> +this record MUST PRECEDED LCD. Also loop end condition MAY pointed HERE,
> +then it not pointed in LCD. 
> +
> +Bits num.  Name          Desc
> +[31:31]	   LOOP		Loop prefix, always 1
> +[30:30]			???????????????????
> +[29:23]	   INIT1	???Initializition part of first init expression.???
> +[22:11]			???????????????????
> +[10:06]	   CMP_VAR	Variable to which idx compared. Part of
> +			Termination control.
> +[05:03]	   INC1		increment1 
> +[02:00]	   INC2		increment2, if unsused may be any value 

similar to LCD


	Sylvain
