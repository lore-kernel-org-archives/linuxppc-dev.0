Return-Path: <msuresh@gamebox.net>
Received: from smtp-out.hotpop.com (smtp-out.hotpop.com [38.113.3.61])
	by ozlabs.org (Postfix) with ESMTP id 1570267A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 15:00:58 +1000 (EST)
Received: from gamebox.net (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8C7EE10B7398
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 05:00:52 +0000 (UTC)
Message-ID: <426886A9.6050809@gamebox.net>
Date: Fri, 22 Apr 2005 10:37:53 +0530
From: Suresh Chandra Mannava <msuresh@gamebox.net>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-embedded@ozlabs.org
References: <4219A711.80204@gamebox.net> <421B666B.205@mvista.com>
	<4266A320.20102@gamebox.net> <4266B082.10705@mvista.com>
In-Reply-To: <4266B082.10705@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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


>
>
> Suresh,
>
> I think you fixed a symptom but not the problem.  By default, the rx 
> buffers are indeed 32 bytes long (i.e., a cacheline in size).  When 
> receiving, the mpsc will generate an interrupt when there is an error, 
> when the buffer is full (32 bytes--unlikely if you're typing), or 
> after a timeout.  I suspect your timeout value is bogus so you don't 
> get the interrupt until you fill the buffer with 32 bytes.  Please 
> compare the platform_data that you pass to the mpsc driver to other, 
> working systems that use the mpsc (e.g., katana and cpci690).  In 
> particular, look at your 'max_idle' value.
>
> Mark
>
>

Mr. Mark,

Thank you for your reply. You exactly pointed out the mistake I had done 
with max_idle.
I didn't initialized the mpsc_pdata structure in platform dependent 
file. Now I initialized max_idle =40.
And every thing is working fine.

Still facing some problems with mv64360 giga Ethernet driver. I will 
come back after a little bit of investigation.

Regards,
Suresh Chandra Mannava
