Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 9C6E267A33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 05:41:57 +1000 (EST)
Message-ID: <4266B082.10705@mvista.com>
Date: Wed, 20 Apr 2005 12:41:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Suresh Chandra Mannava <msuresh@gamebox.net>
References: <4219A711.80204@gamebox.net> <421B666B.205@mvista.com>
	<4266A320.20102@gamebox.net>
In-Reply-To: <4266A320.20102@gamebox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Marvell 64360, MPSC Serial Console Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Suresh Chandra Mannava wrote:

> <snip>
>
> We faced a problem in MPSC serial console part.  The problem is,  in 
> Serial console data is received once after 32 characters are typed.
>
> Any thing less than  32 characters  is not  echoed or not transmitted 
> till the 32 character count is reached.
>
> After carefully reviewing the code. We found that the receive buffer 
> size is initialised to 32 bytes.
> We made a small correction in the code by making the receive buffer 
> size to 1
> rxre->bufsize = 1;

<snip>

Suresh,

I think you fixed a symptom but not the problem.  By default, the rx 
buffers are indeed 32 bytes long (i.e., a cacheline in size).  When 
receiving, the mpsc will generate an interrupt when there is an error, 
when the buffer is full (32 bytes--unlikely if you're typing), or after 
a timeout.  I suspect your timeout value is bogus so you don't get the 
interrupt until you fill the buffer with 32 bytes.  Please compare the 
platform_data that you pass to the mpsc driver to other, working systems 
that use the mpsc (e.g., katana and cpci690).  In particular, look at 
your 'max_idle' value.

Mark
