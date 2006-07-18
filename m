Return-Path: <leisun124@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 5767F67B6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 13:40:46 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c29so33381nfb
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Jul 2006 20:40:45 -0700 (PDT)
Message-ID: <f9a7e7a80607172040lcf0a280x5df9f44d10a0b7d6@mail.gmail.com>
Date: Mon, 17 Jul 2006 23:40:44 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: reboot on PQ2FADS board.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:
    I have linux 2.4.30 runnning on this board, the "reboot -f"
command cause machine check and kernel ooops.  The problem seems in
the "m8260_gorom" in head.S.  The restart() function in m8260_setup.c
passed 2 parameters to that assembly code, r3 is the bd_info , r4 is
the warm start address,  I changed it to 0xFF800100, that's where the
u-boot's _start_warm lives, I have verified that address by typing "g
ff800100" in u-boot console, which cause the board reset.
    I assume the m8260_gorom  has been heavily tested for other
boards. I wonder if anyone got a PQ2FADS-VR board that has the similar
problem?  I am not familar with the assembly code for PPC.  Any
suggestions?

Thanks
lei
