Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 048822BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jan 2005 02:52:00 +1100 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Wolfgang Denk" <wd@denx.de>, <linuxppc-embedded@ozlabs.org>
Date: Sun, 2 Jan 2005 15:12:01 +0100
Message-ID: <BCEFJBPJCGFCNMMMIDBHOEPBCJAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: CPU15 errata workaround for 8xx by WD
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Wolfgang

Had a look at your CPU15 errata workaround for 8xx and I have a comment
or two:

1) I think you should make the sysctl support a compile time option
   as the overhead for sysctl support in the TLB handler is 6 instr. when
   the fix itself is only 4 instr.

2) You placed the workaround in the middle of the CPU6 workaround which will
   disable the CPU6 workaround(I think). Move it before the #ifdef CONFIG_8xx_CPU6
   and you should be fine.

3) Your test program uses the dcbst and dcbi instr. and these are buggy as they do not
   update the DAR register in the TLB exceptions. I guess you made sure that such errors
   will not happen?

4) The CPU15 bug has been around for years I think, what made it show up now? New toolchains?
   

 Jocke
   
