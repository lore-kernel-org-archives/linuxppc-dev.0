Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 3D7D167A78
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 10:21:20 +1100 (EST)
Message-ID: <41F03CEA.2030703@mvista.com>
Date: Thu, 20 Jan 2005 16:21:14 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
	<20050119180841.GP28724@smtp.west.cox.net>
	<41F01A23.2090907@mvista.com>
	<20050120225321.GB2626@smtp.west.cox.net>
In-Reply-To: <20050120225321.GB2626@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>So you're saying that using the hook directly isn't a different hook?  I
>suppose we can agree to disagree, since it's not relevant really :)
>

Well, I could have not used genrtc at all and duplicated the code like 
others have (e.g., ds1302 and ip27-rtc.c) but I chose to reuse code 
that's already there and debugged.  Chosing to interface to genrtc 
instead of ppc_md.xxx is chosing to have it work on a wider variety of 
platforms over flexibility within one particular type of platform.  Pros 
and cons to each.

>It can't work on PPC/MULTIPLATFORM as that's a kernel with multiple rtc
>chips in one binary (pmac, todc for prep, chrp?).
>

The point I was making is there there is nothing precluding a kernel 
that runs on several boards from using it as long as that's the rtc chip 
on all the platforms  Its already clear that if there are different rtc 
chips, it won't work.

>
>Why ask the user for something you know he wants?  If they've selected
>GENRTC and are using the board, they'll probably want GENRTC to work.
>It's exactly what you described except the user won't have to know about
>anything going on.
>

If that's the way you want to go then it should depend on having the rtc 
"driver" selected and rtc.h should look something like:

#if defined(CONFIG_I2C_<rtc_driver_a>) || defined(CONFIG_<rtc_driver_b> ...

For now, it would only have to be #ifdef CONFIG_xxx_M41T00

That's fine with me.
