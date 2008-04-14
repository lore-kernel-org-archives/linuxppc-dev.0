Return-Path: <jirislaby@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 0116CDE096
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:43:39 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1448079fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 08:43:37 -0700 (PDT)
Message-ID: <48037BA4.6070201@gmail.com>
Date: Mon, 14 Apr 2008 17:43:32 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>	<20080411221817.0b1eb414.akpm@linux-foundation.org>	<48035E93.6070300@freescale.com>
	<48035F98.1020404@gmail.com>	<48036001.10905@freescale.com>
	<4803620C.6020905@gmail.com>	<48036649.6000409@freescale.com>
	<4803690A.3080105@gmail.com> <48036F00.6080200@freescale.com>
In-Reply-To: <48036F00.6080200@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 04/14/2008 04:49 PM, Timur Tabi wrote:
> Jiri Slaby wrote:
>> On 04/14/2008 04:12 PM, Timur Tabi wrote:
>>> Unfortunately, the author of the patch, York, is out this week, so I'll have to
>>> take care of this.  It'd be easier to modify rh_alloc() so that it doesn't
>>> sleep, so that's what I'm going to do.
>> Anyway, why do you need the spin lock there (and not mutex)? 
> 
> I don't know.  A spinlock just seemed obvious.  Why would I prefer a mutex?

Mainly because you can sleep inside locked mutex and because spinlock shouldn't
be used for too many lines of code (busy waiting etc.). I think ldd3 will be
more descriptive than me here :).
