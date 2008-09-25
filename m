Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 4204BDDE00
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 21:52:23 +1000 (EST)
Received: by gxk14 with SMTP id 14so6619569gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 04:52:22 -0700 (PDT)
Date: Thu, 25 Sep 2008 07:51:18 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: seokin Hong <nagne_hsi@naver.com>
Subject: Re: Tickless and CPU Idle framework for PPC405
Message-ID: <20080925115118.GA2243@yoda.jdub.homelinux.org>
References: <001301c91e90$7e0090e0$7a01b2a0$@com>
	<20080925001323.GA26152@yoda.jdub.homelinux.org>
	<002a01c91ede$d3fdd310$7bf97930$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002a01c91ede$d3fdd310$7bf97930$@com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 04:17:54PM +0900, seokin Hong wrote:
>Generic processor idle management framework 
>http://ols.108.redhat.com/2007/Reprints/pallipadi-Reprint.pdf
>
>The interface and machine independent interface is in following directory..
>/drivers/cpuidle
>
>So, I wonder that the linux kernel ported for PPC405 use this framework to
>save power.

No.

PPC4xx doesn't have multiple hardware idle states, so having a govenor to
manage that doesn't really make sense.

There was work done to support putting the CPU in wait state on idle for
PowerPC 440 chips.  That could probably be ported over.  Beyond that, the
cpuidle framework just seems like overkill for these CPUs.

>And Is the tickless feature is added to that kernel?

Tickless was added to all of PowerPC around 2.6.21 or 2.6.22 I think.  I
don't recall anything explicitly added for 405, but it should make use of
the generic support.

josh
