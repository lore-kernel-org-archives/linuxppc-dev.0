Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 978ADDE05E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 03:33:39 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3CHXZXD006999
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:33:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3CHXZV4275954
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:33:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3CHXZM0003812
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 13:33:35 -0400
Date: Thu, 12 Apr 2007 12:33:34 -0500
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
Message-ID: <20070412173334.GP4747@austin.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2007 at 11:14:36AM -0500, Will Schmidt wrote:
> +/*
> + * timeout will vary between the MIN and MAX values defined here.  By default
> + * and during console activity we will use a default MIN_TIMEOUT of 10.  When
> + * the console is idle, we increase the timeout value on each pass through
> + * msleep until we reach the max.  This may be noticeable as a brief (average
> + * one second) delay on the console before the console responds to input when
> + * there has been no input for some time.
> + */
> +#define MIN_TIMEOUT		(10)
> +#define MAX_TIMEOUT		(2000)

[...]
> +				msleep_interruptible(timeout);


These values are milliseconds (that's what the m in msleep stands for
or at least it did last time I looked). This 10 is 1/100 of a second,
which makes a responsive keyboard for even a very very fast typist.
That's fine.  But 2000 is two seconds, which is longer than the amount 
of time that I wait before I start panicking that something is broken. 

I'd suggest that maybe 1000 or 750 or 500 is more apropriate.

--linas
