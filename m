Return-Path: <strosake@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CA84DDE44
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 17:26:40 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l176Qc8i015591
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 01:26:38 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l176Qcra459460
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:26:38 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l176QbPt027094
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 23:26:37 -0700
Message-ID: <45C97121.9080609@austin.ibm.com>
Date: Wed, 07 Feb 2007 00:26:41 -0600
From: Mike Strosaker <strosake@austin.ibm.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
References: <11707051151024-git-send-email-timur@freescale.com>		<20070206013051.GA15525@lixom.net>	<45C90A6E.3040302@freescale.com>		<17865.2853.132102.769702@cargo.ozlabs.ibm.com>	<1170805102.2620.264.camel@localhost.localdomain>
	<45C91275.4020806@freescale.com>
In-Reply-To: <45C91275.4020806@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
>>If we really want some way of ack'ing that the kernel reached known
>>known steps with something different than a printk-type interface, then
>>we should probably have somewhere a list of well defined numeric
>>constants and use those, but then, I don't like magic numbers.
> 
> 
> Me neither.  I think on systems like RS6000, the progress codes have already 
> been defined, so I don't think we can redefine them.
> 

I think that the LCD panel (op panel, in IBM's parlance) still has its 
uses.  As alluded to by others, the displayed messages are stored by the 
service processor, and a history of messages (the past 200 or so, I 
think) are thus visible from service processor and HMC interfaces. 
Should an error occur when a console session was not attached, these op 
panel codes can sometimes provide enough information to resolve the 
problem without needing to reproduce the error with a console 
attached... maybe not for kernel developers, but possibly for users.

The op panel on recent systems has 2 lines; the first can display 16 
characters, the second, 80.  The first line is usually used to display 
an 8 character hexadecimal progress/error message (called an SRC: System 
Reference Code), and the second line is used to display a location code 
when appropriate (e.g. when the SRC indicates a device failure).  IBM 
documents many of their OF and RTAS SRCs deep in the Hardware 
Information Center:

Error codes: 
http://publib.boulder.ibm.com/infocenter/eserver/v1r3s/index.jsp?topic=/ipha6/refcodelist.htm
Progress codes: 
http://publib.boulder.ibm.com/infocenter/eserver/v1r3s/index.jsp?topic=/ipha6/progcodesmain.htm

I've found some of theses codes useful in the past.  For example, 
CA00E1AE indicates that a partition is waiting for user input at the SMS 
menu.  An analogous SRC to indicate that it is waiting for user input at 
the yaboot prompt might be useful.

IBM reserved these SRC ranges for the exclusive use of Linux; no one 
else (AIX, RTAS, i5/OS, etc.) uses codes in these ranges:

AFxxxxxx - attention codes
BFxxxxxx - error codes
CFxxxxxx - progress codes
DFxxxxxx - dump progress codes

Yeah, magic numbers suck, but the op panel does have some physical 
constraints that prevent the printing of verbose messages.  These codes 
could be mapped to useful messages in a file in Documentation/powerpc, 
for example.

- Mike
