Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 928EB67A6E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2005 02:01:59 +1100 (EST)
Received: from Jocke ([84.217.0.212]) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id j2KEMINX031150
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Mar 2005 15:22:19 +0100
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Linuxppc-Dev" <linuxppc-dev@ozlabs.org>
Date: Sun, 20 Mar 2005 15:22:16 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHIECMCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHKECDCLAA.Joakim.Tjernlund@lumentis.se>
Subject: RE: PCC ABI question
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> Hi Folks
> 
> It seems to me that linux doesn't follow the ABI for PowerPC.
> According to http://refspecs.freestandards.org/elf/elfspec_ppc.pdf,
> Figure 3-31(Initial Process Stack) should the stack ptr point to a NULL word, instead
> linux's stack ptr points to argc and there is no NULL word, correct?
> 
> The initial register map, on p. 3-28, register r7 should point to a
> "termination function" or hold zero. Does linux do this?
> If so, where does it get the "termination function" from?
> If not, can one assume that r7 is NULL at all times?
> 
> Are there other deviations from the above spec in linux?
> 
>  Jocke 

[Moving this to linuxpcc-dev list]

Someone was kind enough to point me to this spec:
http://refspecs.freestandards.org/LSB_2.0.1/LSB-Core-PPC32/LSB-Core-PPC32/processinitialization.html
Which says:
"Contrary to what is stated in the Registers part of Chapter 3 of the System V Application Binary Interface PowerPC
Processor Supplement there are no values set in registers r3, r4, r5, r6 and r7. Instead the values specified to
appear in all of those registers except r7 are placed on the stack. The value to be placed into register r7,
the termination function pointer is not passed to the process."

It is not quite clear to me if r3, r4, r5, r6 and r7 contains random data or if one
can assume that some of them are set to NULL. It would be good if one could assume
that r7 is always set to NULL as that would simplify the startup code(crtX.S) in uClibc which
I am updating to support passing a FINI function ptr in r7.

 Jocke
