Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 8CE7A2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 07:32:38 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 9C6E310BAF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 09:32:37 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 2382010BA2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 09:32:37 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I8F003015B26500@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 09 Dec 2004 09:32:37 +1300 (NZDT)
Date: Thu, 09 Dec 2004 09:32:36 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <003801c4dd26$d0e30090$0301a8c0@chuck2>
To: Mark Chambers <markc@mail.com>
Message-id: <41B764E4.6020103@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1
References: <41B67FCF.6040100@tait.co.nz>
	<1102498710.414.98.camel@linpc003.aimsys.nl>
	<003801c4dd26$d0e30090$0301a8c0@chuck2>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Exception handling on mpc8xx cores
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mark Chambers wrote:
> 
>>On Wed, 2004-12-08 at 05:15, Robin Gilks wrote:
>>
>>>Greetings
>>>
>>>Any Freescale lurkers out there?
>>>
>>>The mpc866 manual implies that if the internal core times out an 
>>>external Transfer Acknowledge bus signal (by exerting the internally 
>>>generated Transfer Error Acknowledge signal) an exception is generated.
>>>
>>>I've tried extending the external TA signal well beyond 2040 clock 
>>>cycles the maximum timeout allows and I see the busses start up again 
>>>(indicationg that they are no longer waiting) but I don't see anything 
>>>on TEA and I don't get an exception thrown.
>>>
>>>Any clues? Manual error?, silicon error?, my brain error?
>>
>>Did you enable the bus monitor in the SYPCR register?
>>
> 
> 
> You've also got to have ME set in MSR to get the exception.  For whatever 
> it's worth, I have an mpc852 design (part of 866 family) that uses external
> acknowledge and it works as advertised.  I've seen the acknowledger,
> a DSP, fail, and we get a machine check exception.  (I've never 
> looked at TEA, though).
> 
> Mark Chambers

Identical situation to mine (well nearly).

Using a 859T CPU, the HPI to a DSP is being investigated and in doing so 
we've been forcing the DSP to delay TA to the ppc to check that we get 
an exception but we don't :-((

ME is set in MSR, BME is set in SYPCR, hair gradually disappearing. 
Guess its more debugging...

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
