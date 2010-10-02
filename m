Return-Path: <acahalan@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 592C5B7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Oct 2010 05:32:43 +1100 (EST)
Received: by fxm2 with SMTP id 2so2849228fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Oct 2010 11:32:41 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 2 Oct 2010 14:32:41 -0400
Message-ID: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
Subject: use of BAT before taking over the MMU
From: Albert Cahalan <acahalan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the prom boot path, with the firmware supposed to
be managing the MMU, there is a case where:

1. Linux changes some BAT registers.
2. Bits 0x00000070 are/become set in the MSR.
3. Linux takes an MMU fault.
4. The firmware handles it.

AFAIK, you can't expect the firmware to leave the BAT alone.
If the firmware provides mapping services by using the BAT
as a software-filled TLB, Linux's BAT changes may be lost.

You also can't expect that your BAT changes will not conflict
with mappings that the firmware uses for itself. The firmware
might write to your new BAT mapping, relying on those virtual
addresses to be something else entirely.
