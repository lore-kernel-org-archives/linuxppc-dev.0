Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 5825B67C42
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 06:37:02 +1000 (EST)
To: Theo Gjaltema <gjalt007@chello.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Jul 2005 17:41:15 +0200."
	<42D5361B.2070402@chello.nl>
Date: Wed, 13 Jul 2005 22:32:04 +0200
Sender: wd@denx.de
Message-Id: <20050713203204.7F711353A37@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <42D5361B.2070402@chello.nl> you wrote:
> 
> It appeard that on my mpc862 target I had also this problem. I am using
> ELDK3.1.1 which includes a 2.4.25 kernel.

No, most definitely not.

>     Large application (20MB c++, mostly shared-libs) crashes (sigseg) at
> startup BEFORE main() is called.
>     Attempts to debug the application also fail: the debugger crashes
> also (sigseg).

I bet that this is a FAQ. Your SDRAM initialization is broken.

> I didn't change the C-lib, I took the 2.4.30/arch/ppc/kernel/head_8xx.S
> file and copied this over the 2.4.25 head_8xx.S file.
> In the 2.4.30 version there is a piece of code mentioning the dcbX
> instruction problems.

And did this fix the problem completely? I would be a bit surprised.

> This driver causes the CPM sometimes to hang when performing a memset,
> can this be caused by the same problem?

Yes. When your SDRAM init is broken, strange things will happen.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Work 8 hours, sleep 8 hours; but not the same 8 hours.
