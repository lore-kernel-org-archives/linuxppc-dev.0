Return-Path: <adams.ppc@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 0E6EFDE4EE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 05:03:44 +1000 (EST)
Received: by gxk14 with SMTP id 14so4963802gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 12:03:42 -0700 (PDT)
Message-ID: <4a21eaea0808281203x78a05bb4l4fbd287db4fe59c5@mail.gmail.com>
Date: Thu, 28 Aug 2008 13:03:42 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: cpm_dpalloc questions
In-Reply-To: <48B6D107.30106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4a21eaea0808272212y6be97789nb6b94dd1d4987881@mail.gmail.com>
	<48B6D107.30106@freescale.com>
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

Hi Scott,

> No, MCC1 PRAM starts at offset 0x8700.  Any other areas used are under
> software control.
Yes, you are right. But, I was refereing to MCC channel specific HDLC
parameters.

Reason: I am using the MCC2 which uses memory from offset 0x2000 to
0x4000 for Chan Specific parameters.
you can see that in MCC chapter i.e. 29.3.1 on a MPC8280 manual.
(channel specific HDLC parameters)

I need to make sure that cpm_dpalloc is not using this part of DPRAM
to allocate memory.
I just wanne make sure no other device driver that use cpm_dpalloc to
allocate memory for their BDs i.e. scc, smc, fcc.

and it looks to me like it is allocating me memory starting from 0x128 or 0x400.

> This is obsolete arch/ppc stuff and should be removed; the SMC pram is now
> dynamically allocated and relocated (and before that, it came from the
> device tree).

Yes, I am using 2.6.19.2. I am right now in the middle of finalizing
the BSP port. So, I cannot move on further to device trees. I will
doing that stuff with in a month but now I am with 2.6.19.2.

Regards,
Adams
