Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 44E4E67A5C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 10:54:08 +1100 (EST)
Message-ID: <41F0449C.5020603@mvista.com>
Date: Thu, 20 Jan 2005 16:54:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com> <1106259956.18397.10.camel@gaston>
In-Reply-To: <1106259956.18397.10.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>
>The patch is going backward since it disables the ability to have
>runtime selection of the RTC chip.
>

Its only "backwards" from a narrow PPC point of view.  Without a major 
rewrite of the rtc infrastructure, these are the choices:

a) Make a ppc-only solution using ppc_md.xxx.
b) Make a generic solution either by writing an entire driver 
duplicating code that's in genrtc (e.g., ds1302) or interface to the 
bottom of genrtc (e.g., my rtc code).  The only limitation is that you 
can't select different rtc chips at runtime.

Choosing a) give you more flexibility within PPC but is PPC only; 
choosing b) is generic but assumes its the only rtc chip that will be 
used by whatever kernel binary its put in.

I chose b) and to reuse the genrtc code.  In a sane world, reusing code 
is considered a good thing...

Its obvious that you and Tom prefer a).  That's fine but if I switch to 
a), I know the first comment I'll get when I post the driver to lmkl 
will be, "Why would you make this ppc-specific when you could have made 
it generic?"  Will you and Tom then defend that decision for me?

Also, this is not board-specific as you and Tom have tried to suggest.  
Assuming I change the #ifdef in rtc.h to remove the option as I think 
Tom and I are agreeing upon, you select the i2c algo/adapter, the 
i2c/rtc client and its there.  Where are the "gross hacks for every board"?

Mark
