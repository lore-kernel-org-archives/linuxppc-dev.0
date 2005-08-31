Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B99468224
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 01:51:02 +1000 (EST)
Message-ID: <4315D1DC.1000607@varma-el.com>
Date: Wed, 31 Aug 2005 19:50:52 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>, Wolfgang Denk <wd@denx.de>
References: <4304CE06.6080202@varma-el.com> <4309D3CF.4030201@246tNt.com>
In-Reply-To: <4309D3CF.4030201@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hello Sylvain, Wolfgang

Sorry for silence, I was out of office last week.
(And will be absent at next two weeks too).

Wolfgang, first question to you:
May be you are know where I could find (if it exist)
BestComm (SmartComm) API for mystic MGT5100?

Sylvain Munaut wrote:
> 
> But I'm not sure including that into the Documentation/ directory is
> such a good idea. Changing documentation that's there requires sending
> patch to Linus and get it processed etc ... And since It's mostly
> reverse engineering, it's probably going to change often as we get a
> better understanding.
I agree with Wolfgang's opinion: when I seek description of some kernel
part, I'm firstly check Documentation/, next grepping kernel tree.
In any case, when doco will be completed it will not changed often.

> 
> We could publish it as a Wiki (that's a tendency these days ;) so that
> everyone can contribute easily and post code examples etc ... What do
> you think ?

Agree, good think. Wolfgang, is it appropriately to use WIKI of denx.de?

> See comments below for the "real" comments ;)
> 
>>+[18:17]	   WS		Write Size (see above)
>>+[16:16]			??????????????
>>+[15:15]	   		Destination index prefix, 
>>+			if set (i.e. =1), then bitfield [13:10]
>>+			contain index number, and [14:14] have 
>>+			meaning of indirect addressing flag.
>>+			If this field cleared then field 
>>+			[14:10] contain	index of VARIABLE.
>>+[14:14]			Indirect addressing by idx, 
>>+			(and only by idx) flag, or high bit of
>>+			variable index.
>>+[13:10]			index of DESTINATION/SOURCE idx/var.
>>+
>>+[09:09]			???? For some cases 1, for another 0.????
>>+
>>+[08:08]			Same as in [14:10], but for source.
>>+[07:03]			Same as in [14:10], but for source.
>>+[02:00]	   EU3		Number of function, which will execute
>>+			on EU#3.
> 
> 
> [2:0] is FN but what do you exactly mean it is. The only thing I notice
> is that if it =1 then the source is "EU3()" ... whatever that means.

> 
> Also, I'm not sure it has something to do with the FDT since there is
> only 3 bits.
With first 7 functions, as I understand. In theory it may be any
function (depend on functions arrangement in FDT).

>>+Note: For DRD1A exist special case, aka NOP, which act as 
>>+task terminator. Fields, in this case, have next meanings:
>>+
>>+[31:28]			Reserved must be 0.
>>+[27:27]	  TFD		Transfer Frame Done. 
>>+[26:26]	  INT 		Interrupt.
>>+[25:21]	  INIT		Initiator (aka requestor) number. Usually 0,
>>+			or ALWAYS INITIATOR.
>>+[16:00]	  NOP code	Must be 0x1f8 
> 
> 
> Where did you see that that you could use theses bit in NOP ?
INT - was used in image_rtos1/TASK_PCI_TX for example.
INIT,TFD - my assumption, not sure certainly.

>>+Ex. Please, pay attention to first two lines: since MORE is set,
>>+codes for idx2 and var13 are in different fields, then for case
>>+where MORE is not set (var4 = var2).:
>>+ 0x10601010 -- DRD1A: var4 = var2; FN=0 MORE init=3 WS=0 RS=0
>>+ 0x00008868 -- DRD1A: idx2 = var13; FN=0 init=0 WS=0 RS=0
>>+ 0x0404c999 -- DRD1A: *idx2 = EU3(); FN=1 INT init=0 WS=2 RS=0
>>+ 0x000001f8 -- DRD1A: NOP
>>+ 0x040001f8 -- DRD1A: INT init=0
>>+
>>+Next two DRDs are ALWAYS coupled, i.e it is impossible to using 
>>+DRD2B1 without preceded DRD2A, but any (?fixme?) number DRD2B1 
>>+may followed by DRD2A.
> 
> ? AFAIU it's either
> DRD2A, DRD2B1
> or
> DRD2A, DRDF2B2
Oops, I miss DRD2B2, but then situation become more clean:
DRD2B2 - load accumulator of execution unit.

Then 0x1f code in DRD2B1 OP2 (and may be in OP1) mean EU accumulator.

>>+2) DRD2A - setup bestcomm Execution Unit (EU)
>>+Bitfields encodings:
>>+
>>+Bits num.  Name          Desc
>>+[31:31]    MORE		?????????
>>+[30:29]    EXT		must be always initialized 
>>+			by 3 (binary 11)
> 
> 
> What I have is that
> [31:29] Always 011 - Indicates a DRD2A.
> [28:28] MORE -  Same meaning as before. Just tells if the following
> (here that's the one that is after the corresponding DRD2B{1,2}) DRD is
> in the same loop or if it's in the previous loop level ?
> 
>>+[27:27]	   TFD		Transfer Frame Done.
>>+[26:21]	   INIT		Initiator number.
>>+[20:19]	   RS		Read Size 
>>+[18:17]	   WS		Write Size
>>+[16:04]			reserved, must be 0
> 
> They are the function number to use in EU#{0,1,2} but in MPC5200, only
> EU3 is implemented.

I extend description.

>>+[03:00]	   EU3		Number of function, which will execute
>>+			on EU#3 at DRD2B1 time.
>>+Ex:
>>+ 0x60140002 -- DRD2A: EU3=2 EXT init=0 WS=2 RS=2
>>+
>>+3) DRD2B1 - execute function and store result of it. 
> 
> 
> Can't find the piece if paper where I wrote about DRD2B1 ...
> For DRD2B2 there is only 1 example I know of, so quite hard to deduce
> anything.
Two if be more precisely :), both in CRC16 u-code.

>>+4) LCD - run followed loop microcode, or may be used for checking
>>+some conditions. LCD may be nested (only two levels are supported).
> 
> Two levels ? Didn't know that but sure there is no example with 3 levels.
Ok, I remove this sentence, it was born, because I doesn't found
how loops are terminated (as you point, it was absence of bit in
DRD :) ).

-- 
Regards
Andrey Volkov
